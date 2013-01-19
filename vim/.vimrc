syntax enable
se nu  "显示行号
"终端模式:xterm-256color,这个终端模式支持功能键Home,End等
set term=xterm-256color
"开启256 color
set t_Co=256
syntax on 
"输入的命令显示出来
set showcmd
"关闭报警声音
set noeb
"开启鼠标定位
set mouse=a
"关闭报警声音
set noeb
"外部修改后自动更新这个文件
set autoread
"告诉vim使用vim的键盘而不是vi的
set nocompatible
"关闭启动时的救助贫困儿童的提示消息
set shortmess=atI
"状态栏
set laststatus=2
"高亮当前行
set cul
"合适的高亮当前行的颜色
hi CursorLine term=none cterm=none ctermbg=3

" ------------------ gui ----------------------------

set guioptions-=T           " gvim隐藏工具栏
set guioptions-=m           " gvim隐藏菜单栏
"设置gvim的字体
set guifont=Inconsolata-g\ 12

"-------------------- 编码 ---------------------------------

"vim内部的编码
set encoding=utf-8
"新建一个文件的默认编码
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbkgb2312,cp936
"输出到终端的编码
set termencoding=utf-8
"vim写入文件的时候采用的编码
set fileencoding=utf-8

"------------------- 缩进 -----------------------------

"自动缩进
set autoindent
"类似C语言风格的缩进
set cindent
"智能缩进:每一行都和前一行有相同的缩进量,
"同时这种缩进形式能正确的识别出花括号,当遇到右花括号（}）,
"则取消缩进形式。此外还增加了识别C语言关键字的功能。
"如果一行是以#开头的(比如宏)，那么这种格式将会被特殊对待而不采用缩进格式
set smartindent


"------------------ tab键 --------------------------------

"把输入的tab自动转换成空格，Python用户必用~
set expandtab 
"一个tab键占据4个空格
set tabstop=4
"一开始,插入的就是4个空格,此时一旦你再按下一次tab,这次的四个空格就会和上次的四个空格组合起来变成一个制表符
set softtabstop=4
"每一级自动缩进的空格数
set shiftwidth=4

"--------------- 系统剪切板 --------------------------

"注意：以下的ctrl-c,ctrl-v快捷键需要你安装了gvim
"ctrl-c复制到系统剪切板
map <C-c> "+y
"ctrl-v粘贴到系统粘贴板
map <C-v> "+p

"-------------------------------鼠标-------------------------

"启用鼠标的使用
set mouse=a
"可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive
set selectmode=mouse,key

"--------------------------- 折叠 -------------------------

set foldenable
set foldmethod=manual  "手动折叠
set foldlevel=3

" --------------------- 匹配 -------------------------------

"高亮显示匹配的括号
set showmatch
"匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1

"------------------- 补全 -----------------------------------

set completeopt=longest,menu
set cpt=.,w,b


" -----------Vundle Configure -----------------

set nocompatible               " be iMproved
"filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"-------------------- 根据文件类型 xxx (注意，放在bundle之后)----------------------------

filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin indent on    " 启用自动补全
" - ------------------------ Bundles! ----------

"solarized
Bundle "altercation/vim-colors-solarized"
"背景:暗色
set background=dark
colorscheme solarized
let g:solarized_termcolors=256
"使vim在终端保持透明
hi Normal ctermbg=NONE
"neocomplcache插件
Bundle 'neocomplcache'
let g:neocomplcache_enable_at_startup = 1
"jsbeautify
Bundle 'jsbeautify'
"-------autoclose ------ 自动关闭括号
Bundle "Townk/vim-autoclose"

" -------------- snipmate 插件--- 
"依赖
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
"snipmate
Bundle "garbas/vim-snipmate"

"Nerdtree
Bundle "scrooloose/nerdtree"
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1
"命令T跳转到左边nerdtree
:command -range=% T : NERDTreeFocus

"Conque
Bundle "rson/vim-conque"

"Powerline
Bundle "Lokaltog/vim-powerline"
let g:Powerline_colorscheme='solarized256'
"Jquery
Bundle "jQuery"
"Python Model
Bundle "klen/python-mode"



" ----------------------------- :R 命令快速运行程序  ---------------------
:command -range=% R :call Runit()
func! Runit()
	exec "w"
	if &filetype == 'c'
		exec "!gcc  % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'php'
		exec "!php %"
	elseif &filetype =='python'
		exec "!python %"
	elseif &filetype=='ruby'
		exec "!ruby %"
	elseif &filetype=='javascript'
		exec "!js %"
	elseif &filetype=='sh'
		exec "!sh %"
	elseif &filetype=='go'
		exec "!go build %"
		exec "! ./%<"
	endif
endfunc
