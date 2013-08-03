# vim:set noet:
.PHONY : vim tmux iterm2 zsh git conky sakura z

LNSOPT=-s

ifdef force
	ifeq ($(force),1)
		LNSOPT=-fs
	endif
endif

submodule:
	git submodule update --init

vim: submodule
	cd vim/vundle ; git checkout master ; git pull;
	mkdir -p ~/.vim/bundle/
	ln $(LNSOPT) $(CURDIR)/vim/vimrc ~/.vimrc
	ln $(LNSOPT) $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	vim -c "BundleInstall"


tmux:
	ln $(LNSOPT) $(CURDIR)/tmux/tmux.conf ~/.tmux.conf

iterm2:
	ln $(LNSOPT) $(CURDIR)/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

zsh: submodule
	ln $(LNSOPT) $(CURDIR)/zsh/zshrc ~/.zshrc
	ln $(LNSOPT) $(CURDIR)/zsh/oh-my-zsh ~/.oh-my-zsh

git:
	ln $(LNSOPT) $(CURDIR)/git/gitconfig ~/.gitconfig

conky:
	ln $(LNSOPT) $(CURDIR)/conky/conkyrc ~/.conkyrc
	ln $(LNSOPT) $(CURDIR)/conky/conky ~/.conky


sakura:
	ln $(LNSOPT) $(CURDIR)/sakura/sakura.conf ~/.config/sakura/sakura.conf

z:
	ln $(LNSOPT) $(CURDIR)/z/z.sh ~/.z.sh
