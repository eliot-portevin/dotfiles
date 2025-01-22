syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set termguicolors
set mouse=a
highlight Normal ctermbg=NONE guibg=NONE

"Plugins
call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'tpope/vim-sensible'               " Default vim config that everyone should have
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlighting, auto-indent, etc.
Plug 'francoiscabrol/ranger.vim'        " File system viewer
Plug 'ap/vim-css-color'                 " Preview colours in source code
Plug 'mhinz/vim-startify'               " Vim menu
Plug 'luochen1990/rainbow'              " Change paranthesis colour by pair
Plug 'itchyny/lightline.vim'            " Vim status line
Plug 'jiangmiao/auto-pairs'             " Auto open and close brackets
Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " Colour theme

call plug#end()

""""""""""""""""""""""""""""""""""""""""
""""""""""""Catppuccin""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
colorscheme catppuccin-frappe

""""""""""""""""""""""""""""""""""""""""
""""""""""""Treesitter""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
lua << EOF
require('nvim-treesitter.configs').setup {
	ensure_installed = "all", 
	highlight = { enable = true },
	indent = { enable = true }
}
EOF

""""""""""""""""""""""""""""""""""""""""
""""""""""""Lightline"""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }
""""""""""""""""""""""""""""""""""""""""
"""""""""""""Startify"""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
"Startify
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recently Used Files'],     'max': 4 },
      \ { 'type': 'dir',       'header': ['   Files in Current Directory'], 'max': 6 },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ { 'type': 'commands',  'header': ['   Commands'],                'max': 5 },
      \ ]

let g:startify_bookmarks = [
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

function! s:truncate_filename(fname)
  let fname = fnamemodify(a:fname, ':~:p')
  let maxchars = winwidth(0) - (g:startify_padding_left * 2 + 6)
  if strdisplaywidth(fname) - 1 > maxchars
    while strdisplaywidth(fname) > maxchars
      let fname = substitute(fname, '.$', '', '')
    endwhile
    let fname = fname . '>'
  endif
  return fname
endfunction

let g:startify_transformations = [
  \ ['.*', function('s:truncate_filename')],
  \ ]

let g:startify_files_number = 5

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""Rainbow"""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""Diverse"""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
set number

"Leader key
let mapleader = " "
nmap <leader>t :<C-u>echo "Normal map"<cr>
vmap <leader>v :<C-u>echo "Visual map"<cr>

set shell=bash
