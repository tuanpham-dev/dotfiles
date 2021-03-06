# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/tuanp/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

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
plugins=(git)

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

prompt_dir() {
    prompt_segment blue black '%2~'
}

prompt_context() { }

alias si='landscape-sysinfo'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

mcd() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

rr() {
    SEARCH=$1
    REPLACE=$2

    export SEARCH
    export REPLACE

    rename 's/$ENV{SEARCH}/$ENV{REPLACE}/' ${SEARCH}*
}

gitf() {
    GIT_ROOT=$(git rev-parse --show-toplevel) || return
    PRE_COMMIT="$GIT_ROOT/.git/hooks/pre-commit"

    if [ -s "$PRE_COMMIT" ] && [ "$(grep -s "LOCAL_DEV" "$PRE_COMMIT")" = "" ]; then
        mv "$PRE_COMMIT" "${PRE_COMMIT}-old"
    fi

    cp ~/.patches/pre-commit "$PRE_COMMIT"
}

alias gl='git log --oneline -10'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcod='git checkout develop'
alias gcom='git checkout master'
alias gs='git status'
alias gas='git add src/'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gu='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gr='git rebase'
alias gri='git rebase -i'
alias grd='git rebase develop'
alias grs='git reset'
alias grsh='git reset --hard'

alias react='yarn create react-app --template typescript'
alias yaa='yarn add'
alias yad='yarn add -D'

yat() {
    PACKAGES=''
    TYPES_PACKAGES=''

    for PACKAGE in $@; do
        PACKAGES="$PACKAGES $PACKAGE"
        TYPES_PACKAGES="$TYPES_PACKAGES @types/$PACKAGE"
    done

    yarn add `echo $PACKAGES`
    yarn add -D `echo $TYPES_PACKAGES`
}

penv() {
    TARGET="${@: -1}"

    if [ ! -z "$TARGET" ]; then
        mkdir "$TARGET"
        cd "$TARGET"
    fi

    python3 -m venv venv && source venv/bin/activate
}

[ -s ~/.zshrc-work ] && . ~/.zshrc-work
