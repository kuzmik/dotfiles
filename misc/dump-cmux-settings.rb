#!/usr/bin/env ruby
# frozen_string_literal: true

# Materialize every cmux setting into the chezmoi-managed cmux.json.
#
# cmux resolves settings highest-wins:
#
#   1. ~/.config/cmux/cmux.json     <- what this script writes
#   2. Settings UI (defaults read com.cmuxterm.app)
#   3. legacy settings.json (config dir, then App Support)
#   4. built-in defaults
#
# Anything written to cmux.json is pinned; the Settings UI can no longer change
# it. The file is built from three sources, in increasing precedence:
#
#   base      the existing cmux.json -- keeps keys neither the schema nor
#             NSUserDefaults expose, notably all ~138 shortcuts.bindings
#             entries and the workspaceColors palette
#   schema    published defaults, for keys the base is missing
#   defaults  the live Settings UI store, which is authoritative
#
# The Settings UI stores its values under different key names than cmux.json
# uses, so DEFAULTS_MAP does the translation. Unrecognized keys are reported
# rather than silently dropped -- when cmux adds a setting, this script tells
# you to map it.
#
# Re-running is idempotent.
#
# Usage: ./dump-cmux-settings.rb [--dry-run]

require 'json'
require 'open-uri'
require 'rexml/document'

SOURCE = File.expand_path('private_dot_config/private_cmux/private_cmux.json', __dir__)
TARGET = File.expand_path('~/.config/cmux/cmux.json')
SCHEMA_URL = 'https://raw.githubusercontent.com/manaflow-ai/cmux/main/web/data/cmux.schema.json'
DOMAIN = 'com.cmuxterm.app'

INVERT = ->(v) { !v }
PARSE_JSON = ->(v) { JSON.parse(v) }
# cmux stores "no max width" as -1 in defaults but as false in cmux.json.
WIDTH = ->(v) { v.is_a?(Numeric) && v.negative? ? false : v }

