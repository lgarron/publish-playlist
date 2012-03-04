#!/bin/bash
#
# Lucas Garron
# May 28, 2011
# Updated June 18, 2011
#
# ISSUES
# - Duplicate file names.
# - Overwriting previous versions
# - Full URL escaping.

######

#Configure:

# Your Dropbox Public Folder. WITH trailing slash.
PUBLIC_FOLDER="/Users/lgarron/Dropbox/Public/"

# The folder where you want to store your playlists (must already exist, and be in the public folder). WITHOUT trailing slash.
MUSIC_FOLDER="/Users/lgarron/Dropbox/Public/Music"

# Your Dropbox ID. Can be found be looking at a public URL for any file in your shared folder.
DROPBOX_ID="13568303"

# A prefix that will be appended to the m3u file before publishing.
PLAYLIST_PREFIX="Playlist-"

######

RELATIVE_FOLDER_NAME=`echo "$MUSIC_FOLDER" | sed "s@$PUBLIC_FOLDER@@"`
URL_PATH="http://dl.getdropbox.com/u/$DROPBOX_ID/$RELATIVE_FOLDER_NAME"

M3U_ORIGINAL_FILE="$1"
M3U_ORIGINAL_FULL_NAME=`basename "$M3U_ORIGINAL_FILE"`

M3U_NAME="${M3U_ORIGINAL_FULL_NAME%.*}"
M3U_FILE="$MUSIC_FOLDER/$PLAYLIST_PREFIX$M3U_NAME.m3u"
PLAYLIST_FOLDER_NAME="$PLAYLIST_PREFIX$M3U_NAME"
PLAYLIST_FOLDER="$MUSIC_FOLDER/$PLAYLIST_PREFIX$M3U_NAME"

M3U_FILE_URL="$URL_PATH/$M3U_FILE"
M3U_FILE_URL=`echo "$M3U_FILE_URL" | sed 's/\ /%20/g'`

mkdir "$MUSIC_FOLDER/$PLAYLIST_FOLDER_NAME"

touch "$M3U_FILE"
#echo -n "" > "$M3U_FILE"

cat "$M3U_ORIGINAL_FILE" | tr '\r' '\n' |
while read SONG_FILE
do
if [[ "$SONG_FILE" == \#* ]]
then
    echo "$SONG_FILE" >> "$M3U_FILE"
else
    SONG_FILE_NAME=`basename "$SONG_FILE"`
    ln -s "$SONG_FILE" "$PLAYLIST_FOLDER/$SONG_FILE_NAME"
    FILE_URL="$URL_PATH/$PLAYLIST_FOLDER_NAME/$SONG_FILE_NAME"
    FILE_URL=`echo "$FILE_URL" | sed 's/\ /%20/g'`
    echo "$FILE_URL" >> "$M3U_FILE"
fi
done

cp "$M3U_FILE" "$M3U_FILE.txt"

echo "$M3U_FILE_URL"
echo "$M3U_FILE_URL" | pbcopy
qs "$M3U_FILE"
