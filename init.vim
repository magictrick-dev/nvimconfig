" ------------------------------------------------------------------------------
" General Configuration
" ------------------------------------------------------------------------------
set ts=4
set sw=4
set expandtab

set relativenumber number 
set mouse=
set colorcolumn=80

nnoremap <C-i> :bnext<cr>
nnoremap <S-tab> :bprevious<cr>

" ------------------------------------------------------------------------------
" Vim Plug Setup & Installations
" ------------------------------------------------------------------------------

call plug#begin()

	Plug 'tanvirtin/monokai.nvim'

	Plug 'nvim-lua/plenary.nvim'

	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

 	Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
	Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

	Plug 'mg979/vim-visual-multi', {'branch': 'master'}

	Plug 'preservim/nerdtree'

call plug#end()

" ------------------------------------------------------------------------------
" Plugin Maps
" ------------------------------------------------------------------------------

nnoremap <C-p> :Telescope find_files<cr>
nnoremap <C-o> :Telescope live_grep<cr>
nnoremap <C-l> :NERDTreeRefreshRoot<cr>:NERDTreeToggle<cr>

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ------------------------------------------------------------------------------
" Lua Configuration
" ------------------------------------------------------------------------------
lua << EOF

    -- Use monokai pro, disable irritating italics for comments
	require('monokai').setup { palette = require('monokai').pro, italics = false }

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

	-- Setup my coq. lol
	require("coq")
EOF


let g:coq_settings = { 'auto_start': 'shut-up' }
