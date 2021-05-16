set number
set mouse=a
set numberwidth=1
syntax enable
set encoding=UTF-8
set sw=1
set relativenumber
set tabstop=2 
set shiftwidth=2 

set expandtab

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
"let g:clang_c_options = '-std=gnu17'
let g:coc_node_path = '~/.config/nvm/versions/node/v14.15.4/bin/node'

Plugin 'VundleVim/Vundle.vim'

Plugin 'neoclide/coc.nvim', {'branch': 'release'}

" directorios
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'ryanoasis/vim-devicons'
Plugin 'ryanoasis/vim-webdevicons'
" node
Plugin 'moll/vim-node'
" Buscador
Plugin 'easymotion/vim-easymotion'

" Temas
"Plugin 'https://github.com/sickill/vim-monokai'
Plugin 'morhetz/gruvbox'
"Plugin 'hzchirs/vim-material'

Plugin 'https://github.com/mxw/vim-jsx'
Plugin 'https://github.com/jelera/vim-javascript-syntax'

" Formatos
Plugin 'maksimr/vim-jsbeautify'
Plugin 'prettier/vim-prettier'

" Git Support
Plugin 'gregsexton/gitv'
Plugin 'tpope/vim-fugitive'
Plugin 'jaxbot/github-issues.vim'

" Ruby support
Plugin 'vim-ruby/vim-ruby'

call vundle#end()
" required
filetype plugin indent on " required

" -----------------------------------
" Atajos y configuraciones de plugins
" -----------------------------------

let g:acp_completeoptPreview = 1
:imap ii <Esc>

" Coc
" -----------------------------------------------
" -----------------------------------------------
"let g:coc_global_extensions = [ 'coc-tsserver' ]

autocmd FileType scss setl iskeyword+=@-@
" -----------------------------------------------
" -----------------------------------------------

let g:NERDTreeChDirMode = 2

" vim-airline
let g:airline#extensions#tabline#enabled = 1 " Mostrar buffers abiertos (como pestañas)
let g:airline#extensions#tabline#fnamemod = ':t'
" Mostrar solo el nombre del archivo
let g:airline_powerline_fonts = 1
set noshowmode

" Abrir/cerrar NERDTree con espacio b
let mapleader = " "
nmap <Leader>b :NERDTreeToggle<CR>
nmap <Leader>n :NERDTreeFocus<CR>
nmap <Leader>f :NERDTreeFind<CR>

nmap <leader> gd <Plug>(coc-definition)
nmap <leader> gy <Plug>(coc-type-definition)
nmap <leader> gi <Plug>(coc-implementation)

" GO
let g:go_fmt_command = "goimports"

" Buscar easymotion con espacio s
nmap <Leader>s<Plug>(easymotion - s2)

" Tema oscuro
"colorscheme monokai
set bg=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"

" Formato
nmap <Leader>j: call JsBeautify() <CR>
" for html
nmap <Leader>h: call HtmlBeautify() <CR>
" for css or scss
autocmd FileType css noremap <buffer> <c-f>:call CSSBeautify() <cr>

" Guardar y salir
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

" Cpp
autocmd FileType c, cpp setlocal expandtab shiftwidth = 2 softtabstop = 2 cindent

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:javascript_plugin_jsdoc = 1
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.svelte'


" Temporar
" nmap<Leader>gc :!python manage.py runserver<CR>
nmap <Leader>gc :GoRun<CR>
