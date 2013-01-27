"首先，加载vundle!  ---------------------------------------{{{

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"solarized 主题
Bundle "altercation/vim-colors-solarized"
"自动补全插件
Bundle 'neocomplcache'
"jsbeautify
Bundle 'jsbeautify'
"autoclose:自动关闭括号,[],{}等，自动光标置中
Bundle "jiangmiao/auto-pairs"
" -------------- snipmate 插件:tab 补全 --- {{{
"snipmate的依赖
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/snipmate-snippets"
"snipmate
Bundle "garbas/vim-snipmate"
"-----------------------------------}}}
"窗口浏览器
Bundle "scrooloose/nerdtree"

" Conque 很酷的插件，允许你在vim中开其他程序。
" 例子 :ConqueTermTab bash 在一个新的vim标签中打开bash
Bundle "rson/vim-conque"

"Jquery
Bundle "jQuery"

Bundle "pep8"

"好插件啊：自动在类似==两边添加空格
Bundle "auto"

"tags插件~
Bundle "majutsushi/tagbar"

"Oh,一个注释插件,\\注释一行或撤销注释一行
Bundle "tpope/vim-commentary"

"持久化的撤销操作插件, http://sjl.bitbucket.org/gundo.vim/ :GundoToggle
Bundle 'sjl/gundo.vim'

"用过vimoperator吗？那里的f键快速跳转叫你印象深刻吧
Bundle "Lokaltog/vim-easymotion"

"vim git 插件
Bundle "tpope/vim-fugitive"

"-------------- for Python programmers ------------{{{
"Python.vim
Bundle "python.vim--Vasiliev"
"语法错误检查插件,需要安装pyflakes  pip install git+git://github.com/kevinw/pyflakes.git
Bundle "kevinw/pyflakes-vim"
"--------------------------------------------------}}}

"-------------------------------------------------------------}}}


"-------------------- 根据文件类型 xxx (注意，放在bundle之后)--{{{
" 针对不同的文件类型加载对应的插件
" 针对不同的文件类型采用不同的缩进格式
filetype plugin indent on   
"--------------------------------------------------------------}}}

"-------------- 基本-------------------------------------------{{{
syntax enable
se nu  "显示行号
"终端模式:xterm-256color,这个终端模式支持功能键Home,End等
set term=xterm-256color
"终端下名字由vim设置
set title
"开启256 color
set t_Co=256
"允许有未保存的内容时切换缓冲区
set hidden
set ttyfast
syntax on 
"输入的命令显示出来
set showcmd
"显示当前模式
set showmode
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
"高亮当前行
set cul
"合适的高亮当前行的颜色
hi CursorLine term=none cterm=none ctermbg=3
"自动切换当前目录为当前文件所在目录
set autochdir
"800个字符以上的行不去高亮
set synmaxcol=800
set backspace=indent,eol,start
set gdefault
"搜索
set hlsearch
set incsearch

set ruler

"------------------------------------------------------------------ }}}

" ------------------ gui ----------------------------{{{

set guioptions-=T           " gvim隐藏工具栏
set guioptions-=m           " gvim隐藏菜单栏
"设置gvim的字体
set guifont=Inconsolata-g\ for\ Powerline\ 13

"------------------------------------------------------}}}

"-------------------- 编码 -----------------------------{{{

"vim内部的编码
set encoding=utf-8
"新建一个文件的默认编码
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbkgb2312,cp936
"输出到终端的编码
set termencoding=utf-8
"vim写入文件的时候采用的编码
set fileencoding=utf-8

"""-----------------------------------------------------}}}

"------------------- 缩进 -----------------------------{{{
"自动缩进
set autoindent
"类似C语言风格的缩进
set cindent
"智能缩进:每一行都和前一行有相同的缩进量,
"同时这种缩进形式能正确的识别出花括号,当遇到右花括号（}）,
"则取消缩进形式。此外还增加了识别C语言关键字的功能。
"如果一行是以#开头的(比如宏)，那么这种格式将会被特殊对待而不采用缩进格式
set smartindent
"----------------------------------------------------------}}}

"------------------ tab键 --------------------------------

"把输入的tab自动转换成空格，Python用户必用~
set expandtab 
"一个tab键占据4个空格
set tabstop=4
"一开始,插入的就是4个空格,此时一旦你再按下一次tab,这次的四个空格就会和上次的四个空格组合起来变成一个制表符
set softtabstop=4
"每一级自动缩进的空格数
set shiftwidth=4

"显示tab键
set list
"list键的填充字符
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮

"根据文件类型设定缩进,覆盖掉默认的~,来自humiaozuzu
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79

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
"当敲键盘的时候隐藏鼠标指针
set mousehide
set mousemodel=popup

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


"- ------------------------ 插件配置 ----------------------------------------  {{{

" ---------------------------------  solarized {{{
let g:solarized_termcolors=256  " 一定要这行在colorscheme solarized 之前
let g:solarized_termtrans=1
let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"背景:暗色
set background=dark
colorscheme solarized
"使vim在终端保持透明
hi Normal ctermbg=NONE
"-----------------------------------------------}}}

"------------------------ neocomplcache插件:自动完成插件 {{{
let g:neocomplcache_enable_at_startup = 1
" ------------------------------------------------------- }}}

" --------------------- Nerdtree:窗口浏览器:NERDTreeToggle {{{
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1
"命令T跳转到左边nerdtree
:command -range=% T : NERDTreeToggle
"---------------------------------------------------------- }}}

" ----------------------------------  Powerline ----------{{{
"  美化状态栏
"状态栏
set laststatus=2
"powerline  : pip install git+git://github.com/Lokaltog/powerline
python from powerline.bindings.vim import source_plugin; source_plugin()
" ------------------------------------------------ }}}

"pep8, ctrl-k作为检查快捷键
let g:pep8_map='<C-k>' 

" - --------------------------------------tagbar {{{
"依赖于ctags, ubuntu下apt-get install ctags安装。这个插件适合面向对象程序员
let g:tagbar_width=30
let g:tagbar_autofocus = 1
"----------------------------------------------------}}}
"tagbar 宽度
let g:gundo_width=30
"EasyMotion  \键
let g:EasyMotion_leader_key = '<Leader>'

"-------------------------------------插件配置end-----------------------------}}}

" -----------------------------------------------------------------自定义命令 {{{


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

:command -range=% PEP8 :!autopep8 -i %

"--------------------------------------------------------------------- }}}
"-------------------------- 键 map-------------------------------------{{{
"这样在normal模式下在一行中按下0就跳到了行首,按下9到行尾
noremap 0 ^
noremap 9 $
"----------------------------------------------------------------------}}}
