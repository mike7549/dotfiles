if &compatible
	set nocompatible              " be iMproved, required
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'dantler/vim-alternate'
Plug 'scrooloose/nerdtree', {'on':'NERDTreeToggle'}
Plug 'JesseKPhillips/d.vim'
Plug 'ajmwagar/vim-deus'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-dispatch'
Plug 'dhruvasagar/vim-table-mode'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Chiel92/vim-autoformat'
Plug 'xolox/vim-easytags', { 'for': ['html', 'vue.html.javascript.css'] }
Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'vue.html.javascript.css'] }
Plug 'xolox/vim-misc'
Plug 'majutsushi/tagbar'
" highlighting
Plug 'tikhomirov/vim-glsl', { 'for': 'glsl' } 
Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'vue.html.javascript.css'] }
Plug 'posva/vim-vue', { 'for': 'vue.html.javascript.css' }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'vue.html.javascript.css'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'othree/html5.vim', { 'for': ['html', 'vue.html.javascript.css'] }
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'bling/vim-airline'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'drmikehenry/vim-fixkey'
call plug#end()            " required

let mapleader = ","
let g:mapleader = ","
nmap <leader>w :w!<cr>

" set tabs and shifts to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4


" color and optical enhancements
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax enable
set background=dark
colorscheme deus
let g:deus_termcolors=256
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
let g:deoplete#enable_at_startup = 1

"deoplete clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
let g:deoplete#sources#clang#std#cpp = 'c++14'

"ctrlp
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
