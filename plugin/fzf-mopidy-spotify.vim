" fzf-mopidy-spotify.vim - Music fuzzy-finder for Mopidy-Spotify
" Author:   Andrea Orru
" Version:  0.1
" License:  BSD 2-clause

function! MpcAdd(line)
    let file = split(a:line)[0]
    silent execute "!mpc add " . file
endfunction

function! s:PlaySong(title)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %artist% - %title% (%album%)" title "' . a:title . '" | grep "^spotify:track"',
    \    'sink': function('MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:PlaySongByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %title% (%album%)" artist "' . a:artist . '" | grep "^spotify:track"',
    \    'sink': function('MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

function! s:PlayAlbumByArtist(artist)
    call fzf#run(fzf#wrap(
    \   {'source': 'mpc search -f "%file% %album%" artist "' . a:artist . '" | grep "^spotify:album"',
    \    'sink': function('MpcAdd'),
    \    'options': '-m --with-nth 2..' }))
endfunction

command! -nargs=+ Song       call <sid>PlaySong(<q-args>)
command! -nargs=+ ArtistSong call <sid>PlaySongByArtist(<q-args>)
command! -nargs=+ Album      call <sid>PlayAlbumByArtist(<q-args>)
