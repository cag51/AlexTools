#Fix vi
vi() {

    local args=("$@")
    local new=0

    # Check for `--new'.
    for ((i = 0; i < ${#args[@]}; ++i)); do
        if [[ ${args[$i]} = --new ]]; then
            new=1
            unset args[$i]   # Don't pass `--new' to vim.
        elif [[ ${args[$i]} = \-n ]]; then
            new=1
            unset args[$i]   # Don't pass `--new' to vim.
        fi
    done

    if ! (( new )); then
        for file in "${args[@]}"; do
            [[ $file = -* ]] && continue   

            if ! [[ -e $file ]]; then
                printf '%s: cannot access %s: No such file or directory\n' "$FUNCNAME" "$file" >&2
                return 1
            fi
        done
    fi

    if [[ -d ${!#} ]]; then
        cd "$@"
    else 
        command "$FUNCNAME" "${args[@]}"
    fi
}

#Fix spelling errors for cd
shopt -s cdspell

#Make history more useful
export PROMPT_COMMAND="history -a"
export HISTSIZE=30000
export HISTFILESIZE=30000
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups

#Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../..'

#More aliases
alias preview='open /Applications/Preview.app'
alias inkscape='/Applications/Inkscape.app/Contents/Resources/bin/inkscape'
alias teamviewer='open /Applications/TeamViewer.app'
alias tv='open /Applications/TeamViewer.app'
alias gedit='open /opt/homebrew-cask/Caskroom/gedit/3.2.6-3/gedit.app'
alias iv='vi'
alias amazon='ssh -i ~/Code/STARTER/webapp/starter.pem ec2-user@54.235.227.179'
alias umimmi='cd ~/Google\ Drive/BostonCommon/Projects/5033-001\ UMIMMI'
alias uc2='cd ~/Google\ Drive/BostonCommon/Projects/5030-001\ \(UC\)2\ PhII'
alias starter='cd ~/Google\ Drive/BostonCommon/Projects/5024-001\ STARTER\ PhII'
alias bds="XAUTHORITY=/storage/xauth/sauron/.Xauthority ssh -Y sauron@192.168.2.225"
alias akb="ssh -Y george@192.168.2.251"
alias whosudo='getent group sudo | cut -d: -f4'
alias hn='hostname'
alias ls='ls -G'

#Fix R
r1(){
  if [ "$#" == "0" ]; then command r --no-save; else command Rscript $@ ; fi
}

#Path
PATH=$PATH:/Users/alexgeorge/CODE/scripts/
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/include/python2.7/
#export PYTHONPATH=/Library/Python/2.7/site-packages:/Users/alexgeorge/.local/lib/python2.7/site-packages/:~/Code/AlexTools
export PYTHONSTARTUP=~/.pystartup
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig:$PKG_CONFIG_PATH

#Show full path
PS1='\w\$ '

#Color scheme
#export CLICOLOR=TRUE
export LSCOLORS="dxfxhxhxgx"

#Set up SQL
export PATH=$PATH:/usr/local/mysql/bin/
#alias mysql='mysql -u root -p' 

#Set up freaking eclipse
export PATH=$PATH:/Users/alexgeorge/eclipse/java-neon/Eclipse.app/Contents/MacOS/

#ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_bf

#Git stuff
git config --global user.name "Alex George"
git config --global user.email "alex.george@bostonfusion.com"

#Run function
r(){
  if [ "$#" == "0" ]
  then command r --no-save -q 
  else 
    ext="${1##*.}"
    if [ "$ext" == "R" ] ; then r1     $@ ; fi
    if [ "$ext" == "py" ] 
    then 
      firstLine=`more $1 | head -1 | tr '/' ' ' | awk '{print $NF}'`
      if [ "$firstLine" == "python3" ]
      then
        python3 $@ 
      else
        python $@
      fi
    fi
  fi
}

cppag(){
  g++ $@
  ./a.out
}

latex(){
  a=`pdflatex -halt-on-error $1` 
  nameAG=`echo $a | awk '{print $(NF-8)}' | tr '.' ' ' | awk '{print $1}'`
  typeAG=`echo $a | awk '{print $(NF-8)}' | tr '.' ' ' | awk '{print $2}'`
  if [ "$typeAG" == "pdf" ]
  then
    echo "Success!"
  elif [ "$typeAG" == "dvi" ]
  then
    dvipdf $nameAG.dvi $nameAG.pdf
    echo "Success!"
  else
    echo $a | awk '{ s = ""; for (i = NF-40; i <= NF; i++) s = s $i " "; print s }'
  fi
}

#For sparql
export JENA_HOME=/Users/alexgeorge/Code/STARTER/entityTest/apache-jena-3.1.0
alias sparql="$JENA_HOME/bin/sparql"

#docker
alias deleteAllDocker='docker rm $(docker ps -a -q -f status=exited)'

alias bds="XAUTHORITY=/storage/xauth/sauron/.Xauthority ssh -Y sauron@barad-dur.local"

export PATH="/usr/local/opt/curl/bin:$PATH"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/4.2.1/

alias whosudo='getent group sudo | cut -d: -f4'
