# ╭──────────────────────────────────────────────────────────╮
# │ oh-my-zsh						                                     │
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
# │ Starship 						                                     │
# ╰──────────────────────────────────────────────────────────╯

eval "$(starship init zsh)"

# ╭──────────────────────────────────────────────────────────╮
# │ Aliases 						                                     │
# ╰──────────────────────────────────────────────────────────╯
  
alias code="codium"

# ╭──────────────────────────────────────────────────────────╮
# │ Exports 						                                     │ 
# ╰──────────────────────────────────────────────────────────╯

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Reading dotenv
if [ -f "$HOME/dotfiles/.env" ]; then
    while IFS= read -r line; do
        if [[ ! $line =~ ^# ]]; then
            export "$line"
        fi
    done < "$HOME/dotfiles/.env"
fi


# ╭──────────────────────────────────────────────────────────╮
# │ snippets 						                                     │
# ╰──────────────────────────────────────────────────────────╯

jira() {
  zen-browser "https://nuvidio.atlassian.net/browse/$1"
}
