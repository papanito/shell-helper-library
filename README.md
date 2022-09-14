# shell-helper-library

Contains a collection for useful functions and aliases. The files

## Usage

1. Declare `SHELL_HELPER_LIBRARY` somewhere in your `.bashrc` or `.zshrc`

   ```
   export SHELL_HELPER_LIBRARY="$HOME\.shell-helper-library
   ```

2. Clone this repo to `$SHELL_HELPER_LIBRARY`

   ```bash
   git clone https://gitlab.com/papanito/shell-helper-library $SHELL_HELPER_LIBRARY
   ```
3. Add the following to your `.bashrc` or `.zshrc`

    ```bash
    # @description include functions from shell helper library
    # Clone https://gitlab.com/papanito/shell-helper-library to $SHELL_HELPER_LIBRARY
    function loadShellHelperLibray()
    {
    if [ -n "$SHELL_HELPER_LIBRARY" ] && [ -d "$SHELL_HELPER_LIBRARY" ]; then
        for filename in $(fine
        d $SHELL_HELPER_LIBRARY -name "*.sh" ); do
            source $filename
        done
    fi
    }
    loadShellHelperLibray
    ```
