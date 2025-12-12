call plug#begin('~/vimfiles/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'letorbi/vim-colors-modern-borland'
Plug 'bluz71/vim-moonfly-colors'

call plug#end()

syntax on
if has('termguicolors')
    set termguicolors
endif

set number
set relativenumber

"colorscheme borland
"let g:BorlandStyle = 'classic'
"let g:BorlandParen = 1
colorscheme moonfly

nnoremap <leader>ff :Files<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>n  :NERDTreeToggle<CR>
nnoremap <leader>lg :LspLog<CR>

nmap <silent> gd :LspDefinition<CR>
nmap <silent> gr :LspReferences<CR>
nmap <silent> gi :LspImplementation<CR>
nmap <silent> K  :LspHover<CR>
nmap <silent> <leader>rn :LspRename<CR>
nmap <silent> <leader>ca :LspCodeAction<CR>

au User lsp_setup call lsp#register_server({
            \ 'name': 'clangd',
            \ 'cmd': {server_info -> ['clangd', '--background-index', '--clang-tidy']},
            \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
            \ })

au User lsp_setup call lsp#register_server({
            \ 'name': 'jdtls',
            \ 'cmd': {server_info -> ['jdtls']},
            \ 'whitelist': ['java'],
            \ })

au User lsp_setup call lsp#register_server({
            \ 'name': 'lua-language-server',
            \ 'cmd': {server_info -> ['/path/to/lua-language-server']},
            \ 'whitelist': ['lua'],
            \ })

filetype plugin indent on

set completeopt=
let g:lsp_signature_enable = 0
set lazyredraw
set updatetime=1000

nnoremap <Up>    :echo "Use k instead"<CR>
nnoremap <Down>  :echo "Use j instead"<CR>
nnoremap <Left>  :echo "Use h instead"<CR>
nnoremap <Right> :echo "Use l instead"<CR>

inoremap <Up>    <C-O>:echo "Use k instead"<CR>
inoremap <Down>  <C-O>:echo "Use j instead"<CR>
inoremap <Left>  <C-O>:echo "Use h instead"<CR>
inoremap <Right> <C-O>:echo "Use l instead"<CR>

vnoremap <Up>    :echo "Use k instead"<CR>
vnoremap <Down>  :echo "Use j instead"<CR>
vnoremap <Left>  :echo "Use h instead"<CR>
vnoremap <Right> :echo "Use l instead"<CR>
