#
# .bash_profile
#
# @author Dan Kempster
#

if [ -d "/usr/local/opt/qt" ]; then
    export LDFLAGS="-L/usr/local/opt/qt/lib"
    export CPPFLAGS="-I/usr/local/opt/qt/include"
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

export HISTCONTROL=erasedups

#
### OS Specific settings

sysType=$(uname)

# macOS Specific
if [ "${sysType}" == 'Darwin' ]; then
	source "${HOME}/dotfiles/osx.bash_profile"
# Linux specific
else
	source "${HOME}/dotfiles/linux.bash_profile"
fi


#
### Alias

#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
if [ "${sysType}" == 'Darwin' ]; then
	# -H : "Human-readable" output
	# -l : Only display information about locally-mounted filesystems.
	alias df='sudo df -Hl'
else
	# -h : "Human-readable" output
	alias df='sudo df -h'
fi
alias du='sudo du -h'


# find usage : calculates disk space usage for every folder in the current directory
alias fu='sudo du -hsc *'

# Misc :)
# alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour

# Some shortcuts for different directory listings
if [ "${sysType}" == 'Darwin' ]; then
	# G : Enable colorized output
	# p : Write a slash (`/') after each filename if that file is a directory
	alias ls='ls -Gp'

	# C : Force multi-column output
	alias l='ls -GpC'
	
	# -l : List in long format.
	# -h : use unit suffixes: Byte, Kilobyte, Megabyte, Gigabyte
    # -o : List in long format, but omit the group id
	alias ll='ls -Gplho'                              

	# A : List all entries except for . and ..
	alias la='ls -GplhoA'                     
else
	alias ls='ls -h --file-type --color=auto'                 # classify files in colour
	alias ll='ls -lh --color=auto'                              # long list
	alias la='ls -lAh --color=auto'                              # all but . and ..
	alias l='ls -C --file-type'
fi
#alias g='git'

#alias d=docker
#alias dc=docker-compose
alias dm=docker-machine
alias g=git




### Convience functions

# Alias of # history | grep cmd
# Also removes all entries of calls to the function
function hist() {
    history | grep $* | grep -v -P "[ 0-9]+hist +"
}

#
# Creates 'd' as alias of docker
#
# If not arguments are passed, the funciton defaults to the 'ps' command.
#
function d () {
  if [ "$#" == "0" ]; then
    docker ps
  else 
    docker $* 
  fi
}

#
# Creates 'dc' as alias of docker-composer
#
# If no arguments are passed, the funciton defaults to the 'ps'; assuminh
# docker-compose.yml exists in the user's working directory.
#
function dc () {
  if [ "$#" == "0" ]; then
    if [ -f docker-composer.yml ]; then
      docker-compose ps
    else
      docker-compose
    fi
  else
    docker-compose $*
  fi
}

#
# Enter a running Docker container.
# 
function denter() {
  if [[ ! "$1" ]] ; then
      echo "You must supply a container ID or name."
      return 0
  fi

  docker exec -it $1 bash
  return 0
}