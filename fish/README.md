Fish
----

Files:

* `~/.config/fish/config.fish`: Fish shell configuration.
* `~/.config/fish/fishfile`: fisher plugins.

Plugins:

1. [hit9/fish-pyenv](https://github.com/hit9/fish-pyenv) - fast pyenv by lazy initialization.
2. [jethrokuan/z](https://github.com/jethrokuan/z) - jumping between directories.

Notes:

1. Install plugins: `fisher update`

Functions:

1. `Ctrl-X` to edit command buffer in `$EDITOR`.
2. `dotenv` to load environment variables from file (without extral tools), along with `dotenv-erase`.
3. Fancy greeting message via fast [lolcat (in C)](https://github.com/jaseg/lolcat)

References:

* fish shell: https://fishshell.com
* fisher plugin manager: https://github.com/jorgebucaran/fisher
* colorscheme: https://github.com/pure-fish/pure
* blog (chinese): https://writings.sh/post/commandline-tools#shell--fish

Commandline tools:

* [fzf](https://github.com/junegunn/fzf): `Ctrl-R` fuzzy command finder.
* [exa](https://github.com/ogham/exa): Very very fast `ls` replacement.
* [the_silver_searcher](https://github.com/ggreer/the_silver_searcher): Much faster than `ack` replacement.
* fortune (`brew install fortune`)
* cowsay (`brew install cowsay`)
* [oo](https://github.com/hit9/oo): Go version manager.
* [n](https://github.com/tj/n):  Node version manager.
* [pyenv](https://github.com/pyenv/pyenv): Python version manager.
