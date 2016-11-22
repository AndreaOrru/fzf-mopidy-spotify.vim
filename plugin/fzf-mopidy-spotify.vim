" fzf-mopidy-spotify.vim - Music fuzzy-finder for Mopidy-Spotify
" Author:   Andrea Orru
" Version:  0.1
" License:  BSD 2-clause

function! s:MpcAdd(line)
    let file = split(a:line)[0]
    silent execute "!mpc add " . file
endfunction

function! s:Song(title)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %artist% - %title% (%album%)" title "' . a:title . '" | grep "^spotify:track"',
    \    'sink': function('<sid>MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:SongByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %title% (%album%)" artist "' . a:artist . '" | grep "^spotify:track"',
    \    'sink': function('<sid>MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:AlbumByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %album%" artist "' . a:artist . '" | grep "^spotify:album"',
    \    'sink': function('<sid>MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

command! -nargs=+ Song       call <sid>Song(<q-args>)
command! -nargs=+ ArtistSong call <sid>SongByArtist(<q-args>)
command! -nargs=+ Album      call <sid>AlbumByArtist(<q-args>)
