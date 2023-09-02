-- -----------------------------------------------------------------------------
-- Magic Tricks' Neovim Configuration File
-- -----------------------------------------------------------------------------
-- Load our packer plugins and then initialize them.
local is_windows = vim.fn.has('win32')
local plugins = require('plugins')
plugins.init_plugins(is_windows)

-- Basic neovim configuration setup.
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4
vim.opt.expandtab       = true
vim.opt.relativenumber  = true
vim.opt.number          = true
vim.opt.mouse           = nil
vim.opt.colorcolumn     = { 80, }
vim.opt.cursorline      = true
vim.opt.iskeyword       = "a-z,A-Z,48-57,.,-,>"
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
vim.keymap.set('n', '<leader>bs', ':vsplit<cr><C-w><C-w>', {})    -- Split buffer.
vim.keymap.set('n', '<leader>bn', ':bn<cr>', {})        -- new buffer.

--      Line related commands.
vim.keymap.set('n', '<leader>ls', '^', {})
vim.keymap.set('n', '<leader>le', '$', {})

--      Delete related commands.
vim.keymap.set('n', '<leader>dl', 'dd', {})
vim.keymap.set('n', '<leader>drl', 'ddO', {})
vim.keymap.set('n', '<leader>de', 'd$', {})
vim.keymap.set('n', '<leader>dre', 'd$a', {})

vim.keymap.set('n', '<leader>d(', 'F(lvf)hd<esc>', {})
vim.keymap.set('n', '<leader>dr(', 'F(lvf)hd<esc>i', {})

vim.keymap.set('n', '<leader>d"', 'F"lvf"hd<esc>', {})
vim.keymap.set('n', '<leader>dr"', 'F"lvf"hd<esc>i', {})

vim.keymap.set('n', '<leader>dbody{', '?{<cr>V/}<cr>dO<esc>i{<cr>}<esc>:noh<cr>O', {}) -- Crazy ass macro.

--      Magic Tricks' custom commands. (May not work for your env.)
vim.keymap.set('n', '<C-b>', ':MagicBuild<cr>', {})     -- Runs build on Control-b.
vim.keymap.set('n', '<leader>jj', ':MagicJump<cr>', {}) -- Jumps to file from build output.

--      Platform related key-bindings.
if is_windows then
    vim.keymap.set('n', '<F3>', ':!explorer .<cr><cr>', {})
    vim.keymap.set('n', '<F5>', ':!pwsh ./run.ps1<cr><cr>', {})
    vim.keymap.set('n', '<F8>', ':!pwsh ./debug.ps1<cr><cr>', {})
end

