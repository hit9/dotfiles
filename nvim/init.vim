" vim: foldmethod=marker foldenable
" vim: tabstop=2 softtabstop=2 shiftwidth=2

"Chao Wang's personal vim configurations. https://github.com/hit9/dotfiles
"Requires: NeoVim >= 0.9, not support Vim.

" Filepath: ~/.config/nvim/init.vim

"Preload before all ---
"Ref: https://github.com/neovim/neovim/issues/2437
let g:python_host_prog  = '~/.pyenv/shims/python'
let g:python3_host_prog = '~/.pyenv/shims/python'

"Plugins ---------------------------------------------- {{{
call plug#begin('~/.config/nvim/plugs')

Plug 'NLKNguyen/papercolor-theme' "My favorite colorscheme.
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "Famous file explorer plugin, lazy load on comand NERDTreeToggle
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' } "NERDTree plugin which shows git status flags, lazy load on comand NERDTreeToggle
Plug 'itchyny/lightline.vim' "Lightweight statusline plugin.
Plug 'jayflo/vim-skip' "Binary-search inline cursor movement.
Plug 'windwp/nvim-autopairs' "Close pair ()[]{} etc. automatically.
Plug 'mg979/vim-visual-multi' "Multiple cursors plugin for vim/neovim.
Plug 'dense-analysis/ale' "All-in-one asynchronous linting/fixing for Vim.
Plug 'Konfekt/FastFold' "Speed up Vim by updating folds only when called-for.
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

Plug 'hit9/bitproto', { 'rtp': 'editors/vim', 'for': 'bitproto' }

"C/C++
Plug 'gauteh/vim-cppman', { 'for': 'cpp' } " Man via cppreference.
Plug 'Freed-Wu/cppinsights.vim', { 'for': 'cpp' } "C++ Insights - See your source code with the eyes of a compiler

call plug#end()
"End Plugins -----------------------------------------------  }}}


"Basic ------------------------------------------------------ {{{
filetype plugin indent on

"Basic
set nocompatible " be iMproved
" set shell=/usr/local/bin/fish  "Vim's shell, defaults to `$SHELL`.
set noeb "Disable bells.
set ttyfast "Indicates a fast terminal connection. (see :help ttyfast).
set lazyredraw "Same, faster vim.
set title "Makes terminal title is set by vim.
set titleold= "Restore old title after leaving vim.
set autoread "Auto updates current file if this file is updated by outer.
set hidden "Opening a new file when the current buffer has unsaved changes causes files to be hidden instead of closed.
set autochdir "Auto switch current working directory to current editing file's directory.
set updatetime=300 "Smaller updatetime for CursorHold & CursorHoldI

"Mouse
set mouse=a "Enable mouse.
set selection=exclusive "Mouse can only selects the block where ths cursor is on.
set selectmode=mouse,key
set mousehide "Hide mouse cursor on keyboard typing.
set mousemodel=popup "Right mouse button pops up a menu.

"Syntax
syntax enable "Enable syntax.
set synmaxcol=300 "Don't perform highlight on lines that are longer than 300 chars.
syntax sync minlines=1000

"Displayment
set number  "Show line numbers.
set norelativenumber "Don't use relative line numbers.
set go= "Disable gvim's gui menu. (But I personally never use gui version vim).
set shortmess=atI "Disable the short message on vim start.
set noshowcmd "Don't show command in the last line of screeen.
set showmode "If in Insert, Replace or Visual mode put a message on the last line.
set nowrap "Lines longer than the width of window will wrap and displaying continues on the next line.
set shortmess+=c "Don't give |ins-completion-menu| messages.
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

"Enable folding for programming purpose, and use treesitter folding.
" autocmd FileType c,cpp,css,go,python,javascript,protobuf,ruby,rust,typescript
"       \ setlocal foldenable foldmethod=expr foldexpr=nvim_treesitter#foldexpr()

"Copy/Paste
set clipboard=unnamed "Tmux copy issue: https://github.com/tmux/tmux/issues/543#issuecomment-248980734

"Match
set showmatch "When a bracket is inserted, briefly jump to the matching one.
set matchtime=1 "Tenths of a second to show the matching paren.

"Completion.
"Default vim completion behavior when CTRL-P/N are used.
set completeopt=longest,menu  "Use a popup menu to show possible completinos.
set cpt=.,w,b  "Scan candidates from .(current buffer), w(buffers from other windows), b(other loaded buffers).

"Indent
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

