call plug#begin('~/.config/nvim/plugged')
Plug 'Valloric/YouCompleteMe'
call plug#end()

let g:ycm_global_ycm_extra_conf = '~/.config/nvim/ycm_global_extra_conf.py'
let g:ycm_enable_diagnostic_signs=0

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set completeopt-=preview

set noswapfile
set confirm

syntax enable
colorscheme monokai

set foldmethod=syntax
set foldlevel=99

hi clear SpellBad
hi SpellBad cterm=undercurl,bold

set number
set clipboard+=unnamedplus
autocmd filetype cpp setlocal ts=4 sts=4 sw=4 expandtab smartindent
autocmd filetype cpp nnoremap <F8> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp inoremap <F8> <Esc> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp nnoremap <F9> :w <bar> !make test <CR>
autocmd filetype cpp inoremap <F9> <Esc> :w <bar> !make test <CR>
