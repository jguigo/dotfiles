# ╭──────────────────────────────────────────────────────────╮
# │ FNM (Node Version Manager)                               │
# ╰──────────────────────────────────────────────────────────╯

eval "$(fnm env --use-on-cd)"
eval "$(pyenv init -)"
eval "$(/home/jguigo/.local/bin/mise activate zsh)"


# ╭──────────────────────────────────────────────────────────╮
# │ Oh-My-Zsh                                                │
# ╰──────────────────────────────────────────────────────────╯

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# ╭──────────────────────────────────────────────────────────╮
# │ Starship Prompt                                          │
# ╰──────────────────────────────────────────────────────────╯

eval "$(starship init zsh)"


# ╭──────────────────────────────────────────────────────────╮
# │ Aliases                                                  │
# ╰──────────────────────────────────────────────────────────╯

alias code="codium"
alias change-waybar='bash ~/dotfiles/scripts/set-waybar-theme.sh'
alias pac-installed="pacman -Qqe | fzf --preview 'pacman -Qil {}' --layout=reverse --bind \"enter:execute(pacman -Qil {} | less)\""
alias polkit="/usr/lib/polkit-kde-authentication-agent-1"
alias lg="lazygit"

# ╭──────────────────────────────────────────────────────────╮
# │ Environment Variables                                    │
# ╰──────────────────────────────────────────────────────────╯

# Load environment variables from your custom .env file
if [ -f "$HOME/dotfiles/.env" ]; then
    while IFS= read -r line; do
        if [[ ! $line =~ ^# ]]; then
            export "$line"
        fi
    done < "$HOME/dotfiles/.env"
fi

export GOPRIVATE=github.com/NuVidio/*
export PATH=$PATH:$(go env GOPATH)/bin

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"


# ╭──────────────────────────────────────────────────────────╮
# │ Functions / Snippets                                     │
# ╰──────────────────────────────────────────────────────────╯

kis() {
  local dir="$HOME/dotfiles/kitty/sessions/"
  local file=$(ls -1 "$dir" | fzf --prompt="Select kitty session: ")
  if [[ -n "$file" ]]; then
    hyprctl dispatch exec "kitty --session $dir/$file"
		exit
  fi
}

jira() {
  google-chrome-stable "https://nuvidio.atlassian.net/browse/$1"
}
