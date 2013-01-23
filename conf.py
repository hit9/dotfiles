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
fonts.files = ("fonts/.fonts",)
fonts.install = fonts.lns_to_home

# vim-powerline
vim_powerline.name = "vim-powerline"


def vim_powerline_install():
    try:
        import powerline
    except ImportError:
        cmd = "pip install git+git://github.com/Lokaltog/powerline"
        print color("yellow", cmd)
        os.system(cmd)
    # install vundle
    dst_dir = os.path.join(home_abs_path, ".vim/bundle/vundle")
    cmd = "git clone https://github.com/gmarik/vundle.git " + dst_dir
    rm_if_exists(dst_dir)
    print color("yellow", cmd)
    os.system(cmd)

vim_powerline.install = vim_powerline_install


# vim
vim.name = "vim"
vim.files = ("vim/.vimrc",)
vim.depence = (fonts, vim_powerline)
vim.install = vim.lns_to_home
vim.after_install_msg = "Please run this command in vim: BundleInstall."
