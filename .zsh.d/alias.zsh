#############
#  ALIASES  #
#############

# direcrtories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../.././...'

# program shortcuts
alias music='ncmpcpp'
alias clock='ncmpcpp -s clock'
alias visualizer='ncmpcpp -s visualizer'
alias email='thunderbird'
alias files='ranger'
alias chat='weechat'
alias audio='ncpamixer'

# system maintainence
alias progs='(pacman -Qet && pacman -Qm) | sort -u' # List programs I've installed
alias orphans='pacman -Qdt' # List orphan programs
alias sdn='sudo shutdown now'
alias nf='clear && neofetch'
alias UU='pacaur -Syyu && rm /tmp/off.updates && rm /tmp/aur.updates'
alias Cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias Optimize='sudo pacman-optimize'
alias Reflector='sudo reflector -c "United States" -f 12 -l 12 --verbose --save /etc/pacman.d/mirrorlist'
alias PI='pacaur -S --noconfirm'
alias pac='sudo pacman -S'
alias pac-r='sudo pacman -R'

# Some aliases
alias SS='sudo systemctl'
alias v='vim'
alias sv='sudo vim'
alias r='ranger'
alias sr='sudo ranger'
alias ka='killall'
alias g='git'
alias gitup='git push origin master'
alias mkd='mkdir -pv'
alias :q='exit'

# Fonts
alias Fonts='fc-cache -vf ~/.fonts'
alias font-check='echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"'


