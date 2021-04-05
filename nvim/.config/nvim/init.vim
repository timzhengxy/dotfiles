call plug#begin('~/.config/nvim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
call plug#end()

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_global_extra_conf.py'
let g:ycm_enable_diagnostic_signs=0

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


syntax on
set shortmess+=I
colorscheme monokai

set completeopt-=preview

set noswapfile
set confirm

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent
set foldmethod=syntax
set foldlevel=99
set ignorecase
set smartcase

hi clear SpellBad
hi SpellBad cterm=undercurl,bold

"ycm list errors"
let g:ycm_always_populate_location_list = 1

"let g:python3_host_prog="/home/tim/.virtualenvs/cs41-env/bin/python"
let g:python3_host_prog="/usr/bin/python3"

set number
set clipboard+=unnamedplus
autocmd filetype cpp nnoremap <F8> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp inoremap <F8> <Esc> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp nnoremap <F9> :w <bar> !make test <CR>
autocmd filetype cpp inoremap <F9> <Esc> :w <bar> !make test <CR>
