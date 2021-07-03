call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'

" https://sharksforarms.dev/posts/neovim-rust/
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-fugitive'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

"LSP
syntax on
filetype plugin indent on

" https://sharksforarms.dev/posts/neovim-rust/
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
nvim_lsp.clangd.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }



let mapleader = "\<Space>"

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

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
set number
set clipboard+=unnamedplus

"let g:python3_host_prog="/home/tim/.virtualenvs/cs41-env/bin/python"
let g:python3_host_prog="/usr/bin/python3"

"cpp
autocmd filetype cpp nnoremap <F8> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp inoremap <F8> <Esc> :w <bar> !g++ -std=c++17 % -o %:r -fsanitize=address -fsanitize=undefined -DLOCAL <CR>
autocmd filetype cpp nnoremap <F9> :w <bar> !make test <CR>
autocmd filetype cpp inoremap <F9> <Esc> :w <bar> !make test <CR>

"R
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

"Rust
autocmd filetype rust nnoremap <F8>       :w <bar> !cargo check <CR>
autocmd filetype rust inoremap <F8> <Esc> :w <bar> !cargo check <CR>
autocmd filetype rust nnoremap <F9>       :w <bar> !cargo run <CR>
autocmd filetype rust inoremap <F9> <Esc> :w <bar> !cargo run <CR>

"fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <M-p> :Buffers<CR>

"toggle between current and last buffers
nnoremap <leader><leader> <c-^>
