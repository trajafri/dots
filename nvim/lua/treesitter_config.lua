require("nvim-treesitter").install({'haskell', 'typescript', 'rust'})
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start)
  end
})
