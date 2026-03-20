## Source from conf.d before our fish config
source /usr/share/cachyos-fish-config/conf.d/done.fish


## Set values
## Run fastfetch as welcome message
function fish_greeting
end

# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end


function update_all
    sudo nvim -u ~/dotfiles/config/vim/init.vim -c :PlugUpgrade -c :PlugUpdate -c :q -c :q
    arch-update
end

function create_pyvenv
    if test (count $argv) -lt 2 -o (count $argv) -gt 3
        echo "Usage: create_pyvenv <venv_name> <requirements_file> <optional: python version>"
        return 1
    end

    if test (count $argv) -eq 3
        pyenv install "$argv[3]"
        pyenv shell "$argv[3]"
    end

    python -m venv "$HOME/.venv/$argv[1]"
    source "$HOME/.venv/$argv[1]/bin/activate.fish"

    python -m pip install -r "$argv[2]"
end

function pyvenv
    if test (count $argv) -ne 1
        echo "Usage: pyvenv <venv_name>"
        return 1
    end
    source "$HOME/.venv/$argv[1]/bin/activate.fish"
end

function adb_connect_mdns
    for line in (avahi-browse --terminate --resolve --parsable --no-db-lookup _adb-tls-connect._tcp)
        if not string match -q '=*' $line
            continue
        end

        set fields (string split ';' $line)
        set uri "$fields[8]:$fields[9]"

        echo "INFO: it will try to connect on $uri"
        set adb_result (adb connect $uri)
        echo $adb_result

        # Note: adb exits with 0 even if the connection fails,
        # so I'm checking its output
        if string match -q '*connected*' $adb_result
            echo "INFO: successfully connected"
            return 0
        end
    end

    echo "ERROR: unable to identify the ADB port on the android device"
    return 1
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles

# Common use
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias update='yay -Syu'
alias inst='yay -S'
alias uinst='yay -Rsnc'
alias search='yay -Ss'
alias vim='nvim'
alias svim='sudo nvim'
# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

set -x JAVA_HOME $(dirname $(dirname $(readlink -f $(which java))))
set -x CAPACITOR_ANDROID_STUDIO_PATH /usr/bin/android-studio
set -x ANDROID_SDK_ROOT /opt/android-sdk/
set -x CHROME_BIN /usr/bin/chromium
set -x EDITOR /usr/bin/nvim

fish_config theme choose Dracula