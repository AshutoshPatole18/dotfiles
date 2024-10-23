require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>mi", ':lua require("nvchad.mason").install_all()<CR>')
-- map("n", "ml", "require('nvchad.mason').install_all()")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
