# vim:set noet: 
.PHONY : usage vim conky fonts git

usage:

	@echo "Usage: "
	@echo "  make item(s)"
	@echo "items can be:"
	@echo "  vim fonts conky git tmux sakura bash"
	@echo "use 'make all' to setup all."

fonts:

	mkdir -p ~/.fonts
	cp $(CURDIR)/fonts/.fonts/*  ~/.fonts

powerline: fonts

	pip install --upgrade git+git://github.com/Lokaltog/powerline
	mkdir -p ~/.config/powerline/themes

vim: powerline

	# install vundle 
	git submodule update --init vim/vundle
	mkdir -p ~/.vim/bundle/ 
	ln -s $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	# vimrc
	ln -s $(CURDIR)/vim/.vimrc ~/.vimrc
	vim -c "BundleInstall"

conky:

	ln -s $(CURDIR)/conky/.conkyrc ~/.conkyrc
	ln -s $(CURDIR)/conky/.conky ~/.conky

git:

	ln -s $(CURDIR)/git/.gitconfig ~/.gitconfig

tmux: powerline

	# powerline for tmux
	mkdir -p ~/.config/powerline/themes/tmux
	ln -s $(CURDIR)/powerline/themes/tmux/default.json  ~/.config/powerline/themes/tmux/default.json
	ln -s $(CURDIR)/tmux/.tmux.conf ~/.tmux.conf

bash: fonts

	git submodule update --init dircolors-solarized
	ln -s $(CURDIR)/dircolors-solarized/dircolors.256dark ~/dircolors.256dark
	pip install --upgrade git+git://github.com/hit9/powerline-shell
	ln -s $(CURDIR)/bash/.bashrc ~/.bashrc

sakura: fonts

	ln -s $(CURDIR)/sakura/.config/sakura/sakura.conf  ~/.config/sakura/sakura.conf

all: bash vim tmux sakura git conky
