# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/zeus/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="fino-time"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting command-not-found vscode sudo gcloud)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gac="git add .
git commit -m $1"

alias gc="git commit -m $1"
alias editzsh="code ~/.zshrc"
alias cls="clear"
# MAKE DOCKER STOP AND RM ALL

neofetch

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
source /Users/zeus/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/zeus/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/zeus/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/zeus/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/zeus/code/google-cloud-sdk/completion.zsh.inc'; fi

# USE UBUNTU IMAGES
export DOCKER_DEFAULT_PLATFORM=linux/amd64

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2024-08-12 11:24:42
export PATH="$PATH:/Users/zeus/.local/bin"


git() {
    if [[ "$1" == "clone" ]]; then
        local repo="$2"
        
        # Determine the base repository path based on the protocol
        local base_repo
        
        if [[ "$repo" == https://* ]]; then
            base_repo="${repo#https://github.com/}"
            base_repo="https://github.com/$base_repo"
            shift 2
            # Attempt to clone from github.com
            command git clone "$base_repo" $@ && return 0
            
            # If the first attempt fails, try github.com-personal
            echo "Failed to clone from github.com. Trying github.com-personal..."
            base_repo="https://github.com-personal/$base_repo"
            command git clone "$base_repo" $@ && return 0
            
        elif [[ "$repo" == git@* ]]; then
            base_repo="${repo#git@github.com/}"
            base_repo="git@github.com:${base_repo#*:}"
            # Attempt to clone from github.com
            shift 2
            command git clone "$base_repo" && return 0
            
            # If the first attempt fails, try github.com-personal
            echo "Failed to clone from github.com. Trying github.com-personal..."
            base_repo="git@github.com-personal:${base_repo#*:}"
            command git clone "$base_repo" $@ && return 0
            
        else
            echo "Unsupported repository URL format: $repo"
            return 1
        fi

        # If both fail, print an error message
        echo "Failed to clone repository from both github.com and github.com-personal."
        return 1
    elif [[ "$1" == "remote" && "$2" == "add"  ]]; then
        local repo="$4"
        
        # Determine the base repository path based on the protocol
        local base_repo
        
        if [[ "$repo" == https://* ]]; then
            base_repo="${repo#https://}"
            remote1="https://github.com/$base_repo"
            remote2="https://github.com-personal/$base_repo"
            
            # Attempt to add remote from github.com
            git ls-remote "$remote1" && command git remote add $3 "$remote1" && echo "Done" && return 0
            
            # If the first attempt fails, try github.com-personal
            echo "Failed to add $remote1 from github.com. Trying github.com-personal..."
            git ls-remote "$remote2" && command git remote add $3 "$remote2" && echo "Done" && return 0
            
        elif [[ "$repo" == git@* ]]; then
            base_repo="${repo#git@github}"
            remote1="git@github.com:${base_repo#*:}"
            remote2="git@github.com-personal:${base_repo#*:}"
            
            # Attempt to add remote from github.com
            git ls-remote "$remote1" && command git remote add $3 "$remote1" && echo "Done" && return 0
            
            # If the first attempt fails, try github.com-personal
            echo "Failed to add $remote1 from github.com. Trying github.com-personal..."
            git ls-remote "$remote2" && command git remote add $3 "$remote2" && echo "Done" && return 0
            
        else
            echo "Unsupported repository URL format: $repo"
            return 1
        fi

        # If both fail, print an error message
        echo "Failed to add remote $3 from both github.com and github.com-personal."
        return 1
    else
        # For all other git commands, use the original git command
        command git "$@"
    fi
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/zeus/.lmstudio/bin"
# scripts CLI (lms)
export PATH="$PATH:/Users/zeus/scripts"

# bun completions
[ -s "/Users/zeus/.bun/_bun" ] && source "/Users/zeus/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
