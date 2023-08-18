--
-- Magic Tricks' Neovim Configuration File
--

-- Load our packer plugins and then initialize them.
local plugins = require('plugins')
plugins.init_plugins()

-- Basic neovim configuration setup.
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true
vim.opt.relativenumber  = true
vim.opt.number          = true
vim.opt.mouse           = nil
vim.opt.colorcolumn     = { 80, }
vim.opt.cursorline      = true
vim.g.leader            = "\\"

-- System agnostic keymaps.
--      Telescope keymaps.
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})

--      Buffer related commands.
vim.keymap.set('n', '<C-i>', ':bnext<cr>', {})
vim.keymap.set('n', '<S-tab>', ':bprevious<cr>', {})
vim.keymap.set('n', '<leader>kb', ':bp|bd #<cr>', {})

--      Magic Tricks' custom commands.
vim.keymap.set('n', '<C-b>', ':MagicBuild<cr>', {})
vim.keymap.set('n', '<leader>jj', ':MagicJump<cr>', {})

