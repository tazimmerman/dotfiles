# Bash
ulimit -c unlimited
ulimit -v unlimited
umask 002
shopt -s cdspell
[ $BASH_VERSINFO -gt "3" ] && shopt -s dirspell
shopt -s histappend

export ENV=$HOME/.bashrc
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export PAGER=/usr/bin/less
export EDITOR=vim
export SHELL=/bin/bash
export HISTFILE=~/.bash_history
export HISTSIZE=10240

# Home Brew
HOMEBREW_GITHUB_API_TOKEN=725c3643c675fec5c7f1d6ad8f34834bb13503df

# Mono / F#
MONO_GAC_PREFIX="/usr/local"

# Git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
source ~/.git-prompt.sh
source ~/.git-completion.bash
PROMPT_COMMAND='__git_ps1 "\w" "\n\\\$ "'
PROMPT_DIRTRIM=2

# FZF
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CONTROL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height=50% --layout=reverse --border --info=hidden'
source ~/.fzf-completion.bash
source ~/.fzf-key-bindings.bash

_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . $1
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . $1
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/troy/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/troy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/troy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/troy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
