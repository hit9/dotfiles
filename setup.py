import os


def help():
    exit("""
Usage:
  setup.py vim      to setup .vimrc for vim
  setup.py          to setup all
""")

abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")

dct = {
    "vim": (".vimrc", ),
    "git": (".gitconfig", ),
    "tmux": (".tmux.conf", ),
    "conky": (".conkyrc", ".conky"),
}


def install_one(k):
    print "Install item: ", k
    v = dct[k]
    for i in v:
        src_abs = os.path.join(abs_path, os.path.join(k, i))
        des_abs = os.path.join(home_abs_path, i)
        try:
            print " Create Symbol Link from ", src_abs, " to ", des_abs, " ..."
            os.symlink(src_abs, des_abs)
        except OSError, e:
            print "'" + des_abs + "' already exists."
            raise e

import sys

if len(sys.argv) > 2:
    help()

if len(sys.argv) == 2:
    k = sys.argv[1]
    if k not in dct:
        help()
    install_one(k)
else:
    for i in dct.keys():
        install_one(i)
