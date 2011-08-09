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

# Your Dropbox Public Folder. WITHOUT trailing slash.
PUBLIC_FOLDER="/Users/lgarron/Dropbox/Public"

# The folder where you want to store your playlists (must already exist, and be in the public folder). WITHOUT trailing slash.
MUSIC_FOLDER_NAME="Music"

# Your Dropbox ID. Can be found be looking at a public URL for any file in your shared folder.
DROPBOX_ID="13568303"

# A prefix that will be appended to the m3u file before publishing.
PLAYLIST_PREFIX="Playlist-"

######

echo ""

MUSIC_FOLDER="$PUBLIC_FOLDER/$MUSIC_FOLDER_NAME"
URL_PATH="http://dl.dropbox.com/u/$DROPBOX_ID/$MUSIC_FOLDER_NAME"

M3U_ORIGINAL_FILE="$1"
M3U_ORIGINAL_FULL_NAME=`basename "$M3U_ORIGINAL_FILE"`

M3U_NAME="${M3U_ORIGINAL_FULL_NAME%.*}"
M3U_FILE_NAME="$PLAYLIST_PREFIX$M3U_NAME.m3u"
M3U_FILE="$MUSIC_FOLDER/$M3U_FILE_NAME"
PLAYLIST_FOLDER_NAME="$PLAYLIST_PREFIX$M3U_NAME"
PLAYLIST_FOLDER="$MUSIC_FOLDER/$PLAYLIST_PREFIX$M3U_NAME"

M3U_FILE_URL="$URL_PATH/$M3U_FILE_NAME"
M3U_FILE_URL=`echo "$M3U_FILE_URL" | sed 's/\ /%20/g'`

if [ ! -d "$MUSIC_FOLDER" ]; then
  echo "Creating folder: $MUSIC_FOLDER"
  mkdir "$MUSIC_FOLDER"
fi

mkdir "$PLAYLIST_FOLDER"

touch "$M3U_FILE"
echo -n "" > "$M3U_FILE"

cat "$M3U_ORIGINAL_FILE" | tr '\r' '\n' |
while read SONG_FILE
do
if [[ "$SONG_FILE" == \#* ]]
then
    echo "$SONG_FILE" >> "$M3U_FILE"
else
    SONG_FILE_NAME=`basename "$SONG_FILE"`
    echo "[Song] $SONG_FILE_NAME..."
    ln -s "$SONG_FILE" "$PLAYLIST_FOLDER/$SONG_FILE_NAME"
    FILE_URL="$URL_PATH/$PLAYLIST_FOLDER_NAME/$SONG_FILE_NAME"
    FILE_URL=`echo "$FILE_URL" | sed 's/\ /%20/g'`
    echo "$FILE_URL" >> "$M3U_FILE"
fi
done

echo "$M3U_FILE_URL" | pbcopy
echo ""
echo "$M3U_FILE_URL (should be on your clipboard now)"
echo ""
# qs "$M3U_FILE"
