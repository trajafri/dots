-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- we used to use packer, but seems like lazy.nvim is the modern/recommended plugin manager
-- ensure lazy.nvim is installed
--                                      v .. is string concat
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"   
--               ^our system's dedicated local storage

-- uv/loop are nvim's IO and OS interface library (loop is the old name)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end

-- rtp==runtime path. We always want to consider lazy.nvim path
-- so that "require(lazy)" below works
vim.opt.rtp:prepend(lazypath)

-- lazy's init.lua returns an object with the setup function
-- this is how we use the plugin manager to install the plugins
-- (note: order of plugins does not matter)
require('lazy').setup({

  -- nvim configuration to work with common langauge servers
  -- eg, it has config for hls (haskell language server) to provider
  -- language server for .hs files
  {'neovim/nvim-lspconfig',
   config = function() require('lsp_config') end
  },

  -- plugin to download binaries.
  -- this is used for obtained language servers, debug servers, linters, formatters etc
  {'williamboman/mason.nvim'},

  -- plugin to make mason downloaded binaries avaialable to nvim-lspconfig
  {'williamboman/mason-lspconfig.nvim',
   opts = {
     -- add more servers as needed (or just say automatic_installation = true)
     ensure_installed = { 'hls', 'ts_ls' },

     -- trigger vim.lsp.enable() 
     automatic_enable = true
   },
   dependencies = {{'williamboman/mason.nvim', opts = {}}, 'neovim/nvim-lspconfig'}
  },

  -- color scheme
  {'folke/tokyonight.nvim'},

  -- syntax support/highlighting
  {'nvim-treesitter/nvim-treesitter',
   build = ':TSUpdate', -- run TSUpdate whenever this plugin updates
   config = function() require('treesitter_config') end
  },
  {'maxbane/vim-asm_ca65'}, --6502 assembly
  {'leafo/moonscript-vim'}, --moonscript

  -- completion engine
  {'hrsh7th/nvim-cmp',
   dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/cmp-nvim-lua',
		'hrsh7th/vim-vsnip',
	 },
   config = function() require('cmp_config') end
  },

  -- file system tree plugin
  { 'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
	  dependencies = { 
		 'nvim-lua/plenary.nvim',
		 'MunifTanjim/nui.nvim',
     -- note: some terminals might not be able to preview images
		 -- 'nvim-tree/nvim-web-devicons'
	  },
	  config = function() require('neotree_config') end
  }

  -- some more plugins to consider
  --'TimUntersberger/neogit',requires = 'nvim-lua/plenary.nvim',config = function() require('neogit_config') end
  --'hrsh7th/vim-vsnip',config = function() require('vsnip_config') end,
  --'hrsh7th/vim-vsnip-integ'
  --'nvim-telescope/telescope.nvim',requires = 'nvim-lua/plenary.nvim',config = function() require('telescope_config') end
  --'mfussenegger/nvim-dap',config = function() require('dap_config') end
  --'rcarriga/nvim-dap-ui',requires = 'mfussenegger/nvim-dap',config = function() require("dapui_config") end,
  --'theHamsta/nvim-dap-virtual-text',config = function() require("nvim-dap-virtual-text").setup() end,
})
