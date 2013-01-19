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
    "sakura": (".config/sakura/sakura.conf",)
}


def install_one(k):
    print "Install item: ", k
    v = dct[k]
    for i in v:
        src_abs = os.path.join(abs_path, os.path.join(k, i))
        des_abs = os.path.join(home_abs_path, i)
        des_dir=os.path.dirname(des_abs)
        if not os.path.exists(des_dir):
            os.makedirs(des_dir)

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
    print "See Readme.rst under directory " + k
else:
    for i in dct.keys():
        install_one(i)
    print "See Readme.rst under each sub directory."
