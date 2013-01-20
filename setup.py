import os


def help():
    exit("""
Usage:
  setup.py [item] [args]
Usage sample:
  setup.py vim      to setup .vimrc for vim
  setup.py          to setup all
  setup.py --force  force install
""")

abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")

dct = {
    "vim": (".vimrc", ),
    "git": (".gitconfig", ),
    "tmux": (".tmux.conf", ),
    "conky": (".conkyrc", ".conky"),
    "sakura": (".config/sakura/sakura.conf",),
    "fonts": (".fonts", )
}

force_install = False

fonts_installed = False  # mark if fonts installed

colors_dct = {'red': '\033[91m', 'green': '\033[92m', 'yellow': '\033[93m', 'blue': '\033[94m', 'tail': '\033[0m'}


def color_output(color, msg):
    print colors_dct[color] + msg + colors_dct['tail']


def install_one(k):

    global fonts_installed

    if k in ("vim", "tmux", "sakura") and not fonts_installed:
        install_one("fonts")

    v = dct[k]
    for i in v:
        src_abs = os.path.join(abs_path, os.path.join(k, i))
        des_abs = os.path.join(home_abs_path, i)
        des_dir = os.path.dirname(des_abs)
        if not os.path.exists(des_dir):
            os.makedirs(des_dir)

        if os.path.exists(des_abs):
            if force_install:
                color_output('yellow', 'Remove ' + des_abs + ' ...')
                os.remove(des_abs)
            else:
                x = ''
                while x != 'yes' and x != 'no':
                    x = raw_input(colors_dct['red'] + "File " + des_abs + " already exists, replace? (yes/no)" + colors_dct['tail'])
                    if x == 'yes':
                        os.remove(des_abs)
                    elif x == 'no':
                        exit(colors_dct['red'] + 'Abort.' + colors_dct['tail'])
        print "Create Symbol Link from ", src_abs, " to ", des_abs, " ..."
        os.symlink(src_abs, des_abs)
        color_output('green', i + " installed as " + des_abs)

    if k == "fonts":
        print "Clean font cache.."
        os.system("fc-cache -vf " + des_abs)
        fonts_installed = True


import sys

args = sys.argv[1:]

for index, arg in enumerate(args):
    if arg == "--force":
        force_install = True
        args.pop(index)
        break

if args:
    for k in args:
        if k in dct:
            install_one(k)
        else:
            help()
    color_output('yellow', 'Please read the README under ' + ', '.join(args))
else:
    for k in dct.keys():
        install_one(k)
    color_output('yellow', "Plase read the README under each sub directory.")
