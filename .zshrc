# zgen stuff
source "$HOME/.zgen/zgen.zsh"

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load robbyrussell/oh-my-zsh plugins/colored-man
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load nojhan/liquidprompt
    zgen load chrissicool/zsh-256color
    zgen load zsh-users/zsh-completions src

    zgen save
fi


# General configuration
autoload -U compinit && compinit
autoload -U promptinit && promptinit

setopt autocd               # cd without writing cd
setopt extended_glob        # extended glob syntax
setopt nomatch              # print error if pattern matches nothing
setopt notify               # report status of background jobs immediately
setopt nohashdirs           # disable hashing of dirs so we don't have to run
                            # rehash after installing new binaries (performance hit?)


# Key stuff
bindkey -e
bindkey ';3D' emacs-backward-word
bindkey ';3C' emacs-forward-word
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char


# History
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=$HISTSIZE
setopt inc_append_history   # write to history immediately
setopt hist_ignore_dups     # ignore second instance of same event
setopt share_history        # share history between session
setopt extended_history     # special history format with timestamp
setopt no_hist_beep         # fucking beep
setopt hist_ignore_space    # ignore entries with leading space


# Completion

setopt complete_in_word     # complete from both ends of a word
setopt always_to_end        # move cursor to the end of a completed word
setopt path_dirs            # perform path search even on command names with slashes
setopt auto_menu            # show completion menu on a succesive tab press
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_param_slash     # if completed parameter is a directory, add a trailing slash
unsetopt menu_complete      # do not autoselect the first completion entry
unsetopt flow_control       # disable start/stop characters in shell editor

## Group matches and describe.
# zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

## Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

## Directories
eval $(dircolors <(awk '/^TERM/ && !x {print "TERM xterm-termite"; x=1} 1' <(dircolors -p)))
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

## History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes


# Correction

setopt correct              # spelling correction for commands
#setopt correctall           # spelling correction for arguments


# Misc aliases
alias ls='ls -F --color=auto'
alias ll='ls -lhF --color=auto'
alias la='ls -lhaF --color=auto'
alias grep='grep --color=auto'
alias sys='sudo systemctl'

alias svim='sudo vim'
alias spacman='sudo pacman'

alias mkchr='sudo extra-i686-build && sudo multilib-build'
alias mkchr32='sudo extra-i686-build'
alias mkchr64='sudo multilib-build'

alias db-move-packages='ssh nymeria.archlinux.org /packages/db-move'
alias db-move-community='ssh nymeria.archlinux.org /community/db-move'
alias db-update-packages='ssh nymeria.archlinux.org /packages/db-update'
alias db-update-community='ssh nymeria.archlinux.org /community/db-update'

alias pyserve='python -m http.server'
alias irc='ssh -C oracle -t "tmux attach"'
alias steam-win='bash -c "cd .wine/drive_c/Program\ Files/Steam/ && wine steam.exe -no-dwrite"'


# fasd
eval "$(fasd --init auto)"
alias j='fasd_cd -d'

# MPI aliases
alias cdosrc='cd ~/Coding/MPI/cdo/src'
alias cdomain='cd ~/Coding/MPI/cdo'
alias cdoclangpp='./configure CC="clang" CXX="clang++ -std=c++11" CFLAGS=" -g -Wall -ldl -Wfloat-equal -pedantic -O3" --enable-cxx --with-netcdf --with-netcdf4 --with-grib-api --disable-cf-interface --with-libxml2'
alias cdogpp='alias cdogpp && ./configure CC="gcc" CXX="g++" CFLAGS="-std=c++11 -g -Wall -Wfloat-equal -pedantic -O3" LDFLAGS=-ldl'
#--with-netcdf --with-hdf5=no --with-grib-api --disable-cf-interface --with-libxml2 '
alias reloadzsh='alias reloadzsh && . ~/.zshrc'
alias cx='xclip'
alias vx='xclip -o'
alias sp='pwd | cx'
alias pp='cd `vx`'
function cd(){
    builtin cd $1 
    pwd > ~/.last_pwd
}
alias cdo_mpi_main='cd /scratch/local1/m300433/cdo'
alias cdo_mpisrc='cd /scratch/local1/m300433/cdo/src'

alias cdoicc='./configure CC=icpc CXX='icpc' CPP='icpc' CPPFLAGS='-std=c++11' CXXFLAGS='-std=c++11' CFLAGS='-Wl,--export-dynamic -ldl -g -Wall -Wfl -float-equal  -pedantic -O3' --enable-cxx --with-netcdf=/sw/jessie-x64/netcdf-4.3.3.1-gccsys --with-gr ib-api=/sw/jessie-x64/grib_api-1.14.3-gccsys --with-libxml2L '
# Command to use the last known pwd as start folder for zsh
cd "$(cat ~/.last_pwd)"
