if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

HISTSIZE=5000

# aliases
alias ls="ls -pG"
alias l="ls -al"
alias cd..="cd .."
alias ip="ifconfig | grep inet\ "
# the "kp" alias ("que pasa"), in honor of tony p.
alias kp="ps auxwww"
# start the screensaver
alias ss="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background &"

# exports
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:$PATH"
export PAGER="vimpager"
export NODE_PATH="/usr/local/lib/jsctags/:/usr/local/lib/node"
export MAVEN_OPTS="-Xmx512m"
