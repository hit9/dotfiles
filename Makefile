# vim:set noet: 
.PHONY : vim

iLNSOPT=-s

ifdef force
	ifeq ($(force),1)
		LNSOPT=-fs
	endif
endif


vim:
	ln $(LNSOPT) $(CURDIR)/vim/.vimrc ~/.vimrc

