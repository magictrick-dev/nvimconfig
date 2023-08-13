" ------------------------------------------------------------------------------
" General Configuration
" ------------------------------------------------------------------------------
set ts=4
set sw=4
set expandtab

set relativenumber number 
set mouse=
set colorcolumn=80
set cursorline
set wrap!

nnoremap <C-i> :bnext<cr>
nnoremap <S-tab> :bprevious<cr>
nnoremap <C-k><C-k> :bp\|bd #<CR>

" ------------------------------------------------------------------------------
" Windows Keymaps
" ------------------------------------------------------------------------------
if has('win32')
    nnoremap <C-b> :CJHBuild cmake --build ./build<cr>
    nnoremap <C-a><C-a> :CJHJumpTo<cr>
    nnoremap <F5> :!./run.ps1<cr>
    nnoremap <F8> :!./debug.ps1<cr>
    nnoremap <F3> :!explorer .<cr>
endif


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

command! -nargs=? CJHBuild lua require("CJH").build_script(<f-args>)
command! CJHJumpTo lua require("CJH").jump_to()
command! -nargs=? GitCommit lua require("githelper").git_committer(<f-args>)

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ------------------------------------------------------------------------------
" Lua Configuration
" ------------------------------------------------------------------------------

" Force COQ to auto load.
let g:coq_settings = { 'auto_start': 'shut-up' }

lua << EOF

    -- Use monokai pro, disable irritating italics for comments
	require('monokai').setup { palette = require('monokai').pro, italics = false }

    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

EOF

