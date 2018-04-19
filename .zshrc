source /etc/profile.d/apps-bin-path.sh
source /etc/profile.d/jdk.sh

export PATH=$PATH:$HOME/bin:$HOME/.local/bin
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=false"
export PYTHONWARNINGS="ignore:A true SSLContext object is not available"
export EDITOR=nano
export EDITOR=micro
export GOPATH=$HOME/.gocode

# alias cm=checkoutmanager

source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle pip
antigen bundle dirpersist
antigen bundle command-not-found
antigen bundle celery
antigen bundle colorize
antigen bundle django
antigen bundle docker
antigen bundle python
antigen bundle supervisor
antigen bundle git
antigen bundle --loc=lib termsupport
antigen bundle --loc=lib key-bindings
antigen bundle rimraf/k
antigen apply

local user_color='green'; [ $UID -eq 0 ] && user_color='red'

typeset -F SECONDS
function timer_preexec() {
    timer=${timer:-$SECONDS}
}
function timer_precmd() {
    if [ $timer ]; then
        printf "\a"
        timer_show=$(printf "%.2f" $(($SECONDS - $timer)))s
        RPROMPT="%B%F{cyan}${timer_show} %b%F{red}=> %B%F{red}%?%b %B%F{black}%D{%H:%M}%b"
        unset timer
    else
        RPROMPT="%B%F{black}%D{%H:%M}%b"
    fi
}
precmd_functions+=(timer_precmd)
preexec_functions+=(timer_preexec)
RPROMPT="%B%F{black}%D{%H:%M}%b"

setopt noautomenu
setopt noautocd
setopt extended_glob
#setopt -o correctall

#bindkey "^[OC" forward-word
#bindkey "^[OD" backward-word
#bindkey "^[[C" forward-char
#bindkey "^[[D" backward-char
#
bindkey "^[^[OC" kill-word
bindkey "^[^[OD" backward-kill-word
bindkey "^[[C" forward-word
bindkey "^[[D" backward-word
# bindkey "^[[1~" beginning-of-line
# bindkey "^[[4~" end-of-line
#

setopt nosharehistory

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats " %b%m%c%u"
zstyle ':vcs_info:*' actionformats " %b%f:%F{red}%a%m%c%u"
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}#%f'
zstyle ':vcs_info:git+set-message:*' hooks check-untracked check-upstream

+vi-check-untracked() {
    [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && hook_com[unstaged]="${hook_com[unstaged]}%b?"
    return 0
}
+vi-check-upstream() {
    local a b
    if git rev-parse '@{u}' &>/dev/null; then
        git rev-list --count --left-right 'HEAD...@{u}' | read a b
        (( $a > 0 )) && hook_com[unstaged]="${hook_com[unstaged]} %b%B↑$a"
        (( $b > 0 )) && hook_com[unstaged]="${hook_com[unstaged]} %b%B↓$b"
    fi
}

precmd_functions+=(vcs_info)
setopt prompt_subst
PROMPT='%B%F{$user_color}%n%b:%B%F{blue}%m%b %F{$user_color}%~%F{magenta}${vcs_info_msg_0_}%b> '

# added by travis gem
[ -f /home/ionel/.travis/travis.sh ] && source /home/ionel/.travis/travis.sh

export FZF_DEFAULT_OPTS='--exact'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
