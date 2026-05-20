require('dapui').setup({
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<tab>", "<2-LeftMouse>" }, -- default = "<cr>"
		open = "<cr>",  -- default = "o"
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},

	layouts = {
		{
			elements = {
				-- override default, keep scopes/stack next to each other
				{ id = "watches", size = 0.25 },
				"breakpoints",
				"stacks",
				"scopes",
			},
			size = 40, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
	},
})

vim.keymap.set(
	'n',
	'<leader>dui',
	function() require("dapui").toggle() end
)
vim.keymap.set(
	{'n','v'},
	'<M-k>',
	function() require("dapui").eval() end
)

-- override key binding from dap_config, to ensure ui is shown when we start debugging
vim.keymap.set(
	'n',
	'<F5>',
	function()
		require("dapui").open()
		require("dap").continue()
	end
)
