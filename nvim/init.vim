" vim: foldmethod=marker foldenable
" vim: tabstop=2 softtabstop=2 shiftwidth=2

"Chao Wang's personal vim configurations. https://github.com/hit9/dotfiles
"Requires: NeoVim >= 0.9, not support Vim.

" Filepath: ~/.config/nvim/init.vim

"Preload before all ---
"Ref: https://github.com/neovim/neovim/issues/2437
let g:python_host_prog  = '~/.pyenv/shims/python'
let g:python3_host_prog = '~/.pyenv/shims/python'
"Identing inside parentheses can be very slow, regardless of the searchpair()
"timeout, so let the user disable this feature if he doesn't need it
"Ref: https://github.com/neovim/neovim/issues/15299
let g:pyindent_disable_parentheses_indenting = 1


"Plugins ---------------------------------------------- {{{
call plug#begin('~/.config/nvim/plugs')

Plug 'NLKNguyen/papercolor-theme' "My favorite colorscheme.
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "Famous file explorer plugin, lazy load on comand NERDTreeToggle
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } "NERDTree plugin which shows git status flags, lazy load on comand NERDTreeToggle
Plug 'nvim-lualine/lualine.nvim' "lua version statusline.
Plug 'jayflo/vim-skip' "Binary-search inline cursor movement.
Plug 'windwp/nvim-autopairs' "Close pair ()[]{} etc. automatically.
Plug 'mg979/vim-visual-multi' "Multiple cursors plugin for vim/neovim.
Plug 'wellle/targets.vim' "Vim plugin that provides additional text objects
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }  "Fuzzy search files/buffers etc, Ctrl-p.
Plug 'junegunn/fzf.vim' "Fzf vim plugin.
Plug 'mhinz/vim-signify' "Show diff signs for file changes under git/hg/svn control.
Plug 'simeji/winresizer' "Window resizer.
Plug 'troydm/zoomwintab.vim' "Window zoom.
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim', { 'branch': 'main' } "Vimdiff with a files navigator.
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "Syntax highlighting for variety filetypes.
Plug 'dohsimpson/vim-macroeditor' "Edito macro => :MacroEdit a
Plug 'tpope/vim-fugitive' "Git plugin.
Plug 'lukas-reineke/indent-blankline.nvim' "Indent guides for Neovim
Plug 'jose-elias-alvarez/null-ls.nvim'
"Completion & LSP (language protocol server).
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-vsnip', { 'branch': 'main' }
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'seblj/nvim-echo-diagnostics'
"ray-x/lsp_signature.nvim is slow, with poor performance...
"I use another lightweight-but-fast alternative.
Plug 'erhickey/sig-window-nvim'
Plug 'Decodetalkers/csharpls-extended-lsp.nvim', { 'for': 'cs' }
"Plug 'hit9/bitproto', { 'rtp': 'editors/vim', 'for': 'bitproto' }
"C/C++
Plug 'https://git.sr.ht/~p00f/godbolt.nvim' "Godbolt - CompilerExplorer
Plug 'gauteh/vim-cppman'

call plug#end()
"End Plugins -----------------------------------------------  }}}


"Basic ------------------------------------------------------ {{{
filetype plugin indent on

"Basic
set nocompatible " be iMproved
" set shell=/usr/local/bin/fish  "Vim's shell, defaults to `$SHELL`.
set noeb "Disable bells.
set ttyfast "Indicates a fast terminal connection. (see :help ttyfast).
set title "Makes terminal title is set by vim.
set titleold= "Restore old title after leaving vim.
set autoread "Auto updates current file if this file is updated by outer.
set hidden "Opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed.
set autochdir "Auto switch current working directory to current editing file's directory.
set updatetime=750 "Smaller updatetime for CursorHold & CursorHoldI

"Mouse
set mouse=a "Enable mouse.
set selection=exclusive "Mouse can only selects the block where ths cursor is on.
set selectmode=mouse,key
set mousehide "Hide mouse cursor on keyboard typing.
set mousemodel=popup "Right mouse button pops up a menu.

"Syntax
syntax enable "Enable syntax.
set synmaxcol=300 "Don't perform highlight on lines that are longer than 300 chars.
"syntax sync minlines=1000
set redrawtime=1000  "Smaller redrawtime

"Displayment
set number  "Show line numbers.
set norelativenumber "Don't use relative line numbers.
set go= "Disable gvim's gui menu. (But I personally never use gui version vim).
set shortmess=atIc "Disable the short message on vim start.
set noshowcmd "Don't show command in the last line of screeen.
set showmode "If in Insert, Replace or Visual mode put a message on the last line.
set nowrap "Lines longer than the width of window will wrap and displaying continues on the next line.
set signcolumn=yes "Always show signcolumns
set cmdheight=2 "Command-line height (number of screen lines).

"Scroll
set scrolloff=9999 "Cursor always stays in the middle of screen, https://stackoverflow.com/posts/1276428/revisions.

"Statusline
set laststatus=2 "Always show status line on the last window.
set ruler "Show line and column number of where cursor is.

