# vim:set noet: 

.PHONY : usage vim conky fonts

usage:

	@echo "Usage: make item(s)"
	@echo "items can be :"
	@echo "  vim fonts conky git tmux sakura bash"
	@echo "use 'make all' to setup all."
	@echo "use 'make rmall' to remove all target path."

submodule_update:

	git submodule update --init

fonts:

	ln  -s $(CURDIR)/fonts/.fonts ~/.fonts

vim: fonts submodule_update

	pip install --user --upgrade git+git://github.com/Lokaltog/powerline
	ln -s $(CURDIR)/vim/.vimrc ~/.vimrc
	mkdir -p ~/.vim/bundle/ 
	ln -s $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	@echo "Run this command in your vim: BundleInstall"

conky:

	ln -s $(CURDIR)/conky/.conkyrc ~/.conkyrc
	ln -s $(CURDIR)/conky/.conky ~/.conky

git:

	ln -s $(CURDIR)/git/.gitconfig ~/.gitconfig

tmux: fonts submodule_update

	ln -s $(CURDIR)/tmux/.tmux.conf ~/.tmux.conf

bash: fonts submodule_update

	pip install --user --upgrade git+git://github.com/hit9/powerline-shell
	ln -s $(CURDIR)/bash/.bashrc ~/.bashrc

sakura: fonts

	ln -s $(CURDIR)/sakura/.config/sakura/sakura.conf  ~/.config/sakura/sakura.conf

rmall:

	rm ~/.fonts
	rm ~/.config/sakura/sakura.conf
	rm ~/.tmux.conf
	rm ~/.vimrc
	rm ~/.gitconfig
	rm ~/.bashrc
	rm ~/.conkyrc
	rm ~/.conky

all: vim tmux sakura git bash conky
