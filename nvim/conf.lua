-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

-- Lua part of neovim.
-- I don't like everything in lua, vimscript command sometimes goes more concise and clean.

-- Plugin treesitter {{{
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 500 * 1024 -- 500KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})
-- }}}

-- LSP - Language Servers {{{

-- nvim-cmp setup.
local cmp = require('cmp')
local nvim_lsp = require('lspconfig')

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
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Make a root_dir function, searching some files at first and then fallback to cwd.
function make_root_dir_function(...)
  local patterns = { ... }
  return function(fname)
    return nvim_lsp.util.root_pattern(unpack(patterns))(fname) or vim.fn.getcwd()
  end
end

-- Golang
require('lspconfig')['gopls'].setup({
  capabilities = capabilities,
})

-- Python pyright & pylsp
require('lspconfig')['pyright'].setup({
  capabilities = capabilities,
  autostart = false,
  settings = {
    python = {
      useLibraryCodeForTypes = false,
      autoSearchPaths = true,
      diagnosticMode = 'openFilesOnly',
    },
  },
})

require('lspconfig').pylsp.setup({
  capabilities = capabilities,
  autostart = true,
  settings = {
    pylsp = {
      configurationSources = {},
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        yapf = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        preload = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false },
        jedi_completion = {
          enabled = true,
        },
      },
    },
  },
})

-- C/C++
require('lspconfig')['clangd'].setup({
  capabilities = capabilities,
  filetypes = { 'c', 'cpp' },
  cmd = {
    'clangd',
    '--offset-encoding=utf-16',
    '-j=4',
    '--background-index',
    '--pch-storage=memory',
    -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
    -- to add more checks, create .clang-tidy file in the root directory
    -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
    -- This is slow..
    --    '--clang-tidy',
  },
})

-- CMake
require('lspconfig').neocmake.setup({
  capabilities = capabilities,
})

-- Swift
require('lspconfig').sourcekit.setup({
  capabilities = capabilities,
  filetypes = { 'swift', 'objective-c', 'objective-cpp' },
})

-- Dart
require('lspconfig').dartls.setup({
  capabilities = capabilities,
  root_dir = make_root_dir_function('pubspec.yaml', '.git'),
})
-- CSharp
require('lspconfig')['csharp_ls'].setup({
  capabilities = capabilities,
  handlers = {
    ['textDocument/definition'] = require('csharpls_extended').handler,
  },
})

-- Typescript
require('lspconfig')['tsserver'].setup({})

-- Rust
require('lspconfig')['rust_analyzer'].setup({
  capabilities = capabilities,
})

-- End LSP }}}

-- Lsp Key Mapping -- {{{
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go,python,c,cpp,javascript,rust,lua,cs,swift,dart,typescript,typescriptreact',
  callback = function()
    vim.keymap.set('n', 'gd', function()
      vim.cmd('split')
      vim.lsp.buf.definition()
    end, { silent = true })
    vim.keymap.set('n', 'gv', function()
      vim.cmd('vsplit')
      vim.lsp.buf.definition()
    end, { silent = true })
    vim.keymap.set('n', 'gD', function()
      vim.cmd('split')
      vim.lsp.buf.declaration()
    end, { silent = true })
    vim.keymap.set('n', 'gr', function()
      vim.cmd('split')
      vim.lsp.buf.references()
    end, { silent = true })
    vim.keymap.set('n', 'gi', function()
      vim.cmd('split')
      vim.lsp.buf.implementation()
    end, { silent = true })
    vim.keymap.set('n', '<c-k>', function()
      vim.lsp.buf.signature_help()
    end, { silent = true })
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, { silent = true })
  end,
})
-- End lsp key mapping }}}

