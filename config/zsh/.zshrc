# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt.zsh"
fi

export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export EDITOR=nvim
export VISUAL=nvim
export TERM=kitty
export GTK_THEME=deepin-dark
export XDG_CONFIG_HOME=$HOME/.config

export CAPACITOR_ANDROID_STUDIO_PATH=/usr/bin/android-studio
export ANDROID_SDK_ROOT=/opt/android-sdk
export CHROME_BIN=/usr/bin/chromium
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))

source $HOME/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'

alias inst='yay -S'
alias uinst='yay -Rsnc'
alias search='yay -Ss'

alias dd='sudo dd status=progress bs=4M'

alias x='atool -x'

alias nvim='sudo nvim -u ~/dotfiles/config/vim/init.vim'
alias vim='nvim -u ~/dotfiles/config/vim/init.vim'
alias reload='omz reload'
alias www='web_search duckduckgo'
alias icat="kitty +kitten icat"
alias adb_wireless_connect='sh $HOME/dotfiles/scripts/adb-wireless-connect.sh'

source ~/dotfiles/config/zsh/functions

autoload -Uz compinit -u
compinit -u
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# pnpm
export PNPM_HOME="/home/michael/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Load Angular CLI autocompletion.
source <(ng completion script)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
