if has('win32') || has('win64')
    let g:lsp_log_file = expand('C:\\Users\\Pancakes\\vim-lsp.log')
else
    let g:lsp_log_file = expand('~/.vim/lsp.log')
endif

call plug#begin('~/vimfiles/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'bluz71/vim-moonfly-colors'
Plug 'caglartoklu/borlandp.vim'
Plug 'puremourning/vimspector'

call plug#end()

if has('termguicolors')
    set termguicolors
endif

set number
set relativenumber

let g:borlandp_bg = "black"
set columns=80 lines=25
colorscheme borlandp

nnoremap <leader>ff :Files<CR>
nnoremap <leader>bb :Buffers<CR>

nnoremap <leader>gs :Gstatus<CR>

nnoremap <leader>n :NERDTreeToggle<CR>

nnoremap <leader>lg :LspLog<CR>
nmap <silent> gd :LspDefinition<CR>
nmap <silent> gr :LspReferences<CR>
nmap <silent> gi :LspImplementation<CR>
nmap <silent> K :LspHover<CR>
nmap <silent> <leader>rn :LspRename<CR>
nmap <silent> <leader>ca :LspCodeAction<CR>

au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': { server_info -> ['clangd', '--background-index', '--clang-tidy'] },
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })

if executable('java')
    let workspace = expand('C:\\Users\\Pancakes\\.cache\\jdtls\\workspace\\') . substitute(fnamemodify(getcwd(), ':p:h:t'), '[\\/:*?"<>|]', '_', 'g')
    let jdtls_dir = 'C:\\tools\\jdtls\\'
    
    let java_path = 'C:\\Program Files\\BellSoft\\LibericaJDK-25-Full\\bin\\java.exe'
    if filereadable(java_path)
        let java_cmd = java_path
    else
        let java_cmd = 'java'
    endif
    
    let launcher_jar = glob(jdtls_dir . 'plugins/org.eclipse.equinox.launcher_*.jar')
    
    call lsp#register_server({
        \ 'name': 'jdtls',
        \ 'cmd': [
            \ java_cmd,
            \ '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \ '-Dosgi.bundles.defaultStartLevel=4',
            \ '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \ '-Dlog.protocol=true',
            \ '-Dlog.level=ALL',
            \ '-Xms1g',
            \ '--add-modules=ALL-SYSTEM',
            \ '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            \ '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            \ '-jar', launcher_jar,
            \ '-configuration', jdtls_dir . 'config_win',
            \ '-data', workspace
            \ ],
        \ 'whitelist': ['java'],
        \})
endif

filetype plugin indent on
set completeopt=
let g:lsp_signature_enable = 0
set lazyredraw
set updatetime=1000

nnoremap <Up>    :echo 'Use k instead'<CR>:<CR>
nnoremap <Down>  :echo 'Use j instead'<CR>:<CR>
nnoremap <Left>  :echo 'Use h instead'<CR>:<CR>
nnoremap <Right> :echo 'Use l instead'<CR>:<CR>

inoremap <Up>    <C-O>:echo 'Use k instead'<CR>
inoremap <Down>  <C-O>:echo 'Use j instead'<CR>
inoremap <Left>  <C-O>:echo 'Use h instead'<CR>
inoremap <Right> <C-O>:echo 'Use l instead'<CR>

vnoremap <Up>    :echo 'Use k instead'<CR>
vnoremap <Down>  :echo 'Use j instead'<CR>
vnoremap <Left>  :echo 'Use h instead'<CR>
vnoremap <Right> :echo 'Use l instead'<CR>

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

highlight markdownId NONE
highlight markdownLineStart NONE
highlight markdownH1 NONE
highlight markdownH2 NONE
highlight markdownHeadingRule NONE
highlight markdownRule NONE
highlight markdownCode NONE
highlight markdownCodeBlock NONE
highlight markdownIdDeclaration NONE
