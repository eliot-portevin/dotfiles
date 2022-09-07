"Plugins
call plug#begin('~/.config/nvim/autoload/plugged')

" Better Syntax Support
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
Plug 'frazrepo/vim-rainbow'

call plug#end()

"Lightline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }

"Startify
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
        \ {'a': '~/.config/alacritty/alacritty.yml'},
        \ {'f': '~/.config/fish/config.fish'},
        \ {'v': '~/.config/nvim/init.vim' },
        \ ]

let g:startify_custom_header = [
        \ '      _____ _ _       _    ______ ',
        \ '     |  ___| (_)     | |   | ___ \',
        \ '     | |__ | |_  ___ | |_  | |_/ /',
        \ '     |  __|| | |/ _ \| __| |  __/ ',
        \ '     | |___| | | (_) | |_ _| |    ',
        \ '     \____/|_|_|\___/ \__(_)_|    ',
        \ ]

"Rainbow
let g:rainbow_active = 1

set number
