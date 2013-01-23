#!/usr/bin/env python

import os


def help():
    exit("""
Usage:
Install.py [item(s)] [--force]
Usage sample:
Install.py  vim                to install .vimrc for vim
Install.py                     to install all
Install.py conky, vim --force  to force install conky, vim
""")

abs_path = os.path.abspath(".")

home_abs_path = os.path.expandvars("$HOME")

dct = {
    "vim": (".vimrc", ),
    "git": (".gitconfig", ),
    "tmux": (".tmux.conf", ),
    "conky": (".conkyrc", ".conky"),
    "sakura": (".config/sakura/sakura.conf",),
    "fonts": (".fonts", ),
    "bash": (".bashrc",)
}

force_install = False

fonts_installed = False  # mark if fonts installed

powerline_installed = False

colors_dct = {
    'red': '\033[91m',
    'green': '\033[92m',
    'yellow': '\033[93m',
    'blue': '\033[94m',
    'tail': '\033[0m'
}


def color_output(color, msg):
    print colors_dct[color] + msg + colors_dct['tail']


def color_return(color, msg):
    return colors_dct[color] + msg + colors_dct['tail']


def rm_if_exists(path):
    if os.path.exists(path):
        x = ''
        if force_install:
            x = 'yes'
        while x != 'yes' and x != 'no':
            x = raw_input(
                colors_dct['red'] +
                "Path " + path +
                " already exists, remove? (yes/no)" +
                colors_dct['tail'])

        if x == 'yes':
            color_output('yellow', 'Remove ' + path + ' ...')
            try:
                os.remove(path)
            except:
                try:
                    import shutil
                    shutil.rmtree(path)
                except Exception, e:
                    raise e
        else:
            exit(color_return('red', 'Abort.'))


def install_one(k):

    global fonts_installed, powerline_installed

    # install powerline for vim
    if k == "vim":
        try:
            import powerline
        except ImportError:
            cmd = "pip install git+git://github.com/Lokaltog/powerline"
            color_output(
                'yellow',
                cmd
            )
            code = os.system(cmd)
            if code is not 0:
                color_output("red", "Failed to install powerline.")
                exit()
            powerline_installed = True

    # install tmux-powerline for tmux

    if k == "tmux":

        cmd = "git clone https://github.com/erikw/tmux-powerline.git"
        color_output(
            'yellow',
            cmd
        )

        rm_if_exists("tmux-powerline")

        code = os.system(cmd)

        if code is not 0:
            color_output("red", "Failed to clone tmux-powerline.")
            exit()

        dst_abs = os.path.join(home_abs_path, "tmux-powerline")
        src_abs = os.path.abspath("tmux-powerline")
        rm_if_exists(dst_abs)
        os.symlink(src_abs, dst_abs)
        color_output('green', "Symbol link:" + src_abs + " -> " + dst_abs)
        powerline_installed = True

    if k == "bash":
        # install powerline-shell
        cmd = "pip install git+git://github.com/hit9/powerline-shell"
        color_output(
            'yellow',
            cmd
        )

        code = os.system(cmd)

        if code is not 0:
            color_output("red", "Failed to install powerline-shell.")
            exit()
            powerline_installed = True

        # install dircolors-solarized
        cmd = "git clone https://github.com/seebi/dircolors-solarized"
        color_output(
            'yellow',
            cmd
        )

        rm_if_exists("dircolors-solarized")

        code = os.system(cmd)

        if code is not 0:
            color_output("red", "Failed to clone dircolors-solarized.")
            exit()

        dst_abs = os.path.join(home_abs_path, "dircolors-solarized")
        src_abs = os.path.abspath("dircolors-solarized")
        rm_if_exists(dst_abs)
        os.symlink(src_abs, dst_abs)
        color_output('green', "Symbol link:" + src_abs + " -> " + dst_abs)

    if k in ("vim", "tmux", "sakura") and not fonts_installed:
        install_one("fonts")

    v = dct[k]
    for i in v:
        src_abs = os.path.join(abs_path, os.path.join(k, i))
        des_abs = os.path.join(home_abs_path, i)
        des_dir = os.path.dirname(des_abs)
        if not os.path.exists(des_dir):
            os.makedirs(des_dir)
        rm_if_exists(des_abs)
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
    color_output(
        'yellow',
        "Please select the font: 'Inconsolata-g for Powerline.otf' for your terminal."
    )
