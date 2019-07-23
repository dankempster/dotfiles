# aliases to make it easy to show/hide hidden files in macOS
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# set up Git bash completion and custom git-PS1, if available
if [ -f /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash ]; then
    source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash

    #source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
    #GIT_PS1_SHOWDIRTYSTATE=true
    #export PS1='\u@\h:\w$(__git_ps1)$ '
    # export PS1='\h:\W$(__git_ps1)$ '
fi

# Bash completion for Homebrew packages
whichBrew=$(which brew)
if [ $? -eq 0 ]; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
	    . $(brew --prefix)/etc/bash_completion
	fi
fi

# Find or list ports being listened to
#
# USAGE
#
# List all ports
#   $ listening
#
# What's listening on port 8080?
#   $ listening 8080
#
# What ports is DropBox using?
#   $ listening dropbox
#
listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

