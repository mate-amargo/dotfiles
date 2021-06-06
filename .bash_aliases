#!/bin/bash
#===========#
#           #
#  Aliases  #
#           # 
#===========#

# ls 
alias ls='ls --color=auto'
alias ll='ls -l'
alias lh='ls -lh'
alias lah='ls -lAh'

# cd 
alias cdsrc='cd ~/prog/programas'
alias cdsh='cd ~/prog/scripts'
alias cddoc='cd ~/prog/docs'
alias cdd='cd ~/descargas'
alias cdw='cd ~/work'

# Utilities/Misc
alias camello="awk '{print toupper(substr(\$1,1,1)) substr(\$1,2)}'"
alias bounce='yes $COLUMNS $LINES|awk '"'BEGIN{x=y=e=f=1}{if(x=="'$1'"||!x){e*=-1};if(y=="'$2'"||!y){f*=-1};x+=e;y+=f;printf \"\033[%s;%sH\",y,x;system(\"sleep .03\")}'"

# Time and date 
alias h='date +%T'
alias d="echo \$(date +%A | camello) \$(date +%d) de \$(date +%B | camello) de \$(date +%Y)"

# Web browser
#BROWSER="links"
BROWSER="links2 -driver fb"
alias google="$BROWSER http://www.google.com.ar"
alias googlel="$BROWSER http://www.gooogle.com/linux"
