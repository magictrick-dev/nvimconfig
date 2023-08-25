--
-- Plugin loading & configuration definitions.
--

-- Loads all plugins using packer.
require("packer").startup(function(use)

    use { 'morhetz/gruvbox', config = function()
        vim.cmd.colorscheme("gruvbox") end } 

    use { 'nvim-telescope/telescope.nvim',
    	requires = { {'nvim-lua/plenary.nvim'} } }
    use 'nvim-telescope/telescope-fzf-native.nvim'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

end)

-- Our initializer function.
local function initialize_plugins(platform_is_windows)

    -- Determine our platform. If it isn't windows, it is probably
    -- a POSIX compliant environment.
    local is_windows = platform_is_windows

    -- Tree-sitter configuration.
    --      Establish the platform to setup compile chain for treesitter.
    --      For windows, we need to ensure we're using MSVC's 64-bit compiler.
    --      You will need to source vcvars x64 to expose it; note that if you
    --      don't expressly tell vcvars to use x64, it defaults to x86!
    local compile_chain = { 'cc', 'gcc', 'clang' }
    if is_windows then compile_chain = { 'cl', 'clang' } end

    --      Setup the compile chain and how we fetch.
    require('nvim-treesitter.install').prefer_git   = false
    require 'nvim-treesitter.install'.compilers     = compile_chain

    --      Configuration setup.
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'glsl', 'vim', 'vimdoc', 'lua' },
        auto_install = true,
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

    }

    -- Airline configuration.
    vim.cmd([[ let g:airline#extensions#tabline#enabled = 1 ]])
    vim.cmd([[ let g:airline_powerline_fonts = 1 ]])

    -- Load custom plugins.
    --      GitHelper requires no additional configuration.
    require('magictrick/githelper')

    --      Jumper will need a default build script defined at startup.
    require('magictrick/jumper')
    if is_windows then
        require('magictrick/jumper').default_script = 'pwsh ./build.ps1'
    end


end



return {
    init_plugins = initialize_plugins  
}

