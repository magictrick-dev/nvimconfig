
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
" :ConfigEnvironment "env name"
"       This is the primary function which allows for dynamically loading any
"       environments stored within the configuration folder.
" ------------------------------------------------------------------------------
function Configenv(...)
    " Ensure that we have the correct number of arguments.
    if a:0 < 1
        return
    endif

    " Attempt to source the argument.
    let root_path = "~/Development/Tools/nvim-conf/"
    let root_path = root_path . a:1
    let root_path = root_path . "_config.vim"

    let execution_command = "source "
    let execution_command = execution_command . root_path
    
    echo "Loading " . root_path . " into source."
    exec execution_command
endfunction
command! -nargs=1 ConfigEnvironment call Configenv(<args>)

" ------------------------------------------------------------------------------
" Vim Plug Setup & Installations
" ------------------------------------------------------------------------------

call plug#begin()

	Plug 'tanvirtin/monokai.nvim'

	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ------------------------------------------------------------------------------
" Telescope Maps
" ------------------------------------------------------------------------------

nnoremap <C-p> :Telescope find_files<cr>
nnoremap <C-o> :Telescope live_grep<cr>


" ------------------------------------------------------------------------------
" CoC Maps & Functions
" ------------------------------------------------------------------------------

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

lua << EOF
	require('monokai').setup { italics = false }
EOF

