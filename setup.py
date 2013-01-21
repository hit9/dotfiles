import os


def help():
    exit("""
Usage:
  setup.py [item(s)] [--force]
Usage sample:
  setup.py vim      to setup .vimrc for vim
  setup.py          to setup all
  setup.py conky, vim--force  force install conky, vim
""")

abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")

dct = {
    "vim": (".vimrc", ),
    "git": (".gitconfig", ),
    "tmux": (".tmux.conf", "tmux-powerline"),
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

    # install powerline for vim
    if k == "vim":
        try:
            import powerline
        except ImportError:
            color_output('yellow', "install powerline from https://github.com/Lokaltog/powerline ...")
            code = os.system("pip install git+git://github.com/Lokaltog/powerline")
            if code is not 0:
                color_output("red", "Failed to install powerline.")
                exit()
    
    # install tmux-powerline for tmux

    if k == "tmux":
        color_output('yellow','Clone tmux-powerline from https://github.com/erikw/tmux-powerline ...')
        if os.path.exists("tmux-powerline"):
            os.removedirs("tmux-powerline")
        code = os.system("git clone https://github.com/erikw/tmux-powerline")
        if code is not 0:
            color_output("red", "Failed to clone tmux-powerline.")
            exit()
        tmux_powerline_abs = os.path.join(home_abs_path, "tmux-powerline")
        if os.path.exists(tmux_powerline_abs):
            os.remove(tmux_powerline_abs)
        os.symlink(os.path.abspath("tmux-powerline"), tmux_powerline_abs)

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
        os.symlink(src_abs, des_abs)
        color_output('green', "Symbol link:" + i + " -> " + des_abs)

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
    color_output('yellow', "Please read the README under each sub directory.")

if powerline_installed:
    color_output('yellow', "Please select the font: 'Inconsolata-g for Powerline.otf' for your terminal.")
