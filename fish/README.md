Fish
----

References:

* fish shell: https://fishshell.com
* fisher plugin manager: https://github.com/jorgebucaran/fisher
* colorscheme: https://github.com/pure-fish/pure
* blog (chinese): https://writings.sh/post/commandline-tools#shell--fish

Files:

* `~/.config/fish/config.fish`: Fish shell configuration.
* `~/.config/fish/fishfile`: fisher plugins.

Notes:

1. Install plugins: `fisher update`

Plugins:

1. [hit9/fish-pyenv](https://github.com/hit9/fish-pyenv) - fast pyenv by lazy initialization.
2. [jethrokuan/z](https://github.com/jethrokuan/z) - jumping between directories.

Functions:

1. `Ctrl-X` to edit command buffer.
2. `dotenv` to load environment variables from file (without extral tools), and `dotenv-erase`
3. Fancy greeting message via fast [lolcat (in C)](https://github.com/jaseg/lolcat)
