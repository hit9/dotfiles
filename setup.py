import os


abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")

dotfiles = [
    "vim/.vimrc",
    "vim/.gvimrc",
    "git/.gitconfig",
    "tmux/.tmux.conf"
]

for src in dotfiles:
    src_abs = os.path.join(abs_path, src)
    des_abs = os.path.join(home_abs_path, os.path.basename(src))
    try:
        os.symlink(src_abs, des_abs)
    except OSError,e:
        print "'"+des_abs+"' already exists."
        raise e

print "Done."