# Settings UI key => [cmux.json path, coercion]
DEFAULTS_MAP = {
  # app
  'appLanguage' => ['app.language', nil],
  'appearanceMode' => ['app.appearance', nil],
  'appIconMode' => ['app.appIcon', nil],
  'windowTitleTemplate' => ['app.windowTitleTemplate', nil],
  'menuBarOnly' => ['app.menuBarOnly', nil],
  'newWorkspacePlacement' => ['app.newWorkspacePlacement', nil],
  'agentConversationForkDefaultDestination' => ['app.forkConversationDefaultDestination', nil],
  'workspaceInheritWorkingDirectory' => ['app.workspaceInheritWorkingDirectory', nil],
  'workspacePresentationMode' => ['app.minimalMode', ->(v) { v == 'minimal' }],
  'closeWorkspaceOnLastSurfaceShortcut' => ['app.keepWorkspaceOpenWhenClosingLastSurface', INVERT],
  'paneFirstClickFocus.enabled' => ['app.focusPaneOnFirstClick', nil],
  'focusHistoryIncludesPanesAndTabs' => ['app.focusHistoryIncludesPanesAndTabs', nil],
  'preferredEditorCommand' => ['app.preferredEditor', nil],
  'openSupportedFilesInCmux' => ['app.openSupportedFilesInCmux', nil],
  'openMarkdownInCmuxViewer' => ['app.openMarkdownInCmuxViewer', nil],
  'globalFontMagnificationPercent' => ['app.globalFontMagnification', nil],
  'workspaceAutoReorderOnNotification' => ['app.reorderOnNotification', nil],
  'app.iMessageMode' => ['app.iMessageMode', nil],
  'sendAnonymousTelemetry' => ['app.sendAnonymousTelemetry', nil],
  'confirmQuit' => ['app.confirmQuit', nil],
  'warnBeforeQuitShortcut' => ['app.warnBeforeQuit', nil],
  'warnBeforeClosingTabShortcut' => ['app.warnBeforeClosingTab', nil],
  'warnBeforeClosingTabXButton' => ['app.warnBeforeClosingTabXButton', nil],
  'hideTabCloseButton' => ['app.hideTabCloseButton', nil],
  'commandPalette.renameSelectAllOnFocus' => ['app.renameSelectsExistingName', nil],
  'commandPalette.switcherSearchAllSurfaces' => ['app.commandPaletteSearchesAllSurfaces', nil],

  # workspaceGroups
  'workspaceGroup.newWorkspacePlacement' => ['workspaceGroups.newWorkspacePlacement', nil],

  # terminal
  'terminal.showScrollBar' => ['terminal.showScrollBar', nil],
  'terminal.scrollSpeed' => ['terminal.scrollSpeed', nil],
  'terminal.sessionContentMaxWidth' => ['terminal.sessionContentMaxWidth', WIDTH],
  'terminal.sessionContentAlignment' => ['terminal.sessionContentAlignment', nil],
  'terminal.copyOnSelect' => ['terminal.copyOnSelect', nil],
  'terminal.autoResumeAgentSessions' => ['terminal.autoResumeAgentSessions', nil],
  'terminal.showTextBoxOnNewTerminals' => ['terminal.showTextBoxOnNewTerminals', nil],
  'terminal.focusTextBoxOnNewTerminals' => ['terminal.focusTextBoxOnNewTerminals', nil],
  'terminal.agentHibernation.enabled' => ['terminal.agentHibernation.enabled', nil],
  'terminal.agentHibernation.idleSeconds' => ['terminal.agentHibernation.idleSeconds', nil],
  'terminal.agentHibernation.maxLiveTerminals' => ['terminal.agentHibernation.maxLiveTerminals', nil],
  'terminal.rendererRealization.enabled' => ['terminal.rendererRealization.enabled', nil],
  'terminal.rendererRealization.idleSeconds' => ['terminal.rendererRealization.idleSeconds', nil],
  'terminal.rendererRealization.maxWarmRenderers' => ['terminal.rendererRealization.maxWarmRenderers', nil],
  'terminal.textBoxMaxLines' => ['terminal.textBoxMaxLines', nil],
  'terminal.textBoxDefaultSubmitAction' => ['terminal.textBoxDefaultSubmitAction', nil],
  'terminal.textBoxSubmitActions' => ['terminal.textBoxSubmitActions', PARSE_JSON],

  # notifications
  'notificationDockBadgeEnabled' => ['notifications.dockBadge', nil],
  'showMenuBarExtra' => ['notifications.showInMenuBar', nil],
  'notificationPaneRingEnabled' => ['notifications.unreadPaneRing', nil],
  'notificationPaneFlashEnabled' => ['notifications.paneFlash', nil],
  'notificationsSuppressOnlyFocusedSurface' => ['notifications.suppressOnlyFocusedSurface', nil],
  'notificationAgentPermissionPromptEnabled' => ['notifications.agentPermissionPrompt', nil],
  'notificationAgentTurnComplete' => ['notifications.agentTurnComplete', nil],
  'notificationAgentIdleReminderEnabled' => ['notifications.agentIdleReminder', nil],
  'notificationSound' => ['notifications.sound', nil],
  'notificationSoundCustomFilePath' => ['notifications.customSoundFilePath', nil],
  'notificationCustomCommand' => ['notifications.command', nil],

  # sidebar
  'sidebarHideAllDetails' => ['sidebar.hideAllDetails', nil],
  'sidebarWrapWorkspaceTitles' => ['sidebar.wrapWorkspaceTitles', nil],
  'sidebarShowWorkspaceDescription' => ['sidebar.showWorkspaceDescription', nil],
  'sidebarWorkspaceTodosChecklistStyle' => ['sidebar.beta.workspaceTodos.checklistStyle', nil],
  'sidebar.beta.workspaceTodos.controls.enabled' => ['sidebar.beta.workspaceTodos.controls.enabled', nil],
  'sidebarBranchVerticalLayout' => ['sidebar.branchLayout', ->(v) { v ? 'vertical' : 'inline' }],
  'sidebarShowNotificationMessage' => ['sidebar.showNotificationMessage', nil],
  'sidebarNotificationMessageLineLimit' => ['sidebar.notificationMessageLineLimit', nil],
  'sidebarShowBranchDirectory' => ['sidebar.showBranchDirectory', nil],
  'sidebarBranchDirectoryStacked' => ['sidebar.stackBranchDirectory', nil],
  'sidebarPathLastSegmentOnly' => ['sidebar.pathLastSegmentOnly', nil],
  'sidebarShowPullRequest' => ['sidebar.showPullRequests', nil],
  'sidebarWatchGitStatus' => ['sidebar.watchGitStatus', nil],
  'sidebarMakePullRequestClickable' => ['sidebar.makePullRequestsClickable', nil],
  'browserOpenSidebarPullRequestLinksInCmuxBrowser' => ['sidebar.openPullRequestLinksInCmuxBrowser', nil],
  'browserOpenSidebarPortLinksInCmuxBrowser' => ['sidebar.openPortLinksInCmuxBrowser', nil],
  'sidebarShowSSH' => ['sidebar.showSSH', nil],
  'sidebarShowPorts' => ['sidebar.showPorts', nil],
  'sidebarShowLog' => ['sidebar.showLog', nil],
  'sidebarShowProgress' => ['sidebar.showProgress', nil],
  'sidebarShowAgentActivity' => ['sidebar.showAgentActivity', nil],
  'sidebarLoadingSpinnerPosition' => ['sidebar.loadingSpinnerPosition', nil],
  'sidebarNotificationBadgePosition' => ['sidebar.notificationBadgePosition', nil],

  # workspaceColors / sidebarAppearance
  'sidebarActiveTabIndicatorStyle' => ['workspaceColors.indicatorStyle', nil],
  'sidebarMatchTerminalBackground' => ['sidebarAppearance.matchTerminalBackground', nil],
  'sidebarTintHex' => ['sidebarAppearance.tintColor', nil],
  'sidebarTintOpacity' => ['sidebarAppearance.tintOpacity', nil],

  # automation
  'socketControlMode' => ['automation.socketControlMode', nil],
  'claudeCodeHooksEnabled' => ['automation.claudeCodeIntegration', nil],
  'claudeCodeCustomClaudePath' => ['automation.claudeBinaryPath', nil],
  'workspaceAutoNamingEnabled' => ['automation.workspaceAutoNaming', nil],
  'autoNamingAgent' => ['automation.autoNamingAgent', nil],
  'ripgrepCustomBinaryPath' => ['automation.ripgrepBinaryPath', nil],
  'suppressSubagentNotifications' => ['automation.suppressSubagentNotifications', nil],
  'ampHooksEnabled' => ['automation.ampIntegration', nil],
  'cursorHooksEnabled' => ['automation.cursorIntegration', nil],
  'geminiHooksEnabled' => ['automation.geminiIntegration', nil],
  'kiroHooksEnabled' => ['automation.kiroIntegration', nil],
  'kiroNotificationLevel' => ['automation.kiroNotificationLevel', nil],
  'cmuxPortBase' => ['automation.portBase', nil],
  'cmuxPortRange' => ['automation.portRange', nil],

  # browser
  'browserSearchEngine' => ['browser.defaultSearchEngine', nil],
  'browserCustomSearchEngineName' => ['browser.customSearchEngineName', nil],
  'browserCustomSearchEngineURLTemplate' => ['browser.customSearchEngineURLTemplate', nil],
  'browserSearchSuggestionsEnabled' => ['browser.showSearchSuggestions', nil],
  'browserThemeMode' => ['browser.theme', nil],
  'browserHiddenWebViewDiscardEnabled' => ['browser.discardHiddenWebViews', nil],
  'browserHiddenWebViewDiscardDelaySeconds' => ['browser.hiddenWebViewDiscardDelaySeconds', nil],
  'browserAskWhereToSaveDownloads' => ['browser.askWhereToSaveDownloads', nil],
  'browserOpenTerminalLinksInCmuxBrowser' => ['browser.openTerminalLinksInCmuxBrowser', nil],
  'browserInterceptTerminalOpenCommandInCmuxBrowser' => ['browser.interceptTerminalOpenCommandInCmuxBrowser', nil],
  'browserHostWhitelist' => ['browser.hostsToOpenInEmbeddedBrowser', nil],
  'browserExternalOpenPatterns' => ['browser.urlsToAlwaysOpenExternally', nil],
  'browserInsecureHTTPAllowlist' => ['browser.insecureHttpHostsAllowedInEmbeddedBrowser', nil],
  'browserImportHintShowOnBlankTabs' => ['browser.showImportHintOnBlankTabs', nil],
  'reactGrabVersion' => ['browser.reactGrabVersion', nil],

  # misc panes
  'mobile.artifactFolderAccess' => ['mobile.artifactFolderAccess', nil],
  'markdown.fontSize' => ['markdown.fontSize', nil],
  'markdown.fontFamily' => ['markdown.fontFamily', nil],
  'markdown.maxWidth' => ['markdown.maxWidth', nil],
  'fileEditor.wordWrap' => ['fileEditor.wordWrap', nil],
  'fileExplorerDoubleClickAction' => ['fileExplorer.doubleClickAction', nil],
  'showModifierHoldHints' => ['shortcuts.showModifierHoldHints', nil]
}.freeze

