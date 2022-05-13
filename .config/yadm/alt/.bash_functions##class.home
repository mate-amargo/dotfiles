#!/bin/bash
#=============#
#             #
#  Functions  #
#             #
#=============#

# Human hour
hh () {

echo -n "Son la"

if (( $(date +%M) <= 30 )); then
  if (( $(date +%H) == 0 || $(date +%H) == 12 )); then
    echo -n "s doce"
  elif (( $(date +%H) == 1 || $(date +%H) == 13 )); then
    echo -n " una"
  elif (( $(date +%H) == 2 || $(date +%H) == 14 )); then
    echo -n "s dos"
  elif (( $(date +%H) == 3 || $(date +%H) == 15 )); then
    echo -n "s tres"
  elif (( $(date +%H) == 4 || $(date +%H) == 16 )); then
    echo -n "s cuatro"
  elif (( $(date +%H) == 5 || $(date +%H) == 17 )); then
    echo -n "s cinco"
  elif (( $(date +%H) == 6 || $(date +%H) == 18 )); then
    echo -n "s seis"
  elif (( $(date +%H) == 7 || $(date +%H) == 19 )); then
    echo -n "s siete"
  elif (( $(date +%H) == 8 || $(date +%H) == 20 )); then
    echo -n "s ocho"
  elif (( $(date +%H) == 9 || $(date +%H) == 21 )); then
    echo -n "s nueve"
  elif (( $(date +%H) == 10 || $(date +%H) == 22 )); then
    echo -n "s diez"
  elif (( $(date +%H) == 11 || $(date +%H) == 23 )); then
    echo -n "s once"
  fi
else
  if (( $(date +%H) == 0 || $(date +%H) == 12 )); then
    echo -n " una"
  elif (( $(date +%H) == 1 || $(date +%H) == 13 )); then
    echo -n "s dos"
  elif (( $(date +%H) == 2 || $(date +%H) == 14 )); then
    echo -n "s tres"
  elif (( $(date +%H) == 3 || $(date +%H) == 15 )); then
    echo -n "s cuatro"
  elif (( $(date +%H) == 4 || $(date +%H) == 16 )); then
    echo -n "s cinco"
  elif (( $(date +%H) == 5 || $(date +%H) == 17 )); then
    echo -n "s seis"
  elif (( $(date +%H) == 6 || $(date +%H) == 18 )); then
    echo -n "s siete"
  elif (( $(date +%H) == 7 || $(date +%H) == 19 )); then
    echo -n "s ocho"
  elif (( $(date +%H) == 8 || $(date +%H) == 20 )); then
    echo -n "s nueve"
  elif (( $(date +%H) == 9 || $(date +%H) == 21 )); then
    echo -n "s diez"
  elif (( $(date +%H) == 10 || $(date +%H) == 22 )); then
    echo -n "s once"
  elif (( $(date +%H) == 11 || $(date +%H) == 23 )); then
    echo -n "s doce"
  fi
fi

if (( $(date +%M) <= 2 )); then
  echo " en punto"
elif (( $(date +%M) <= 7 )); then
  echo " y cinco"
elif (( $(date +%M) <= 12 )); then
  echo " y diez"
elif (( $(date +%M) <= 17 )); then
  echo " y cuarto"
elif (( $(date +%M) <= 22 )); then
  echo " y veinte"
elif (( $(date +%M) <= 27 )); then
  echo " y veinticinco"
elif (( $(date +%M) <= 32 )); then
  echo " y media"
elif (( $(date +%M) <= 37 )); then
  echo " menos veinticinco"
elif (( $(date +%M) <= 42 )); then
  echo " menos veinte"
elif (( $(date +%M) <= 47 )); then
  echo " menos cuarto"
elif (( $(date +%M) <= 52 )); then
  echo " menos diez"
elif (( $(date +%M) <= 57 )); then
  echo " menos cinco"
fi

}

# Create directory and change to it
mkdircd () {

mkdir -p "$@" && eval cd "\"\$$#\"";

}

# Set a color depending on the value of i
colorplus() {

if (( i < 7 )); then
  echo -en "\e[0;3"$(($i+1))"m"
else
  echo -en "\e[0;3"$(($i-7))"m"
fi

}

# Coloured pushd
cpushd() {

local i=0
pushd "$@">/dev/null;
for i in $( seq 0 $(( $(dirs -v | wc -l) -1 )) ); do
  colorplus
  echo -n "$(dirs +$i) "
done
echo

}

# Coloured popd
cpopd() {

local i=0
popd "$@">/dev/null;
for i in $( seq 0 $(( $(dirs -v | wc -l) -1 )) ); do
  colorplus
  echo -n "$(dirs +$i) "
done
echo

}

# Change to the i-est upper directory
ud() {

  local N=$(echo $PWD | sed 's/\//\n/g' | wc -l)
  local ECHO i

  case $1 in
    -n | --not) ECHO=yes; shift;;
  esac

  if [ -z $1 ]; then i=1; else i=$1; fi

  DIR=$(echo $PWD | cut -d/ -f-$(( $N - $i )) 2>/dev/null )
  : ${DIR:=/}

  if [ "$ECHO" == "yes" ]; then echo $DIR; else builtin cd $DIR; fi

}

rot13 () {

  tr A-Za-z N-ZA-Mn-za-m <<< "$*"

}

rot47 () {

  tr \'\!-~\' \'P-~\!-O\' <<< "$*"

}

man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;83m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;128m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

dice() {

  local d l

  if (( $# == 0 )); then
    d=1
  else
    d=$1
  fi
  if (( $# < 2 )); then
    l=6
  else
    l=$2
  fi

  for i in $(seq 1 $d); do
    echo -n "$(seq 1 $l | shuf | head -1) "
  done
  echo

}
