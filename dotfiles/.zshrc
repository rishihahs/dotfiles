#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# vim using
mvim --version > /dev/null 2>&1
MACVIM_INSTALLED=$?
if [ $MACVIM_INSTALLED -eq 0 ]; then
  alias vim="mvim -v"
fi
alias vim=nvim

# Git Aliases
alias gs='git status'

# Finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Grep color
export GREP_COLOR='1;33'

# Load custom prompts for ZSH
autoload promptinit
fpath=($HOME/.zsh-themes $fpath)
promptinit

# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

bindkey -v                                          # Use vi key bindings
bindkey '^r' history-incremental-search-backward    # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

# emacs style
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Don't try to glob with zsh so you can do
# stuff like ga *foo* and correctly have
# git add the right stuff
alias git='noglob git'

# Override rm -i alias which makes rm prompt for every action
alias rm='nocorrect rm'

# Setup prompt to use
prompt powerline

# Use Ctrl-Space to accept autosuggest
bindkey '^ ' autosuggest-accept

if [ -n "$INSIDE_EMACS" ]; then
  prompt sorin
fi

########################### Normal Customizations ##############################

# Set EDITOR and VISUAL
export EDITOR=nvim
export VISUAL=nvim

# Zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Add homebrew to the completion path
fpath=("/usr/local/bin/" $fpath)

# Place /usr/local/bin first so that Homebrew precedes Apple
export PATH=/usr/local/bin:$PATH

# rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
# export PYENV_ROOT=/usr/local/opt/pyenv
# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Android
export PATH=$PATH:/Users/rishi/code/android/adt-bundle/sdk/platform-tools
export PATH=$PATH:/Users/rishi/code/android/adt-bundle/sdk/tools

# Postegres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin

# Apportable
export PATH="/Users/rishi/.apportable/SDK/bin:$PATH"

# Sublime Text
export PATH="$PATH:/Applications/Sublime Text.app/Contents/SharedSupport/bin"

# Set open file limit for Duply (Duplicity)
ulimit -n 1024

# Replace Apple OpenSSH with Homebrew OpenSSH
eval $(ssh-agent)

function cleanup {
  echo "Killing SSH-Agent"
  kill -9 $SSH_AGENT_PID
}

trap cleanup EXIT

# GPGTools gpg-agent
AGENT_PID=$(ps axc | awk "{if (\$5==\"gpg-agent\") print \$1}")
export GPG_AGENT_INFO="$HOME/.gnupg/S.gpg-agent:$AGENT_PID:1"
export GPG_TTY=$(tty)

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT
 
# use magic (this is default, but it can't hurt!)
setopt ZLE

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

# Tmuxinator Completion
# source ~/.bin/tmuxinator.zsh

# Gihub
alias git=hub

# Emacs Multi-Term
if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

# Hadoop
alias hstart="/usr/local/Cellar/hadoop/2.7.0/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/2.7.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/2.7.0/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/2.7.0/sbin/stop-dfs.sh"

# Python Anaconda
export PATH="$HOME/anaconda/bin:$PATH"
export DYLD_FALLBACK_LIBRARY_PATH="$HOME/anaconda/lib"

# Matlab
export PATH="$PATH:/Applications/MATLAB_R2014b.app/bin"

# Golang
export GOPATH="$HOME/code/go"
export PATH="$PATH:$GOPATH/bin"
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Spark tools
export PATH="$PATH:$HOME/code/spark/tools"

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"