# Window geometry, telemetry, migration stamps, and settings cmux keeps only in
# NSUserDefaults: sidebarPreset/Material/BlendMode/CornerRadius/BlurOpacity/
# State and rightSidebar.mode have no cmux.json equivalent, so they stay
# UI-managed. sidebarShowStatusPills has no confident schema counterpart.
SKIP_EXACT = %w[
  SUEnableAutomaticChecks SULastCheckTime SUUpdateGroupIdentifier
  cmuxDisableBundleIconPersistence cmuxWelcomeShown fileExplorer.width
  rightSidebar.mode selectedSettingsSection selectedSettingsSidebarEntry
  sidebarAppearanceDefaultsVersion sidebarBlendMode sidebarBlurOpacity
  sidebarCornerRadius sidebarMaterial sidebarPreset sidebarShowStatusPills
  sidebarState socketControlPasswordMigrationVersion
].freeze

SKIP_PREFIX = [
  'NSWindow Frame',
  'browserProfiles.',
  'cmux.auth.',
  'cmux.flags.',
  'cmux.session.',
  'cmux.settingsFile.',
  'cmux.sparkle.',
  'ghosttyCrashBreadcrumb.',
  'posthog.',
  'workspaceCustomizations.'
].freeze

HEADER = <<~TEXT
  // cmux settings -- fully materialized. Generated by dump-cmux-settings.rb;
  // edit that script (or this file) rather than the Settings UI, which cannot
  // override anything present here. Delete a key to hand it back to Settings.
  // Apply with: chezmoi apply ~/.config/cmux/cmux.json && cmux reload-config
