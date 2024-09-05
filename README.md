# shell-helper-library

[![Gitlab issues](https://img.shields.io/gitlab/issues/open-raw/papanito/shell-helper-library)](https://gitlab.com/papanito/shell-helper-library/-/issues) [![Gitlab merge requests](https://img.shields.io/gitlab/merge-requests/open/papanito/shell-helper-library)](https://gitlab.com/papanito/shell-helper-library/-/merge_requests) [![GitLab contributors](https://img.shields.io/gitlab/contributors/papanito/shell-helper-library)](https://img.shields.io/gitlab/contributors/papanito/shell-helper-library) [![GitLab](https://img.shields.io/gitlab/license/papanito/shell-helper-library)](https://img.shields.io/gitlab/license/papanito/shell-helper-library)

Contains a collection for useful functions and aliases.

## Usage

### zsh

Use a plugin-manager and load the plugin. I use [zinit], hence I have this in my `.zshrc`

```bash
zi ice from"gitlab"
zi light papanito/shell-helper-library
```

### bash

1. Declare `SHELL_HELPER_LIBRARY` somewhere in your `.bashrc` or `.zshrc`

   ```bash
   export SHELL_HELPER_LIBRARY="$HOME\.shell-helper-library
   ```

2. Clone this repo to `$SHELL_HELPER_LIBRARY`

   ```bash
   git clone https://gitlab.com/papanito/shell-helper-library $SHELL_HELPER_LIBRARY
   ```

3. Load functions by adding this to `.bashrc`

    ```bash
    shell_helper=$SHELL_HELPER_LIBRARY/shell-helpers.plugin.bash
    if [ -f $shell_helper ]; then . $shell_helper ; fi
    ```

[zinit]: https://github.com/zdharma-continuum/zinit

## Content

* [archiving.sh](./archiving.md)
* [checksum.sh](./checksum.md)
* [conversion.sh](./conversion.md)
* [datetime.sh](./datetime.md)
* [debian.sh](./debian.md)
* [filesfolders.sh](./filesfolders.md)
* [find.sh](./find.md)
* [fun.sh](./fun.md)
* [math.sh](./math.md)
* [media.sh](./media.md)
* [networking.sh](./networking.md)
* [processes.sh](./processes.md)
* [python.sh](./python.md)
* [security.sh](./security.md)
* [shell.sh](./shell.md)
* [strings.sh](./strings.md)
* [system.sh](./system.md)
* [timer_stopwatch.sh](./timer_stopwatch.md)
* [translate.sh](./translate.md)
