# Set the filehandler of all plain text files (code, data, unix executables [hopefully scripts])
# to sublimetext4. Requires `duti` and `yq` to be installed, just use brew
# from https://apple.stackexchange.com/a/123954

brew install duti yq

curl -s "https://raw.githubusercontent.com/github/linguist/master/lib/linguist/languages.yml" \
        | yq -r "to_entries | (map(.value.extensions) | flatten) - [null] | unique | .[]" \
        | xargs -L 1 -I "{}" duti -s com.sublimetext.4 {} all
duti -s com.sublimetext.4 public.unix-executable all
duti -s com.sublimetext.4 public.data all
