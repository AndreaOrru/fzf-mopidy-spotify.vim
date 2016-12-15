# fzf-mopidy-spotify.vim <a href='https://www.recurse.com' title='Made with love at the Recurse Center'><img src='https://cloud.githubusercontent.com/assets/2883345/11325206/336ea5f4-9150-11e5-9e90-d86ad31993d8.png' height='20px'/></a>

Add Spotify music from Vim to your Mopidy playlist with fzf-powered fuzzy-finding.
![Screencast](http://i.imgur.com/mk2d4bv.gif)

## Requirements
This plugin requires [fzf.vim](https://github.com/junegunn/fzf.vim),
[mpc](http://www.musicpd.org/clients/mpc/), and a running
instance of [Mopidy](https://www.mopidy.com) with a correctly configured
[Mopidy-Spotify](https://github.com/mopidy/mopidy-spotify) to work properly.

## Installation
Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'AndreaOrru/fzf-mopidy-spotify.vim'
```
Then run `:PlugInstall` to download the plugin.

## Commands
- `:Song title` Search for songs by `title`.
- `:ArtistSong artist` Search for songs by `artist`.
- `:Album artist` Search for albums by `artist`.
