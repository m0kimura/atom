#!/bin/bash
#
  project=${PWD##*/}
##
  if [[ $1 = "build" ]] || [[ $1 = "make" ]]; then
    if [[ $2 = "$null" ]]; then
      echo "*ERROR Specify github | bitbacket "; exit 1
    fi
    docker rm -f fx-$2
    if [[ $1 = "build" ]]; then
      docker build -t ${project} --build-arg user=$USER .
    fi
    xhost local:
    docker run -d --name fx-$2 --label type=local \
      -e DISPLAY=${DISPLAY} \
      -e XMODIFIERS=$XMODIFIERS \
      -e XIM=fcitx \
      -e GTK_IM_MODULE=$GTK_IM_MODULE \
      -e QT_IM_MODULE=$QT_IM_MODULE \
      -e LC_TYPE=ja_JP.UTF-8 \
      -e LANG=ja_JP.UTF-8 \
      -e TERM=xterm \
      -v /home/$USER \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v /dev/shm:/dev/shm \
      -v $HOME/$2:/source \
      ${project}
  else
    if [[ $1 = "$null" ]]; then
      echo "*ERROR Specify build | github | bitbaucket "; exit 1
    fi
    docker start fx-$1
  fi
  echo "# EXIT"
##

