" fzf-mopidy-spotify.vim - Music fuzzy-finder for Mopidy-Spotify
" Author:   Andrea Orru
" Version:  0.1
" License:  BSD 2-clause

function! s:MpcAdd(line)
    let l:file = split(a:line)[0]
    silent execute "!mpc add " . l:file
endfunction

function! s:MpcLoadPlaylist(list)
    silent execute "!mpc clear && mpc load " . a:list . " && mpc play > /dev/null"
endfunction

function! s:MpcPlay()
    silent execute "!mpc play > /dev/null"
endfunction

function! s:MpcPause()
    silent execute "!mpc pause > /dev/null"
endfunction

function! s:MpcNext()
    silent execute "!mpc next > /dev/null"
endfunction

function! s:MpcPrev()
    silent execute "!mpc prev > /dev/null"
endfunction

function! s:Song(title)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %artist% - %title% (%album%)" title "' . a:title . '" | grep "^spotify:track"',
    \    'sink': function('s:MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:SongByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %title% (%album%)" artist "' . a:artist . '" | grep "^spotify:track"',
    \    'sink': function('s:MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:AlbumByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %album%" artist "' . a:artist . '" | grep "^spotify:album"',
    \    'sink': function('s:MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:AlbumByTitle(title)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %album%" album "' . a:title . '" | grep "^spotify:album"',
    \    'sink': function('s:MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:Playlist(title)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc lsplaylists | grep ' . a:title ,
    \    'sink': function('s:MpcLoadPlaylist'),
    \    'options': '-m' }))
endfunction

command! -nargs=+ Song       call <sid>Song(<q-args>)
command! -nargs=+ ArtistSong call <sid>SongByArtist(<q-args>)
command! -nargs=+ Album      call <sid>AlbumByArtist(<q-args>)

command! -nargs=+ AlbumByTitle  call <sid>AlbumByTitle(<q-args>)
command! -nargs=+ Playlist      call <sid>Playlist(<q-args>)

command! SpotifyPlay    call <sid>MpcPlay()
command! SpotifyPause   call <sid>MpcPause()
command! SpotifyNext    call <sid>MpcNext()
command! SpotifyPrev    call <sid>MpcPrev()
