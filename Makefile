# vim:set noet: 
.PHONY : vim tmux iterm2

LNSOPT=-s

ifdef force
	ifeq ($(force),1)
		LNSOPT=-fs
	endif
endif


vim:
	cd vim/vundle ; git checkout master ; git pull;
	mkdir -p ~/.vim/bundle/ 
	ln $(LNSOPT) $(CURDIR)/vim/.vimrc ~/.vimrc
	ln $(LNSOPT) $(CURDIR)/vim/vundle ~/.vim/bundle/vundle
	vim -c "BundleInstall"


tmux:
	ln $(LNSOPT) $(CURDIR)/tmux/.tmux.conf ~/.tmux.conf

iterm2:
	ln $(LNSOPT) $(CURDIR)/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
