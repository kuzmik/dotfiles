# Ghostty Mouse Bindings

Ghostty handles mouse interactions differently from Wezterm. Here's how the behavior has been emulated:

## Mouse Behavior

1. **Selection**: Click and drag to select text
   - In Ghostty, selection is automatically copied to clipboard (with `copy-on-select = true`)

2. **Link Opening**:
   - In Wezterm: CMD+click to open links
   - In Ghostty: This is automatically handled with `link-url = true`

3. **Special Mouse Behaviors**:
   - Ghostty supports cursor positioning at prompts with `cursor-click-to-move = true` (when shell integration is enabled)

4. **Mouse Wheel**:
   - Scrolls through terminal history
   - Can be adjusted with `mouse-scroll-multiplier` if needed

## Important Differences

Unlike Wezterm, Ghostty doesn't have a direct equivalent to the complex mouse bindings configuration. The following behaviors are handled differently:

1. Wezterm's customizable mouse bindings (like preventing window dragging) are handled differently in Ghostty
2. Ghostty's approach is more streamlined but less customizable for mouse interactions
3. Special mouse behaviors are typically handled through configuration options rather than explicit bindings

For complex mouse interactions, you may need to rely on the applications running inside the terminal (e.g., tmux, vim) to handle special mouse behaviors.