"Tab settings for diferent language filetypes (forked from humiaozuzu's dotfile).
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

"End Basic :: Color ---------------------------- }}}

"End Basic --------------------------------------------- }}}

"Plugin :: windwp/nvim-autopairs ----------------------------------------- {{{
lua << EOF
  require'nvim-autopairs'.setup {}
EOF
"End Plug :: windwp/nvim-autopairs  ------ }}}

"Plugin :: treesitter ----------------------------------------- {{{
lua << EOF
  require'nvim-treesitter.configs'.setup {
    highlight = { enable = true, },
  }
EOF
"End Plugin :: treesitter --------------------------------------- }}}

"Plugin :: lightline.vim ----------------------------------------- {{{
let g:lightline = { 'colorscheme': 'PaperColor' } "https://github.com/itchyny/lightline.vim/blob/master/colorscheme.md
"End Plugin :: lightline.vim --------------------------- }}}

"Plugin :: scrooloose/nerdtree ------------------------------------------------ {{{

"Open nerdtree on buffer entered. And close it if it's the last window.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nerdtree window's width.
let NERDTreeWinSize=35
"Show line number for nerdtree.
let NERDTreeShowLineNumbers=1
"Don't display these files:
let NERDTreeIgnore=['\.pyc$', '\.o$', '\~$', '__pycache__', '\.mypy_cache', '\.DS_Store',
    \ '^\.git$', '\.o$', '\.so$', '\.egg$', "\.pytest_cache", "\.swp$", "\.swo$", "\.swn$"]
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

"User-defined custom command `:NT` to toggle nerdtree window
:command NT :NERDTreeToggle
" End Plugin :: scrooloose/nerdtree ----------------------------------------- }}}

"Plugin :: w0rp/ale  ------------------------------------- {{{

"Ale with foldmethod != indent, check:
"https://github.com/dense-analysis/ale/issues/1829#issuecomment-475589289

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \   'python': ['black', 'mypy'],
  \   'c': ['clang-format'],
  \   'cpp': ['clang-format'],
  \   'rust': ['analyzer'],
  \   'go': ['gopls'],
  \   'swift': ['apple-swift-format'],
  \   'dart': ['dart-format'],
  \   'javascript': ['eslint'],
  \   'typescript': ['eslint'],
  \   'typescriptreact': ['eslint'],
\}
let g:ale_fixers_explicit = 1
let g:ale_fixers = {
  \   'python': ['black', 'isort'],
  \   'c': ['clang-format'],
  \   'cpp': ['clang-format'],
  \   'go': ['gofmt'],
  \   'rust': ['rustfmt'],
  \   'proto': ['clang-format'],
  \   'swift': ['apple-swift-format'],
  \   'dart': ['dart-format'],
  \   'javascript': ['eslint', 'prettier'],
  \   'typescript': ['eslint', 'prettier'],
  \   'typescriptreact': ['eslint', 'prettier'],
  \   'cmake': ['cmakeformat'],
\}
let g:ale_fix_on_save = 1
let g:python_mypy_show_notes = 1
let g:ale_python_isort_options = '--profile black --ca'
let g:ale_rust_rls_toolchain = 'nightly'
let g:c_clangformat_use_local_file = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 0
let g:ale_typescript_eslint_executable = 'eslint_d'
let g:ale_typescript_eslint_use_global = 0
"End Plugin :: w0rp/ale ----------------------------------- }}}

"Plugin LSP hrsh7th/nvim-cmp, lspconfig, lsp_signature etc. ------------------ {{{

function! NMapLspKeys()
  "Split a horizontal window and Go to definition
  nmap <silent> gd :split<cr> :lua vim.lsp.buf.definition()<CR>
  "Split a vertical window and Go to definition
  nmap <silent> gv :vsplit<cr> :lua vim.lsp.buf.definition()<CR>
  "Split a horizontal window and Go to declaration (many lsp servers don't implement this, check gd instead)
  nmap <silent> gD :split<cr> :lua vim.lsp.buf.declaration()<CR>
  "Split a window and show all references to this symbol under the cursor in the quickfix window
  nmap <silent> gr :split<cr> :lua vim.lsp.buf.references()<CR>
  "Split a window and show all implementations of this symbol under the cursor in the quickfix window
  nmap <silent> gi :split<cr> :lua vim.lsp.buf.implementation()<CR>
  "Show the documentation of the signature help message of this symbol under the cursor.
  nmap <silent> <C-k> :lua vim.lsp.buf.signature_help()<CR>
  "Show symbol information under current cursor.
  nmap <silent> K :lua vim.lsp.buf.hover()<CR>
