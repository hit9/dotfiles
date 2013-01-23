"""
conf.py for setup.py to manage these config files
"""

from item import *

import os

fonts = item()
vim_powerline = item()
vim = item()
tmux = item()
tmux_powerline = item()
sakura = item()
git = item()
bash = item()
dircolors_solarized = item()
conky = item()


# fonts
fonts.name = "fonts"
fonts.files = (".fonts",)
fonts.install = fonts.lns_to_home
fonts.after_install_msg="Please select the font: 'Inconsolata-g for Powerline.otf' for your terminal"

# vim-powerline
vim_powerline.name = "vim-powerline"


def vim_powerline_install():
    try:
        import powerline
    except ImportError:
        cmd = "pip install git+git://github.com/Lokaltog/powerline"
        print color("yellow", cmd)
        a = os.system(cmd)
        if a is not 0:
            exit(color("red","Failed to install powerline"))
    # install vundle
    dst_dir = os.path.join(home_abs_path, ".vim/bundle/vundle")
    cmd = "git clone https://github.com/gmarik/vundle.git " + dst_dir
    rm_if_exists(dst_dir)
    print color("yellow", cmd)
    b = os.system(cmd)
    if b is not 0:
        exit(color("red","Failed to clone vundle"))

vim_powerline.install = vim_powerline_install


# vim
vim.name = "vim"
vim.files = (".vimrc",)
vim.depence = (fonts, vim_powerline)
vim.install = vim.lns_to_home
vim.after_install_msg = "Please run this command in vim: BundleInstall"

# sakura

sakura.name="sakura"
sakura.files=('.config/sakura/sakura.conf',)
sakura.install=sakura.lns_to_home
