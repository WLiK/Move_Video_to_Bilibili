#!/bin/bash

Date=`date '+%Y%m%d'`
Dir="video_file/file_"${Date}
echo $Dir

mkdir $Dir
cd $Dir

ind_date=`date -v -1d '+%Y%m%d'`

youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date https://www.youtube.com/c/cafemusicbgmchannel/playlists

ind_date3=`date -v -1d '+%Y%m%d'`
youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date3 https://www.youtube.com/channel/UCbsObMtz4YLeTC7cf10vZGQ/videos
