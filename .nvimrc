
" show line numbers
set number
set nocompatible

" set tab width to 4
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

" allow switching buffers without saving
set hidden

" directories for vim temp files	
set backupdir=/tmp/
set directory=/tmp/

" vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'djoshea/vim-autoread'
Plug 'scrooloose/nerdtree'
Plug 'goatslacker/mango.vim'
Plug 'altercation/vim-colors-solarized'
" functionality handled below, don't know which is better
" Plug 'gangleri/vim-diffsaved'
Plug 'Shougo/neocomplete.vim'
call plug#end()

" solarized color settings
syntax enable
set background=dark
silent! colorscheme solarized

" fade EOB tildes
hi! EndOfBuffer ctermfg=black

" special airline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" cursor wrapping
set whichwrap+=<,>,h,l,[,]

" diff unsaved changes
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		\ | wincmd p | diffthis

" omnicomplete
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" enable neocomplete
let g:neocomplete#enable_at_startup = 1
let g:ctrlp_show_hidden = 1