-- Plugin - jose-elias-alvarez/null-ls.nvim {{{

local null_ls = require('null-ls')

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

function python_null_ls_condition(params)
  return not (
    params.bufname:match('site-packages')
    or params.bufname:match('.pyenv')
    or params.bufname:match('Python.framework')
  )
end

function clang_null_ls_condition(params)
  return not (params.bufname:match('MacOSX.sdk') or params.bufname:match('Toolchains') or params.bufname:match('vcpkg'))
end

null_ls.setup({
  -- add your sources / config options here
  sources = {
    -- Python
    null_ls.builtins.formatting.black.with({
      extra_args = { '--fast' },
      runtime_condition = python_null_ls_condition,
    }),
    null_ls.builtins.formatting.isort.with({
      extra_args = { '--profile', 'black', '--ca' },
      runtime_condition = python_null_ls_condition,
    }),
    null_ls.builtins.diagnostics.ruff.with({
      runtime_condition = python_null_ls_condition,
    }),
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { '--follow-imports', 'silent' },
      runtime_condition = python_null_ls_condition,
      -- mypy runs slowly, we use it on-save instead of on-change.
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    -- C/C++
    null_ls.builtins.diagnostics.cppcheck.with({
      args = {
        '--enable=warning,style,performance,portability',
        '--inline-suppr',
        '--template=gcc',
        '--language=c++',
        '--std=c++20',
        '$FILENAME',
      },
      filetypes = { 'cpp' },
      runtime_condition = clang_null_ls_condition,
    }),
    null_ls.builtins.diagnostics.cpplint.with({
      runtime_condition = clang_null_ls_condition,
      args = { '--filter=-runtime/references,-build/include_subdir', '$FILENAME' },
    }),
    -- C/C++/CSharp
    null_ls.builtins.formatting.clang_format.with({
      filetypes = { 'c', 'cpp', 'proto', 'cs' },
      runtime_condition = clang_null_ls_condition,
    }),
    -- null_ls.builtins.diagnostics.clang_check.with({
    --   filetypes = { 'c', 'cpp' },
    --   runtime_condition = clang_null_ls_condition,
    -- }),
    -- Golang
    null_ls.builtins.formatting.gofmt,
    -- Rust
    null_ls.builtins.formatting.rustfmt,
    -- Swift
    null_ls.builtins.formatting.swift_format,
    -- Dart
    null_ls.builtins.formatting.dart_format,
    -- Js/Ts
    null_ls.builtins.formatting.eslint_d.with({ prefer_local = 'node_modules/.bin' }),
    null_ls.builtins.formatting.prettier.with({
      prefer_local = 'node_modules/.bin',
      filetypes = { 'javascript', 'typescript', 'typescriptreact', 'css' },
    }),
    -- CMake
    null_ls.builtins.formatting.cmake_format,
    -- Lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '--indent-type', 'spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
    }),
  },
  debug = false,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })
    end
  end,
})

-- }}}

-- Lsp Hover & SignatureHelp {{{

-- Single border for hover floating window.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- Single border for signature help window.
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

-- Single border for :LspInfo window.
require('lspconfig.ui.windows').default_options = {
  border = 'single',
}
-- }}}

-- Plugin erhickey/sig-window-nvim {{{
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
  border = 'single',
  hl_group = 'Visual',
})

-- End sig-window-nvim }}}

-- Plugin windwp/nvim-autopairs {{{
require('nvim-autopairs').setup({})
-- }}}

