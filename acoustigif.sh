#!/bin/bash

if [ ! $# == 2 ] || [ ! -f $1 ] || [ ! -f $2 ] || [ ! $1 =~ \.gif$  ] || [ ! $2 =~ \.txt$  ]; then
    echo ""
    echo "Usage: $0 <input.gif> <input.mp3>"
    exit -1
fi

input_gif="$1"
input_mp3="$2"

ffmpeg -i "$input_gif" -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" short.mp4

input_mp3_len=$(ffprobe -show_entries stream=duration -of compact=p=0:nk=1 -v fatal "$input_mp3")
short_mp4_len=$(ffprobe -i short.mp4 -show_entries format=duration -v quiet -of csv="p=0")
loops=$(bc <<<"scale=0;$input_mp3_len / $short_mp4_len + 1")

> loops.txt
for i in `seq $loops`
do 
    echo -e "file short.mp4\n" >> loops.txt
done

ffmpeg -f concat -i loops.txt -c copy long.mp4

chmod +rw output.mp4
ffmpeg -i long.mp4 -i "$input_mp3" -c:v copy -c:a aac -strict -2 output.mp4

rm short.mp4
rm long.mp4
rm loops.txt

echo "Finished! Look for output.mp4 in the current directory."

exit 0
