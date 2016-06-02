alias ls 'ls --color=auto'
alias ll 'ls -l --color=auto'
alias la 'ls -l -a --color=auto'
alias inst 'yaourt -S'
alias uinst 'sudo pacman -Rsnc'
alias i3conf 'vim ~/.i3/config'
alias cddot 'cd ~/dotfiles/'
alias givepw 'base64 /dev/urandom | head -c 10'
alias update 'yaourt -Syua --force --noconfirm'
alias gn 'sh ~/dotfiles/scripts/gn.sh'
alias x 'atool -x'
alias vim 'nvim'

set EDITOR nvim
set VISUAL nvim
set WINEDEBUG -all
set WINEPREFIX /home/michael/.wine/

set PATH /usr/bin/ /usr/local/bin/ /usr/local/sbin /usr/sbin/ /usr/bin/core_perl/

# declare solarize colors
set u_col0 "#282828"
set u_col1 "#cc241d"
set u_col2 "#98971a"
set u_col3 "#d79921"
set u_col4 "#458588"
set u_col5 "#b16286"
set u_col6 "#689d6a"
set u_col7 "#a89984"
set u_col8 "#928374"
set u_col9 "#fb4934"
set u_cola "#b8bb26"
set u_colb "#fabd2f"
set u_colc "#83a598"
set u_cold "#d3869b"
set u_cole "#8ec07c"
set u_colf "#ebdbb2"

set TERMINAL termite
set WINEARCH win64 
set fish_greeting ""

eval (dircolors -c ~/.dircolors | sed 's/>&\/dev\/null$//')


set LD_PRELOAD "libpthread.so.0 libGL.so.1"
set __GL_THREADED_OPTIMIZATIONS 1

fish_vi_key_bindings

function win_reboot
	sudo efibootmgr -n 0000
	reboot
end


function sudo
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end

# Path to Oh My Fish install.
set -gx OMF_PATH /home/michael/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /home/michael/.config/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set -g theme_display_user yes



function fish_mode_prompt
# Do nothing if not in vi mode
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color --bold --background $u_col8 $u_colb
        echo ' N '
      case insert
        set_color --bold --background $u_col8 $u_colf
        echo ' I '
      case replace-one
        set_color --bold --background $u_col8 $u_col1 
        echo ' R '
      case visual
        set_color --bold --background $u_col8 $u_col3
        echo ' V '
    end
    set_color $u_col8 --background $u_cole
    echo ''
  end
end