-- Vim Diagnostics configs ------------ {{{
vim.diagnostic.config({
  virtual_text = false, -- virtual_text is too noisy, we disable it.
  signs = true,
  float = { border = 'none' },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Show Diagnostics on the command line when hover cursor.
local echo_diagnostics = require('echo-diagnostics')

echo_diagnostics.setup({
  show_diagnostic_number = true,
  show_diagnostic_source = false,
})

vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    echo_diagnostics.echo_line_diagnostic()
  end,
})

-- Add Diagnostics to Quickfix Window.
-- https://github.com/neovim/nvim-lspconfig/issues/69

-- global switch:whether enable pushing diagnostics to quickfix window.
vim.g._enable_push_diagnostics_to_quickfix = false

-- Push diagnostics info to quickfix window.
local push_diagnostics_to_quickfix = function(diagnostics)
  local qflist = {}
  for bufnr, diagnostic in pairs(diagnostics) do
    for _, d in ipairs(diagnostic) do
      d.bufnr = bufnr
      d.lnum = d.range.start.line + 1
      d.col = d.range.start.character + 1
      d.text = d.message
      table.insert(qflist, d)
    end
  end
  -- setqflist to add all diagnostics to the quickfix list.
  -- setloclist to add buffer diagnostics to the location list.
  vim.diagnostic.setloclist(qflist)
end

-- Register a handler to push diagnostics to quickfix window if new diagnostics occurs.
local publish_diagnostics_method = 'textDocument/publishDiagnostics'
local default_diagnostics_handler = vim.lsp.handlers[publish_diagnostics_method]

vim.lsp.handlers[publish_diagnostics_method] = function(err, method, result, client_id, bufnr, config)
  default_diagnostics_handler(err, method, result, client_id, bufnr, config)
  if vim.g._enable_push_diagnostics_to_quickfix then
    local diagnostics = vim.diagnostic.get()
    push_diagnostics_to_quickfix(diagnostics)
  end
end

-- Disable push diagnostics to quickfix.
local disable_push_diagnostics = function()
  -- Quickfix window's id.
  local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
  if qf_winid > 0 then
    -- Disable quickfix automatically if quickwindow is closed.
    vim.g._enable_push_diagnostics_to_quickfix = false
  end
end

-- Disable push diagnostics to quickfix if Quickfix window disapper.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function(args)
    vim.api.nvim_create_autocmd('BufWinLeave', { buffer = args.buf, callback = disable_push_diagnostics })
  end,
})

vim.api.nvim_create_user_command('Quickfix', function(opts)
  vim.g._enable_push_diagnostics_to_quickfix = true
  -- Push at once if diagnostics is not empty.
  local diagnostics = vim.diagnostic.get()
  if next(diagnostics) ~= nil then
    push_diagnostics_to_quickfix(diagnostics)
  end
end, {})

-- }}}

-- Plugin https://sr.ht/~p00f/godbolt.nvim/  for C++ {{{
require('godbolt').setup({
  languages = {
    cpp = { compiler = 'clang1600', options = { userArguments = '-std=c++20' } },
    c = { compiler = 'clang1600', options = {} },
  },
  quickfix = {
    enable = true, -- whether to populate the quickfix list in case of errors
    auto_open = false, -- whether to open the quickfix list in case of errors
  },
  url = 'https://godbolt.org', -- can be changed to a different godbolt instance
})
-- end godbolt }}}

--- Status Line {{{

-- A global-visible progress bar.
-- ref: https://www.reddit.com/r/neovim/comments/uy3lnh/how_can_i_display_lsp_loading_in_my_statusline/
function _G.lsp_progress()
  local lsp_clients = vim.lsp.get_active_clients()
  local lsp_client_names = {}
  for _, client in pairs(lsp_clients) do
    table.insert(lsp_client_names, client.id .. ':' .. client.name)
  end
  local lsp_msg = vim.lsp.util.get_progress_messages()[1]
  if lsp_msg then
    local name = lsp_msg.name or ''
    local msg = lsp_msg.message or ''
    local percentage = lsp_msg.percentage or 0
    local title = lsp_msg.title or ''
    return string.format(' %%<%s: %s %s (%s%%%%) ', name, title, msg, percentage)
  elseif #lsp_clients > 0 then
    return table.concat(lsp_client_names, ' ')
  else
    return 'NO LSP'
  end
end

require('lualine').setup({
  options = {
    theme = 'onedark',
    icons_enabled = false,
    section_separators = '',
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        -- Show diagnostics even if there are none.
        always_visible = true,
      },
    },
    lualine_c = {
      'filename',
      'lsp_progress()',
    },
  },
  -- Having a single statusline instead of each for every window.
  globalstatus = true,
})

--}}}

-- indent-blankline {{{
require('indent_blankline').setup({
  show_current_context = true,
  show_current_context_start = false,
})
-- }}}
