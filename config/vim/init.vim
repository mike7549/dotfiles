let s:plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug_path))
	silent execute '!curl -fLo ' . s:plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" theme
Plug 'vim-airline/vim-airline'
Plug 'dracula/vim', { 'as': 'dracula' }
" formatting
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
" highlighting
Plug 'petRUShka/vim-opencl', {'for' : 'opencl'}
Plug 'tikhomirov/vim-glsl', {'for' : 'glsl'}
Plug 'posva/vim-vue', {'for' : 'vue'}
Plug 'donRaphaco/neotex', {'for': 'tex'}
call plug#end()

let mapleader = ","
nmap <leader>w :w!<cr>

" set tabs and shifts to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" color and optical enhancements
set termguicolors
colorscheme dracula
set relativenumber
set number
set nowrap

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Tagbar
nmap <F8> :TagbarToggle<CR>

set ignorecase

set splitright

"other addons
let g:rainbow_active = 1
"indent chars
let g:indentLine_char = '│'

function! OpenTermSplit()
	execute '70vsplit term://' . &shell
endfunction

map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" uses wl-copy/wl-paste on wayland
set clipboard=unnamedplus