TEXT

# Parse JSONC. Only handles whole-line // comments, which is all we emit.
def load_jsonc(path)
  JSON.parse(File.read(path).gsub(%r{^[ \t]*//.*$}, ''))
end

# Collect explicit non-null defaults. Null-defaulted keys are skipped: an
# explicit null on e.g. shortcuts.bindings.* would unbind the shortcut.
def schema_defaults(node)
  (node['properties'] || {}).each_with_object({}) do |(key, prop), out|
    next if %w[$schema schemaVersion].include?(key)

    if prop.key?('properties')
      nested = schema_defaults(prop)
      out[key] = nested unless nested.empty?
    elsif !prop['default'].nil?
      out[key] = prop['default']
    end
  end
end

# Dotted path => declared JSON type, used to fix up plist representations.
def schema_types(node, prefix = '')
  (node['properties'] || {}).each_with_object({}) do |(key, prop), out|
    path = prefix.empty? ? key : "#{prefix}.#{key}"
    if prop.key?('properties')
      out.merge!(schema_types(prop, path))
    else
      out[path] = prop['type']
    end
  end
end

# macOS defaults stores cmux's list settings as one newline-delimited string and
# some of its integers as <real>. Reshape both to what the schema declares.
def normalize(path, value, types)
  case types[path]
  when 'integer', 'number'
    value.is_a?(Float) && value == value.truncate ? value.to_i : value
  when 'array'
    value.is_a?(String) ? value.split(/\r?\n/).map(&:strip).reject(&:empty?) : value
  else
    value
  end
end

def deep_merge(base, over)
  base.merge(over) do |_key, old, new|
    old.is_a?(Hash) && new.is_a?(Hash) ? deep_merge(old, new) : new
  end
end

def assign(tree, dotted, value)
  parts = dotted.split('.')
  leaf = parts[0..-2].inject(tree) { |node, part| node[part] ||= {} }
  leaf[parts[-1]] = value
end

# `plutil -convert json` refuses the <data> blobs cmux keeps in its defaults, so
# parse the XML plist directly. Returns [overrides, unmapped_keys].
def plist_value(el)
  case el.name
  when 'true' then true
  when 'false' then false
  when 'string' then el.text.to_s
  when 'integer' then el.text.to_i
  when 'real' then el.text.to_f
  when 'array' then el.elements.map { |child| plist_value(child) }
  else :unsupported
  end
end

def read_ui_defaults(types)
  xml = `defaults export #{DOMAIN} -`
  raise "defaults export #{DOMAIN} failed" unless $?.success?

  overrides = {}
  unmapped = []
  pending = nil

  REXML::Document.new(xml).elements['plist/dict'].elements.each do |el|
    if el.name == 'key'
      pending = el.text
      next
    end
    next if pending.nil?

    name = pending
    pending = nil
    next if SKIP_EXACT.include?(name) || SKIP_PREFIX.any? { |p| name.start_with?(p) }

    value = plist_value(el)
    next if value == :unsupported

    unless DEFAULTS_MAP.key?(name)
      unmapped << name
      next
    end

    path, coerce = DEFAULTS_MAP[name]
    value = coerce.call(value) if coerce
    assign(overrides, path, normalize(path, value, types))
  end

  [overrides, unmapped.sort]
end

def sort_deep(value)
  case value
  when Hash then value.keys.sort.each_with_object({}) { |k, h| h[k] = sort_deep(value[k]) }
  when Array then value.map { |v| sort_deep(v) }
  else value
  end
end

def count_leaves(node)
  node.values.sum { |v| v.is_a?(Hash) ? count_leaves(v) : 1 }
end

dry_run = ARGV.include?('--dry-run')

config = File.exist?(SOURCE) ? load_jsonc(SOURCE) : {}
config.delete('$schema')
config.delete('schemaVersion')

types = {}
begin
  schema = JSON.parse(URI.parse(SCHEMA_URL).open(read_timeout: 15).read)
  types = schema_types(schema)
  config = deep_merge(schema_defaults(schema), config)
rescue StandardError => e
  warn "warning: schema fetch failed (#{e.message}); list/integer types unverified"
end

overrides, unmapped = read_ui_defaults(types)
config = deep_merge(config, overrides)

unless unmapped.empty?
  warn 'warning: unmapped Settings UI keys (add to DEFAULTS_MAP or SKIP_*):'
  unmapped.each { |k| warn "  #{k}" }
end

document = { '$schema' => SCHEMA_URL, 'schemaVersion' => 1 }.merge(sort_deep(config))
text = HEADER + JSON.pretty_generate(document) + "\n"

if dry_run
  puts "would write #{text.bytesize} bytes, #{count_leaves(config)} settings to #{SOURCE}"
  exit
end

if File.exist?(TARGET)
  backup = "#{TARGET}.#{Time.now.strftime('%Y%m%d-%H%M%S')}.bak"
  File.write(backup, File.read(TARGET))
  puts "backed up #{TARGET} -> #{backup}"
end

File.write(SOURCE, text)
puts "wrote #{count_leaves(config)} settings to #{SOURCE}"
puts 'next: chezmoi apply ~/.config/cmux/cmux.json && cmux reload-config'
