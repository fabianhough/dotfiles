
--leader
vim.g.mapleader = "\\"
vim.keymap.set("n", "<leader>n", ":noh<CR>")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- misc
vim.opt.termguicolors = true
vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"

