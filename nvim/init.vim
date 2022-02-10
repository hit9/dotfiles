" location: ~/.config/nvim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Using old fashion vimrc :)
source ~/.vimrc

" Include lua configurations
lua require('settings')
