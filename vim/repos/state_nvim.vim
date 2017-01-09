if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/michael/dotfiles/vim/init.vim'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/michael/dotfiles/vim/repos'
let g:dein#_runtime_path = '/home/michael/dotfiles/vim/repos/.cache/init.vim/.dein'
let g:dein#_cache_path = '/home/michael/dotfiles/vim/repos/.cache/init.vim'
let &runtimepath = '/root/.config/nvim,/etc/xdg/nvim,/root/.local/share/nvim/site,/usr/local/share/nvim/site,/home/michael/dotfiles/vim/repos/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/root/.local/share/nvim/site/after,/etc/xdg/nvim/after,/root/.config/nvim/after,/home/michael/dotfiles/vim/repos/github.com/Shougo/dein.vim,/home/michael/dotfiles/vim/repos/.cache/init.vim/.dein/after'
filetype off
