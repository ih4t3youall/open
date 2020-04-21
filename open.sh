#!/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"
flag=0

if [ $extension = "sh" ]; then
  chmod +x "$1"
  ./"$1"
  flag=1
fi

if [ $flag == 0 ]; then
	if [ $extension = "jpg" ] || [ $extension = "jpeg" ] || [$extension = "png"]; then
	  feh "$1"
	  flag=1
	fi
fi


if [ $extension = "html" ]; then
  opera "$1"
  flag=1
fi

if [ $extension = "txt" ]; then
  geany "$1"
  flag=1
fi

if [ $extension = "pdf" ]; then
  opera "$1"
  flag=1
fi

if [ $extension = "feature" ]; then
  vim "$1"
  flag=1
fi

if [ $flag == 0 ]; then
  vim "$1"
  flag=0
fi
