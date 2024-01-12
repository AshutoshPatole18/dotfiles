---@type ChadrcConfig 
 local M = {}
 M.ui = {theme = 'gatekeeper'}
 M.plugins = "custom.plugins"
 -- M.mappings = require "custom.mappings"
vim.api.nvim_set_keymap("n", "<leader>fo", ":%!shfmt<CR>", { noremap = true })
 return M
