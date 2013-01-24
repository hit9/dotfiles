# vim:set noet: 
.PHONY : usage vim conky fonts git tmux sakura bash

usage:

	@echo "Usage: "
	@echo "  make item(s) force=1/0"
	@echo "items can be:"
	@echo "  vim fonts conky git tmux sakura bash"
	@echo "make vim conky force=1   to force setup vim,conky"
	@echo "make all                 to setup all."

LNSOPT=-s

ifdef force
	ifeq ($(force),1)
		LNSOPT=-fs
	endif
endif

submodule:

	@echo "Update submodules .. "
	git submodule init
	git submodule update 

fonts:

	mkdir -p ~/.fonts
	cp $(CURDIR)/fonts/.fonts/*  ~/.fonts
	fc-cache -vf ~/.fonts 

powerline: fonts submodule

	cd Lokaltog-powerline; git checkout develop; git pull ; python setup.py install
	mkdir -p ~/.config/powerline/themes
	mkdir -p ~/.config/powerline/colorschemes

vim: powerline submodule

	cd vim/vundle ; git checkout master ; git pull;
	mkdir -p ~/.vim/bundle/ 
	ln $(LNSOPT) $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	ln $(LNSOPT) $(CURDIR)/vim/.vimrc ~/.vimrc
	vim -c "BundleInstall"

tmux: powerline

	mkdir -p ~/.config/powerline/themes/tmux
	ln $(LNSOPT) $(CURDIR)/powerline/themes/tmux/default.json  ~/.config/powerline/themes/tmux/default.json
	ln $(LNSOPT) $(CURDIR)/tmux/.tmux.conf  ~/.tmux.conf

conky:

	ln $(LNSOPT) $(CURDIR)/conky/.conkyrc ~/.conkyrc
	ln $(LNSOPT) $(CURDIR)/conky/.conky ~/.conky

git:

	ln $(LNSOPT) $(CURDIR)/git/.gitconfig ~/.gitconfig

bash: fonts submodule

	cd dircolors-solarized; git checkout master ; git pull ;
	ln $(LNSOPT) $(CURDIR)/dircolors-solarized/dircolors.256dark ~/dircolors.256dark
	cd powerline-shell; git checkout master; git pull ; python setup.py install
	ln $(LNSOPT) $(CURDIR)/bash/.bashrc ~/.bashrc

sakura: fonts

	ln $(LNSOPT) $(CURDIR)/sakura/.config/sakura/sakura.conf  ~/.config/sakura/sakura.conf

all: sakura git conky bash tmux vim
