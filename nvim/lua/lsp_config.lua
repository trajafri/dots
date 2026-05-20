-- use mason to figure out lsp binaries
require('mason').setup()

local buf_map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
		noremap = true, silent = true,
	})
end

vim.lsp.config("*", {
  --only map the following keys after the language server attaches
  on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspDeclaration lua vim.lsp.buf.declaration()")
    vim.cmd("command! LspFormat lua vim.lsp.buf.format()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    buf_map(bufnr, 'n', 'gD',        ':LspDeclaration<cr>')
    buf_map(bufnr, 'n', 'gd',        ':LspDef<cr>')
    buf_map(bufnr, 'n', 'gy',        ':LspTypeDef<cr>')
    buf_map(bufnr, 'n', 'gi',        ':LspImplementation<cr>')
    buf_map(bufnr, 'n', 'gr',        ':LspRefs<cr>')
    buf_map(bufnr, 'n', 'K',         ':LspHover<cr>')
    buf_map(bufnr, 'n', '[e',        ':LspDiagPrev<cr>')
    buf_map(bufnr, 'n', ']e',        ':LspDiagNext<cr>')
    buf_map(bufnr, 'n', '<leader>e', ':LspDiagLine<cr>')
    buf_map(bufnr, 'n', '<C-k>',     ':LspSignatureHelp<cr>')
    buf_map(bufnr, 'n', '<space>wa', ':lua vim.lsp.buf.add_workspace_folder()<cr>')
    buf_map(bufnr, 'n', '<space>wr', ':lua vim.lsp.buf.remove_workspace_folder()<cr>')
    buf_map(bufnr, 'n', '<space>wl', ':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>')
    buf_map(bufnr, 'n', '<space>rn', ':LspRename<cr>')
    buf_map(bufnr, 'n', '<space>ca', ':LspCodeAction<cr>')
    buf_map(bufnr, 'n', '<space>f',  ':LspFormat<cr>')

    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            async = false,
            id = client.id
          })
        end
      })
    end
  end
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- rust (needs to be updated to work with post-breaking changes)
--require('rust-tools').setup({
--	tools = {
--		runnables = {
--			use_telescope = true,
--		},
--		inlay_hints = {
--			auto = true,
--			show_parameter_hints = false,
--			parameter_hints_prefix = "",
--			other_hints_prefix = "",
--		},
--	},
--
--	-- options to send to nvim-lspconfig
--	server = {
--		on_attach = on_attach,
--		capabilities = capabilities,
--		settings = {
--			["rust-analyzer"] = {
--				checkOnSave = {
--					command = "clippy",
--				},
--			},
--		},
--	},
--})

-- overrides for languages 
-- 
vim.lsp.config('hls', {
  settings = {
    haskell = {
      plugin = {
        semanticTokens = {
          globalOn = false -- true -- get better syntax highlighting, but makes things slower
        }
      }
    }
  }
})
-- (needs update after breaking changes)
-- vim.lsp.config('ts_ls', {
-- 	on_attach = function(client, bufnr)
-- 		-- disable tsserver's formatting; we'll use prettier instead
-- 		client.server_capabilities.documentFormattingProvider = false
-- 		client.server_capabilities.documentrangeFormattingProvider = false
-- 
-- 		local ts_utils = require('nvim-lsp-ts-utils')
-- 		ts_utils.setup({})
-- 		ts_utils.setup_client(client)
-- 		buf_map(bufnr, 'n', 'gs', ':TSLspOrganize<cr>')
-- 		--buf_map(bufnr, 'n', 'gi', ':TSLspRenameFile<cr>')
-- 		buf_map(bufnr, 'n', 'go', ':TSLspImportAll<cr>')
-- 
-- 		on_attach(client, bufnr)
-- 	end,
-- 
-- 	settings = {
-- 		completions = {
-- 			completeFunctionCalls = true,
-- 		},
-- 	},
-- })

-- (needs update)
--local null_ls = require('null-ls')
--
--null_ls.setup({
--	sources = {
--		null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
--		null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
--		null_ls.builtins.formatting.prettierd -- prettier, eslint, eslint_d, or prettierd
--	},
--	on_attach = on_attach,
--})

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"
