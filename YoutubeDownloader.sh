#!/bin/bash

read -p "Do you have youtube-dl?[Y/N]" yn
case $yn in

	[Nn]* )	sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
		sudo pip install --upgrade youtube-dl
		sudo chmod a+rx /usr/local/bin/youtube-dl
		;;

	[Yy]* ) ;;
esac

read -p "Input URL of the playlist: " URL
python3 youParse.py "$URL" > MyPlaylist.txt
echo "Playlist URL file created succesfully"

read -p "Input path of destination folder(Please use [$HOME] insted of ~): " path

mkdir -p $path
cp MyPlaylist.txt $path\/MyPlaylist.txt
cd $path

while read -r LINE || [[ -n $LINE ]]; 
do	
	youtube-dl $LINE
done < MyPlaylist.txt

echo "Succesfully Downloaded all Videos to $path"
