set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/bash

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'VundleVim/Vundle.vim'


Plug 'vim-latex/vim-latex'
Plug 'c.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'petRUShka/vim-opencl'
Plug 'dantler/vim-alternate'
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
Plug 'JesseKPhillips/d.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()            " required
filetype plugin indent on    " required

let g:python_host_prog = '/usr/bin/python2.7'

let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>

" set tabs and shifts to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4


" color and optical enhancements
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on
set background=dark
colorscheme gruvbox
set laststatus=2
set relativenumber
set number
set nowrap

" highlights
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme = 'sky'

set wildmenu
set showcmd
set hlsearch
nnoremap <F3> :set hlsearch!<CR>
set ruler

set ignorecase
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

map <F7> :w !xclip<CR><CR>
vmap <F7> "*y
map <S-F7> :r!xclip -o<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntasitc_c_clang_check_post_args = ""
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11'

"ycm
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_instertion = 1
let g:ycm_confirm_extra_conf = 0

let g:deoplete#enable_at_startup = 1
