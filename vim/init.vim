if &compatible
	set nocompatible              " be iMproved, required
endif

filetype off                  " required
set shell=/bin/zsh

"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"	autocmd VimEnter * PlugInstall
"endif
"call plug#begin('~/.config/nvim/plugged')
"Plug 'c.vim
"call plug#end()            " required

" Required:
set runtimepath+=/home/michael/dotfiles/vim/deinvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('home/michael/dotfiles/vim/deinvim/repos')
call dein#begin('/home/michael/dotfiles/vim/deinvim/repos')
call dein#add('Shougo/dein.vim')
call dein#add('vim-latex/vim-latex')
call dein#add('bling/vim-airline')
call dein#add('petRUShka/vim-opencl')
call dein#add('dantler/vim-alternate')
call dein#add('morhetz/gruvbox')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('ervandew/supertab')
call dein#add('scrooloose/nerdtree')
call dein#add('Easymotion/vim-easymotion')
call dein#add('JesseKPhillips/d.vim')
call dein#add('posva/vim-vue')
call dein#add('tikhomirov/vim-glsl')
call dein#add('tpope/vim-sleuth')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-clang')
call dein#add('Shougo/neoinclude.vim')
call dein#add('jiangmiao/auto-pairs')
call dein#add('jeetsukumaran/vim-buffergator')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('Yggdroot/indentLine')
call dein#end()
call dein#save_state()
endif

"check on startupp for non installed plugins
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on    " required

syntax enable

"let g:python_host_prog = '/usr/bin/python2.7'

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

set wildmenu
set showcmd
set hlsearch
set hidden
nnoremap <F3> :set hlsearch!<CR>
set ruler

set ignorecase

set splitright

"indent chars
let g:indentLine_char = '|'

function OpenTermSplit()
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

"deoplete
call deoplete#enable()

"deoplete clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std#cpp = 'c++14'

"ctrlp
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
