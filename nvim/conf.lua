-- vim: foldmethod=marker foldenable
-- vim: tabstop=2 softtabstop=2 shiftwidth=2

-- Lua part of neovim.
-- I don't like everything in lua, vimscript command sometimes goes more concise and clean.

-- Plugin treesitter {{{
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
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
    useLibraryCodeForTypes = false,
    autoSearchPaths = true,
    diagnosticMode = 'openFilesOnly',
  },
})

require('lspconfig').pylsp.setup({
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
  cmd = { 'clangd', '--offset-encoding=utf-16' },
})

-- CMake
require('lspconfig').neocmake.setup({
  capabilities = capabilities,
})

-- Swift
require('lspconfig').sourcekit.setup({
  capabilities = capabilities,
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
  severity_sort = false,
})
-- }}}

-- Plugin seblj/nvim-echo-diagnostics ------------ {{{
-- Display diagnostic on via echo messaage instead of virtual_text
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

-- end seblj/nvim-echo-diagnostics }}}
-- Plugin jose-elias-alvarez/null-ls.nvim {{{

vim.lsp.buf.format({ timeout_ms = 3000 })

-- null-ls formatting on save.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, 'textDocument/formatting', vim.lsp.util.make_formatting_params({}), function(err, res, ctx)
    if err then
      local err_msg = type(err) == 'string' and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify('formatting: ' .. err_msg, vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, 'modified') then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or 'utf-16')
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd('silent noautocmd update')
      end)
    end
  end)
end

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local null_ls = require('null-ls')

-- Python run null-ls runtime_condition function.
function python_null_ls_condition(params)
  -- Dont run mypy on installed packages etc.
  if string.find(params.bufname, 'site-packages') then
    return false
  elseif string.find(params.bufname, '.pyenv') then
    return false
  elseif string.find(params.bufname, 'Python.framework') then
    return false
  elseif string.find(params.bufname, 'pb2') then
    return false
  else
    return true
  end
end

null_ls.setup({
  sources = {
    -- Python
    null_ls.builtins.formatting.black.with({
      runtime_condition = python_null_ls_condition,
    }),
    null_ls.builtins.formatting.isort.with({
      extra_args = { '--profile', 'black', '--ca' },
      runtime_condition = python_null_ls_condition,
    }),
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { '--follow-imports', 'silent' },
      runtime_condition = python_null_ls_condition,
    }),
    -- C/C++
    null_ls.builtins.formatting.clang_format.with({ filetypes = { 'c', 'cpp', 'proto' } }),
    null_ls.builtins.diagnostics.clang_check.with({ filetypes = { 'c', 'cpp' } }),
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
    null_ls.builtins.formatting.prettier.with({ prefer_local = 'node_modules/.bin' }),
    -- CMake
    null_ls.builtins.formatting.cmake_format,
    -- Lua
    null_ls.builtins.formatting.stylua.with({
      extra_args = { '--indent-type', 'spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
    }),
  },

  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          async_formatting(bufnr)
        end,
      })
    end
  end,
})

-- end null-ls }}}

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
    table.insert(lsp_client_names, client.name .. '(' .. client.id .. ')')
  end
  local lsp_msg = vim.lsp.util.get_progress_messages()[1]
  if lsp_msg then
    local name = lsp_msg.name or ''
    local msg = lsp_msg.message or ''
    local percentage = lsp_msg.percentage or 0
    local title = lsp_msg.title or ''
    return string.format(' %%<%s: %s %s (%s%%%%) ', name, title, msg, percentage)
  elseif #lsp_clients > 0 then
    return '[ ' .. table.concat(lsp_client_names, ' ') .. ' ]'
  else
    return '[ NO LSP ]'
  end
end

require('lualine').setup({
  options = {
    theme = 'papercolor_dark',
    -- icons_enabled = false,
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_c = {
      'filename',
      'lsp_progress()',
    },
  },
})

--}}}