endfunction

au FileType go,python,c,cpp,javascript,rust,lua,cs,swift,dart,typescript,typescriptreact :call NMapLspKeys()

lua << EOF
  local cmp = require'cmp'
  local nvim_lsp = require'lspconfig'

  cmp.setup({

    preselect = cmp.PreselectMode.None,

    snippet = {
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Make a root_dir function, searching some files at first and then fallback to cwd.
  function make_root_dir_function(...)
    local patterns = {...}
    return function(fname)
      return nvim_lsp.util.root_pattern(unpack(patterns))(fname) or vim.fn.getcwd()
    end
  end

  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }

  -- Python lsp
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    autostart = false,
    settings = {
      useLibraryCodeForTypes = false,
      autoSearchPaths = true,
      diagnosticMode = 'openFilesOnly',
    }
  }

  require'lspconfig'.pylsp.setup{
    settings = {
      pylsp = {
        configurationSources = {},
        plugins = {
          autopep8 = {enabled = false},
          flake8 = {enabled = false},
          yapf = {enabled = false},
          mccabe = {enabled = false},
          pycodestyle = {enabled = false},
          preload = {enabled=false},
          jedi_completion = {
            enabled = true,
          },
        }
      }
    }
  }

  require('lspconfig')['clangd'].setup {
    capabilities = capabilities,
    cmd = {"clangd", "--offset-encoding=utf-16"}
  }

  require'lspconfig'.neocmake.setup{
    capabilities = capabilities
  }
  require('lspconfig').sourcekit.setup { -- swift
    capabilities = capabilities
  }
  require('lspconfig').dartls.setup{
    capabilities = capabilities,
    root_dir = make_root_dir_function('pubspec.yaml', '.git')
  }
  require('lspconfig')['csharp_ls'].setup {
    capabilities = capabilities,
    handlers = {
      ["textDocument/definition"] = require('csharpls_extended').handler,
    }
  }
  require('lspconfig')['tsserver'].setup {}
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }

  -- Plugin erhickey/sig-window-nvim
  -- https://github.com/erhickey/sig-window-nvim

  require('sig-window-nvim').setup({
    window_config = function(label, config, width, height)
      return {
        relative = 'cursor',
        anchor = 'SW',
        width = width,
        height = height,
        row = -1,
        col = 3,
        focusable = false,
        zindex = config.zindex,
        style = 'minimal',
        border = config.border,
      }
    end,
    border='single',
    hl_group = 'Visual',
  })

  -- Below the lsp_complete_configured_servers copies from nvim-lspconfig, lspconfig.lua.
  local lspconfig_util = require('lspconfig.util')

  local completion_sort = function(items)
    table.sort(items)
    return items
  end

  local lsp_complete_configured_servers = function(arg)
    return completion_sort(vim.tbl_filter(function(s)
      return s:sub(1, #arg) == arg
    end, lspconfig_util.available_servers()))
  end

  -- Defines a custom command `LspSwitch`.
  vim.api.nvim_create_user_command('LspSwitch', function(opts)
    local target = opts.fargs[1]
    vim.cmd{cmd = 'LspStop'}
    vim.cmd{cmd = 'LspStart', args = { target }}
    print("Switched to", target)
  end, {
    desc = 'Stop current attaching language servers and start a new one.',
    nargs = 1,
    complete = lsp_complete_configured_servers,
  })

EOF
"}}}

"Plugin seblj/nvim-echo-diagnostics ------------ {{

"Display diagnostic on via echo messaage instead of virtual_text
lua << EOF
  vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = "none" },
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

  require("echo-diagnostics").setup{
      show_diagnostic_number = true,
      show_diagnostic_source = false,
  }

EOF

autocmd CursorHold * lua require('echo-diagnostics').echo_line_diagnostic()

"}}

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


"Plugin :: Freed-Wu/cppinsights.vim  ------------------------- {{{
"where cppinsights: https://github.com/andreasfertig/cppinsights
let g:cppinsights#extra_args = '-- -std=c++17'
"End Plugin :: Freed-Wu/cppinsights.vim  -------------------- }}}

"For C++: https://github.com/gauteh/vim-cppman ------- {{{
"Map to `M`.
"since K is already taken by `vim.lsp.buf.hover`.
au FileType cpp nmap M :execute ':Cppman ' . expand('<cword>') <CR>
"End Plugin.}}}
