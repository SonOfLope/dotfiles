
alias ls='ls --color=always -CF'
alias l='ls'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ll -A'
alias lll='lla --color=always | less'
alias lld='du -sch'
alias llcap='df -h --total'
alias grep='grep --colour --devices=skip'
alias less='less -r'
alias rm='rm -v'
alias tree='tree -C'
alias feh='feh -F'

alias wk='cd $WK'
alias v='vim'
alias nv='nvim'
alias vv='gvim'
alias brvim='printf "\033[?5h"; vim; printf "\033[?5l"'
alias t='tmux'
alias nnn='nnn -cdEFrx'

alias myip='nc 4.ifcfg.me 23 | grep IPv4 | cut -d" " -f4'

# Git
alias g='git'

# Containers
alias d='docker'
alias dps='docker ps'
alias ds='docker start'
alias dst='docker stop'
alias dsta='docker stop $(docker ps -q)'
alias drac='docker rm -f `docker ps --no-trunc -aq`'
alias dc='docker-compose'
alias k='kubectl'

