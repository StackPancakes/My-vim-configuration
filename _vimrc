" LSP logging - put this at the very top
if has('win32') || has('win64')
    let g:lsp_log_file = expand('C:\\Users\\Pancakes\\vim-lsp.log')
else
    let g:lsp_log_file = expand('~/.vim/lsp.log')
endif

" Plugin manager
call plug#begin('~/vimfiles/plugged')

Plug 'prabirshrestha/vim-lsp'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'letorbi/vim-colors-modern-borland'
Plug 'bluz71/vim-moonfly-colors'
Plug 'puremourning/vimspector'

call plug#end()

" Terminal colors
if has('termguicolors')
    set termguicolors
endif

" Line numbers
set number
set relativenumber

" Colorscheme
colorscheme moonfly

" FZF mappings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>bb :Buffers<CR>

" Git mappings
nnoremap <leader>gs :Gstatus<CR>

" NERDTree mapping
nnoremap <leader>n :NERDTreeToggle<CR>

" LSP mappings
nnoremap <leader>lg :LspLog<CR>
nmap <silent> gd :LspDefinition<CR>
nmap <silent> gr :LspReferences<CR>
nmap <silent> gi :LspImplementation<CR>
nmap <silent> K :LspHover<CR>
nmap <silent> <leader>rn :LspRename<CR>
nmap <silent> <leader>ca :LspCodeAction<CR>

" LSP server registration
au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': { server_info -> ['clangd', '--background-index', '--clang-tidy'] },
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })

" JDTLS configuration - ONLY ONE COPY!
if executable('java')
    let workspace = expand('C:\\Users\\Pancakes\\.cache\\jdtls\\workspace\\') . substitute(fnamemodify(getcwd(), ':p:h:t'), '[\\/:*?"<>|]', '_', 'g')
    let jdtls_dir = 'C:\\tools\\jdtls\\'
    
    " Specific Java path check
    let java_path = 'C:\\Program Files\\BellSoft\\LibericaJDK-25-Full\\bin\\java.exe'
    if filereadable(java_path)
        let java_cmd = java_path
    else
        let java_cmd = 'java'
    endif
    
    let launcher_jar = glob(jdtls_dir . 'plugins/org.eclipse.equinox.launcher_*.jar')
    
    " Debug: Uncomment next line to check paths
    " echo "Java: " . java_cmd . " | JAR: " . launcher_jar . " | Dir: " . jdtls_dir
    
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

" Filetype and completion settings
filetype plugin indent on
set completeopt=
let g:lsp_signature_enable = 0
set lazyredraw
set updatetime=1000

" Arrow key warnings (non-blocking version)
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

" Indentation settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" Markdown highlighting cleanup
highlight markdownId NONE
highlight markdownLineStart NONE
highlight markdownH1 NONE
highlight markdownH2 NONE
highlight markdownHeadingRule NONE
highlight markdownRule NONE
highlight markdownCode NONE
highlight markdownCodeBlock NONE
highlight markdownIdDeclaration NONE
