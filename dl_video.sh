#!/bin/bash

Date=`date '+%Y%m%d'`
Dir="video_file/file_"${Date}
echo $Dir

mkdir $Dir
cd $Dir

ind_date=`date -v -2d '+%Y%m%d'`

youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date  https://www.youtube.com/c/TheIELTSListeningTest/videos

ind_date1=`date -v -7d '+%Y%m%d'`

youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date1  https://www.youtube.com/c/TOEFLsuccess/videos

ind_date2=`date -v -10d '+%Y%m%d'`
youtube-dl --proxy http://127.0.0.1:1087 --playlist-end 5 --write-thumbnail --write-info  --dateafter $ind_date2 https://www.youtube.com/channel/UCvqL6TeKZ2s9j2xIe8GWx1w/videos
