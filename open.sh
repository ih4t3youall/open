#!/bin/bash
#open2

filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

vim=0
vlc=0

office=("odt" "docx" "doc" "ods" "cvs")
text=("txt" "java" "feature" )
images=("jpg" "jpeg" "png" "bmp")
video=("3gp" "asf" "avi" "flv" "mkv" "midi" "mp4" "ogg" "ogm" "wav" "mpeg" -2"ps" "ts" "pva" "mp3" "aiff" "mxf" "vob" "rm" "vcd" "svcd" "dvb" "heif" "avif" "aac" "ac3" "alac" "amr" "dts" "xm" "flac" "it" "mp3" "qcp" "qdm2" "tta" "wma" "dvb" "dvb" "dvb" "dvb" "atsc" "mpeg" "rtp" "rtsp" "3gpp" "pss" "mpeg" "mpl2" "ogm" "dv" "mpeg" "avc" "h" "mpeg" "hevc" "av1" "huffyuv" "mjpeg" "mpeg" "mpeg" "mpeg" "vc" "vp5" "vp6" "vp8" "vp9" "dnxhd" "wmv" "mov" "MOV")

if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    return
fi

if [[ -d $1 ]]; then
    echo "$1 is a directory"
    nautilus "$1"
    return
fi

if [ "$1" == '.' ]; then
  nautilus .
  return
fi


if [ "$extension" == "sh" ]; then
  chmod +x "$1"
  ./"$1"
  return
fi

if [ "$extension" == "py" ]; then
 python3 "$1" 
 return
fi

if [ "$extension" == "pdf" ]; then
    gio open "$1"
    return
fi

if [ "$extension"  == "py" ]; then
  python3 "$1"
  return
fi

for i in "${office[@]}"; 
do 
  if [ "$extension" == "$i" ]; then
    libreoffice "$1"
  fi
done


for i in "${text[@]}"; 
do 
  if [ "$extension" == "$i" ]; then
    featherpad "$1"
  fi
done

for i in "${images[@]}"; 
do 
  if [ "$extension" == "$i" ]; then
    feh "$1"
  fi
done

for i in "${video[@]}"; 
do 
  if [ "$extension" == "$i" ]; then
    vlc "$1"
  fi
done

grep -q "\x00" $1 && value="Binary" || value="Text"

if [ "$flag" == 0 ] && [ "$value" == "Text" ]; then
  vim "$1"
  flag=0
  return
fi

return
