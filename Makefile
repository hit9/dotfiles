# vim:set noet: 
.PHONY : vim tmux

iLNSOPT=-s

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
