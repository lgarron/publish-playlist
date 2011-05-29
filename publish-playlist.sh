#!/bin/bash
#
# Lucas Garron
# May 28, 2011
#
# ISSUES
# - Duplicate file names.

PUBLICFOLDER="/Users/lgarron/Dropbox/Public/"
DROPBOXID="13568303"

M3UFOLDER=`dirname "$PWD/$1"`
RELATIVEFOLDER=`echo "$M3UFOLDER" | sed "s@$PUBLICFOLDER@@"`
URLPATH="http://dl.getdropbox.com/u/$DROPBOXID/$RELATIVEFOLDER"
echo $M3UFOLDER
echo $RELATIVEFOLDER
echo $URLPATH

M3UFILEFULL=`basename "$1"`
M3UFILE="${M3UFILEFULL%.*}"
OUTFILE="Playlist-$M3UFILE.m3u"
MUSICFOLDERNAME="Playlist-$M3UFILE"
echo $M3UFILEFULL
echo $OUTFILE
echo $M3UFILE

mkdir "$MUSICFOLDERNAME"

touch "$OUTFILE"
echo -n "" > "$OUTFILE"

cat "$1" | tr '\r' '\n' |
while read linefile1
do
if [[ "$linefile1" == \#* ]]
then
    echo $linefile1 >> "$OUTFILE"
else
    BASE=`basename "$linefile1"`
    ln -s "$linefile1" "$M3UFOLDER/$MUSICFOLDERNAME/$BASE"
    FILEURL=`echo "$URLPATH/$MUSICFOLDERNAME/$BASE" | sed 's/\ /%20/g'`
    echo "$FILEURL" >> "$OUTFILE"
fi
done

echo "$URLPATH/$OUTFILE"
# qs "$M3UFOLDER/$OUTFILE"
