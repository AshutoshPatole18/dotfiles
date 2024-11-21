# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

source /home/ashu/.local/share/zinit/snippets/OMZP::docker/OMZP::docker

fpath=(~/.zsh/completions $fpath)

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

zicompinit

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Aliases
alias ls='lsd'
alias vim='nvim'
alias c='clear'
alias vi='nvim'
alias top='btop'
alias cat='bat'
alias du='gdu'
alias cp='cp -v'
alias rm='rm -v'
alias cats='/usr/bin/cat'
alias search="fzf --preview 'bat --color=always {}'"

# Temp aliases (project specifics)
alias start_om_server="docker compose -f ~/masters/docker/development/docker-compose-original.yml up --build -d openmetadata-server && docker logs -f openmetadata_server"
alias start_ingestion="docker compose -f ~/masters/docker/development/docker-compose-original.yml up --build -d ingestion"
alias stop_om_server="docker compose -f ~/masters/docker/development/docker-compose.yml down"
alias mvnbuild="cd ~/masters/ && mvn clean install -DskipTests"
alias mvnfrontend="cd ~/masters/ && mvn clean install -DskipTests -pl mastech-ui,mastech-dist && start_om_server"
alias mvnbackend="cd ~/masters/ && mvn clean install -DskipTests -pl mastech-spec,mastech-service,mastech-dist && start_om_server"
# alias drmi="sudo docker rmi \"$(docker images -f "dangling=true" -q)"
# alias drmi="sudo docker rmi \"\$(docker images -f \\\"dangling=true\\\" -q)\""
alias drmi='sudo docker rmi "$(docker images -f '\''dangling=true'\'' -q)"'
alias postman='cd ~/Downloads/Postman/ && ./Postman'



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:/root/.local/bin:/home/ashu/Downloads/platform-tools-latest-linux/platform-tools

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm




fpath+=($ZSH/plugins/docker)
autoload -U compinit && compinit


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Created by `pipx` on 2024-08-23 08:05:53
export PATH="$PATH:/home/ashu/.local/bin"



export DATABASE_URL="jdbc:postgresql://postgres:5432/gyms"
export DATABASE_USER=somethinguser
export DATABASE_PASSWORD=somethingpassword

# export DATABASE_URL="jdbc:postgresql://localhost:5432/gyms"
# export DATABASE_USER=gym
# export DATABASE_PASSWORD=gymowner

alias k="kubectl"
