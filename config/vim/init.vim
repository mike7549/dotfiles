if &compatible
	set nocompatible              " be iMproved, required
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" theme
Plug 'bling/vim-airline'
Plug 'arcticicestudio/nord-vim'
" formatting
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
" highlighting
Plug 'petRUShka/vim-opencl', {'on_ft' : 'cl'}
Plug 'tikhomirov/vim-glsl', {'on_ft' : 'glsl'}
Plug 'posva/vim-vue',{'on_ft' : 'vue'}
Plug 'donRaphaco/neotex', {'on_ft': 'tex'}
call plug#end()            " required

let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>

" set tabs and shifts to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" color and optical enhancements
if (has("termguicolors"))
 set termguicolors
endif
if has('gui_running')
	set guifont=Hack\ Regular\ Nerd\ Font\ Complete\ Mono.ttf
endif
syntax enable
colorscheme nord
set laststatus=2
set relativenumber
set number
set nowrap

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Tagbar
nmap <F8> :TagbarToggle<CR>

set wildmenu
set showcmd
set hlsearch
set hidden
set ruler

set ignorecase

set encoding=utf-8

set splitright

"other addons
let g:rainbow_active = 1
"indent chars
let g:indentLine_char = '│'

function OpenTermSplit()
    set splitright
    :70vs term://zsh
endfunction

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

set clipboard=unnamedplus
map <F7> :w !xclip<CR><CR>
vmap <F7> "*y
map <S-F7> :r!xclip -o<CR>
