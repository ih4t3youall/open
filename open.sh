#/bin/bash

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"
flag=0

if [ $1 == "." ]; then
  nautilus .
  flag=1
fi


if [ $extension == "sh" ]; then
  chmod +x "$1"
  ./"$1"
  flag=1
fi

if [ $flag == 0 ]; then
	if [ $extension == "jpg" ] || [ $extension == "jpeg" ] || [$extension == "png"] || [$extension == "bmp"]; then
	  feh "$1"
	  flag=1
	fi
fi


if [ $flag == 0 ]; then
		input="/home/juan.martin.lequerica/.scripts/open/allVideoFilesLowercase.txt"
		while IFS= read -r line
			do
				if [ $extension == "$line" ];then
					vlc "$1"
	  				flag=1
				fi
		done < "$input"
fi


if [ $extension == "html" ]; then
  opera "$1"
  flag=1
fi

if [ $extension == "txt" ] || [ $extension == "java" ] || [ $extension == "feature" ]; then
  geany "$1"
  flag=1
fi

if [ $extension == "pdf" ]; then
  opera "$1"
  flag=1
fi

if [ $flag == 0 ] && [ $extension == "feature" ]; then
  vim "$1"
  flag=1
fi

grep -q "\x00" $1 && value="Binary" || value="Text"

if [ $flag == 0 ] && [ $value == "Text" ]; then
  vim "$1"
  flag=0
fi
