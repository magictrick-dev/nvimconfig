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
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').treesitter, {})

--      Buffer related commands.
vim.keymap.set('n', '<C-i>', ':bnext<cr>', {})          -- Next buffer.
vim.keymap.set('n', '<S-tab>', ':bprevious<cr>', {})    -- Prev buffer.
vim.keymap.set('n', '<leader>bk', ':bp|bd! #<cr>', {})  -- Kill buffer.
vim.keymap.set('n', '<leader>bs', ':vsplit<cr>', {})    -- Split buffer.
vim.keymap.set('n', '<leader>bn', ':bn<cr>', {})        -- new buffer.

--      Magic Tricks' custom commands. (May not work for your env.)
vim.keymap.set('n', '<C-b>', ':MagicBuild<cr>', {})     -- Runs build on Control-b.
vim.keymap.set('n', '<leader>jj', ':MagicJump<cr>', {}) -- Jumps to file from build output.