"Search & Replace
set gdefault "The :s/<search-target>/<to-replace-with>/ is s///g by default
set hlsearch "Highlight search results.
set incsearch "Realtime search results showing.

"Encoding (utf8)
set encoding=utf-8
set fencs=utf-8 "Encoding that creating new files.
set termencoding=utf-8 "Encoding that output to terminal.
set fileencoding=utf-8 "Encoding that saving files.
set backspace=indent,eol,start "Backspace key, I just don't rely on it.

"Fold
set nofoldenable
set foldmethod=indent
set foldcolumn=0 "number of columns showing the foldlevels on the left sidebar.
set foldlevel=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo  "Which commands trigger auto-unfold
set foldclose=all  "Close all folds (which level>foldlevel) automatically when cursor leaves.

"Copy/Paste
set clipboard=unnamed "Tmux copy issue: https://github.com/tmux/tmux/issues/543#issuecomment-248980734

"Match
set showmatch "When a bracket is inserted, briefly jump to the matching one.
set matchtime=1 "Tenths of a second to show the matching paren.

"Completion.
"Default vim completion behavior when CTRL-P/N are used.
set completeopt=longest,menu  "Use a popup menu to show possible completinos.
set cpt=.,w,b  "Scan candidates from .(current buffer), w(buffers from other windows), b(other loaded buffers).

"Indent (by default)
set autoindent "Indent automatically. But notice that autoindent may make Cmd+V pastsing works wired,
               "so when pasting something from clipboard into vim, better to `:set paste` and then Cmd+V,
               "and rollback this setting via :set nopaste.
set cindent "C style indent.
set smartindent "http://vim.wikia.com/wiki/Indenting_source_code
set expandtab "Expand tabs into spaces, by default (Python users's must-have).
set tabstop=4 "Setting 1tab = 4 spaces.
set softtabstop=4 "Number of spaces that a <Tab> counts for while editing. :set paste makes softtabstop to 0 temply.
set shiftwidth=4 "Number of spaces to use for each step of (auto)indent.

set list "Show tabs via listchars below, and display end sign after endo fline.
set listchars=space:·,tab:▸\ ,eol:¬,extends:❯,precedes:❮ "Chars that to display list.

"Tab settings for diferent language filetypes (overriding).
autocmd FileType text setlocal textwidth=79
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4 textwidth=110
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=110
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=79
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79
autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=79

"Terminal
"Using ESC to go back to normal.
autocmd TermOpen * tnoremap <Esc> <C-\><C-n>

"Basic :: Color -------------------------------- {{{

"Enable true color support:
"https://lotabout.me/2018/true-color-for-tmux-and-vim/
"https://github.com/tmux/tmux/issues/1246
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set t_Co=256 "Enable 256 color
set background=dark "Using dark. Hmm dark is sexy.

"Basic :: Color :: PaperColor ------- {{{
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \        'transparent_background': 1,
  \        'override': {
  \           'visual_bg': ['#006699', '31'],
  \           'visual_fg': ['#ffffff', '255']
  \        }
  \      }
  \   }
  \ }
colorscheme PaperColor

"End Basic :: Color :: PaperColor -------- }}}

"Normal and Visual mode color cosutomization.
highlight Normal term=none ctermbg=none "Make vim be transparent in terminal.
highlight Visual term=none cterm=bold ctermbg=31 ctermfg=255 guibg=#006699 guifg=#ffffff

"CursorLine/CursorColumn, should be applied after colorscheme loaded.
highlight CursorLine term=none cterm=none ctermbg=238 ctermfg=none guibg=#444444
highlight CursorColumn term=none cterm=none ctermbg=238 ctermfg=none guibg=#444444

"Transparent background
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE guibg=NONE

"End Basic :: Color ---------------------------- }}}

"End Basic --------------------------------------------- }}}

"Plugin :: scrooloose/nerdtree ------------------------------------------------ {{{

"Open nerdtree on buffer entered. And close it if it's the last window.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nerdtree window's width.
let NERDTreeWinSize=35
"Show line number for nerdtree.
let NERDTreeShowLineNumbers=1
"Don't display these files:
let NERDTreeIgnore=['\.pyc$', '\.o$', '\~$', '__pycache__', '\.mypy_cache', '\.DS_Store',
    \ '^\.git$', '\.o$', '\.so$', '\.egg$', "\.pytest_cache", "\.swp$", "\.swo$", "\.swn$", "\.null"]
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

"User-defined custom command `:NT` to toggle nerdtree window
:command NT :NERDTreeToggle
" End Plugin :: scrooloose/nerdtree ----------------------------------------- }}}

"Plugin :: mg979/vim-visual-multi ------------------------- {{{
let g:VM_theme = 'iceblue' "https://github.com/mg979/vim-visual-multi/wiki/Highlight-colors
" Won't use default leader key \\, using Ctrl-N instead.
" Select words: Ctrl-N and press N for next word.
" Multiple lines: visual mode selection section, and Ctrl-N
" Select all occurences of current word: Ctrl-N and press A quickly
let g:VM_leader = '<C-N>'
let g:VM_maps = {}
let g:VM_maps["Visual Add"] = '<C-n>'
"End Plugin :: mg979/vim-visual-multi ----------------------}}}

