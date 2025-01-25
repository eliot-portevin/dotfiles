syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set termguicolors
set mouse=a
set foldmethod=indent
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
		\ {'k': '~/.config/kitty/kitty.conf'},
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


set shell=bash						" Vim calls commands with bash

hi Normal guibg=NONE ctermbg=NONE   " Sets Vim to be transparent

""""""""""""""""""""""""""""""""""""""""
""""""Run or Compile Current File"""""""
""""""""""""""""""""""""""""""""""""""""
function! RunOrCompile()
    let filetype = expand('%:e')		" Get the file extension
    let filename = expand('%:t')		" Get the file name
    let start_time = reltime()			" Record the start time

    write								" Run :w

    if filetype ==# 'tex'
        " Compile .tex file with pdflatex
        silent execute '!pdflatex' shellescape(expand('%'), 1)
        let status = "Compilation complete for " . filename

    elseif filetype ==# 'py'
        " Run .py file with Python 3
        silent execute '!python3' shellescape(expand('%'), 1)
        let status = "Finished running " . filename

    elseif filetype ==# 'c'
        " Compile and run .c file using make
        silent execute '!make' shellescape(expand('%:r'), 1)
        let status = "Compilation and execution complete for " . filename

    else
        echo "Unsupported file type: " . filetype
        return
    endif

    " Calculate elapsed time
    let elapsed_time = reltimestr(reltime(start_time))
    echo status . " in " . elapsed_time . "s."
endfunction

"Leader key
let mapleader = " "
nmap <leader>t :<C-u>echo "Normal map"<cr>
vmap <leader>v :<C-u>echo "Visual map"<cr>
nnoremap <Leader>r :call RunOrCompile()<CR>
