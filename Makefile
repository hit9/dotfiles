# vim:set noet: 
.PHONY : usage vim conky fonts

usage:

	@echo "Usage: "
	@echo "  make item(s)"
	@echo "items can be:"
	@echo "  vim fonts conky git tmux sakura bash"
	@echo "use 'make all' to setup all."

fonts:

	mkdir -p ~/.fonts
	cp $(CURDIR)/fonts/.fonts/*  ~/.fonts

vim: fonts

	git submodule update --init vim/vundle
	pip install --user --upgrade git+git://github.com/Lokaltog/powerline
	ln -s $(CURDIR)/vim/.vimrc ~/.vimrc
	mkdir -p ~/.vim/bundle/ 
	ln -s $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	vim -c "BundleInstall"

conky:

	ln -s $(CURDIR)/conky/.conkyrc ~/.conkyrc
	ln -s $(CURDIR)/conky/.conky ~/.conky

git:

	ln -s $(CURDIR)/git/.gitconfig ~/.gitconfig

tmux: fonts

	git submodule update --init tmux-powerline
	ln -s $(CURDIR)/tmux/.tmux.conf ~/.tmux.conf

bash: fonts

	git submodule update --init dircolors-solarized
	pip install --user --upgrade git+git://github.com/hit9/powerline-shell
	ln -s $(CURDIR)/bash/.bashrc ~/.bashrc

sakura: fonts

	ln -s $(CURDIR)/sakura/.config/sakura/sakura.conf  ~/.config/sakura/sakura.conf

all: bash vim tmux sakura git conky
