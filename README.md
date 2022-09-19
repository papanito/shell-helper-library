# shell-helper-library

[![Gitlab issues](https://img.shields.io/gitlab/issues/open-raw/papanito/shell-helper-library)](https://gitlab.com/papanito/shell-helper-library/-/issues) [![Gitlab merge requests](https://img.shields.io/gitlab/merge-requests/open/papanito/shell-helper-library)](https://gitlab.com/papanito/shell-helper-library/-/merge_requests) [![GitLab contributors](https://img.shields.io/gitlab/contributors/papanito/shell-helper-library)](https://img.shields.io/gitlab/contributors/papanito/shell-helper-library) [![GitLab](https://img.shields.io/gitlab/license/papanito/shell-helper-library)](https://img.shields.io/gitlab/license/papanito/shell-helper-library)

Contains a collection for useful functions and aliases. The files

## Usage

1. Declare `SHELL_HELPER_LIBRARY` somewhere in your `.bashrc` or `.zshrc`

   ```bash
   export SHELL_HELPER_LIBRARY="$HOME\.shell-helper-library
   ```

2. Clone this repo to `$SHELL_HELPER_LIBRARY`

   ```bash
   git clone https://gitlab.com/papanito/shell-helper-library $SHELL_HELPER_LIBRARY
   ```

3. Load functions

   * **ZSH** use a plugin-manager and load the plugin. I use [ZI], hence I have this in my `.zshrc`

     ```bash
     zi light papanito/shell-helper-library
     ```

   * **BASH** add ths to `.bash.rc`

    ```bash
    shell_helper=$SHELL_HELPER_LIBRARY/shell-helpers.plugin.bash
    if [ -f $shell_helper ]; then . $shell_helper ; fi
    ```

[ZI]: https://github.com/z-shell/zi