"Plugin :: mhinz/vim-signify --------------------------- {{{
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd ctermfg=yellow ctermbg=green guifg=#F7DC6F guibg=#1E8449
highlight SignifySignChange ctermfg=yellow ctermbg=blue guifg=#F7DC6F guibg=#2874A6
highlight SignifySignDelete ctermfg=yellow ctermbg=red guifg=#F7DC6F guibg=#EC7063
"End Plugin :: mhinz/vim-signify  ----------------------- }}}

"Plugin :: junegunn/fzf.vim ------------------------------ {{{
" ProjectFiles tries to locate files relative to the git root contained in
" NerdTree, falling back to the current NerdTree dir if not available
" see https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nmap <c-p> :ProjectFiles<CR>
nmap <c-b> :Buffers<CR>

"Search 'foo bar' in ~/projects
":Ag "foo bar" ~/projects
"Start in fullscreen mode
":Ag! "foo bar"
command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview(), <bang>0)

"Search pattern in git root directory.
command! -bang -nargs=+ AgGitFiles execute 'Ag!' <q-args> s:find_git_root()

" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal'  }  }
" Customize fzf colors to match your color scheme
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.5 } }
"End Plugin :: junegunn/fzf.vim ---------------------------- }}}

"Plugin :: simeji/winresizer ------------------------- {{{
"Ctrl-E to reset vin windows
let g:winresizer_start_key = '<C-E>'
"End Plugin ::  simeji/winresizer -------------------- }}}

"For C++: https://github.com/gauteh/vim-cppman ------- {{{
"Map to `M`.
"since K is already taken by `vim.lsp.buf.hover`.
au FileType cpp nmap M :execute ':Cppman ' . expand('<cword>') <CR>
"End Plugin.}}}

"Custom :: WhiteSpaces Cleaning -------------------------------------- {{{

"Highlight trailing whitespaces as red.
"http://vim.wikia.com/wiki/Highlight_unwanted_spaces.

function! HighlightExtraWhitespace()
  highlight ExtraWhitespace ctermbg=red guibg=#EC7063
  match ExtraWhitespace /\s\+$/
endfunction

autocmd BufWinEnter * if &buftype != 'terminal' && &buftype != 'nofile' | call HighlightExtraWhitespace() | endif
autocmd TermOpen * hi clear ExtraWhitespace

"Clean trailing whitespaces on buffer's save.
"Command :WS is to clean trailing whitespaces.
:command WS :%s/\s\+$//e

"Auto clean whitespaces on buffer save for this files.
autocmd BufWrite
      \ *.c,*.cc,*.cpp,*.cxx,*.hxx,*.hh,*.h,*.go,*.py,*.js,
      \*.html,*.md,.vimrc,*.ini,*.toml,*.vim,
      \*.markdown,*.yaml,*.proto,*.bitproto,*.rst,*.sql,*.swift,*.dart
      \ :WS
"End  Custom :: WhiteSpaces Cleaning ---------------------------------- }}}

"Custom :: Window Switches -------------------------- {{{

"Shortcut window switches, w+h/j/k/l
nmap wk <c-w><up>
nmap wh <c-w><left>
nmap wl <c-w><right>
nmap wj <c-w><down>
nmap wz <c-w>o  " Zoom
" -------------------------------------------------- }}}

" Custom :: Folding {{{
" Mappings to easily toggle fold levels
nmap z0 :set foldlevel=0<CR>
nmap z1 :set foldlevel=1<CR>
nmap z2 :set foldlevel=2<CR>
nmap z3 :set foldlevel=3<CR>
"--------------------------------------------------- }}}

"Word case converters (\%V runs substitute on visual selections). --- {{{
"Convert selected text to snake_case style:
"firstly lower the first letter, then make each upper letter lower
"and insert a underscore in front of that.
command! -range ToSnake :s/\%V\<./\l&/e | s/\%V\u/_\l&/e

"Convert selected text to camelCase style:
"Find the underscores and upper the following letter, also removing the underscore.
"Then make sure the first letter is in lower case.
command! -range ToCamel :s/\%V_\([^_]\)/\u\1/e | s/\%V\<./\l&/e

"Convert selected text to PascalCase style:
"Find the underscores and upper the following letter, also removing the underscore.
"Then make sure the first letter is in upper case.
command! -range ToPascal :s/\%V_\([^_]\)/\u\1/e | s/\%V\<./\u&/e

"Convert selected text to UPPER_SNAKE_CASE style:
"firstly insert a underscore between lower and upper letters.
"and then makes the whole string upper.
command! -range ToUpperSnake :s/\%V\(\l\)\(\u\)/\1_\2/e | s/\%V\w\+/\U&/e
"--- }}}

"Load lua configs
luafile ~/.config/nvim/conf.lua
