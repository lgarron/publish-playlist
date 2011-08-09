# publish-playlist
*Easy Playlist Export fom iTunes to Dropbox*  
Lucas Garron

Sometimes you just need a playlist to be available from online, but don't want to keep all your songs in Dropbox all the time. (Or maybe you need it as a stream.)

This script adds songs from a playlist to your Dropbox folder and gives you an [.m3u](http://en.wikipedia.org/wiki/M3U) URL that can be loaded in many music players, including iTunes, VLC, and mobile Safari.

Since this script uses symlinks, it also takes up almost no additional lcal disk space, just Dropbox space for songs that need to be synced.

## Sample Installation

    cat publish-playlist.sh > publish-playlist
    chmod +x publish-playlist
    mv publish-playlist /usr/local/bin/

## Usage

    $ publish-playlist filename.m3u

  - In iTunes, go *File > Library > Export Playlist...* and save the playlist as an m3u.
  - Run a command like <code>publish-playlist "~/Documents/My Exported Playlist.m3u"</code>
  - Wait for the songs to sync (or not) and visit the returned URL. The file should be able to open in VLC and iTunes.