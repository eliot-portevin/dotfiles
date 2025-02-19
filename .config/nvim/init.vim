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
Plug 'lervag/vimtex'					" Support for Latex

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
""""""""""""Auto-pairs""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
let g:AutoPairs = {
			\ '(':')',
			\ '[':']', 
			\ '{':'}',
			\ "'":"'",
			\ '"':'"',
			\ "`":"`",
			\ '```':'```',
			\ '"""':'"""',
			\ "'''":"'''",
			\ '$':'$'}

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
"""""""""""""""" Vimtex """"""""""""""""
""""""""""""""""""""""""""""""""""""""""
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note: Most plugin managers will do this automatically!
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
" Note: Most plugin managers will do this automatically!
syntax enable

let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_view_zathura_options = '-reuse-instance'

""""""""""""""""""""""""""""""""""""""""
""""""""""""""""Diverse"""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
set number
let maplocalleader="\<space>"
set shell=bash						" Vim calls commands with bash
hi Normal guibg=NONE ctermbg=NONE   " Sets Vim to be transparent

"""""""""""""""""""""""""""""""""""""""""
"""""""Run or Compile Current File"""""""
"""""""""""""""""""""""""""""""""""""""""
function! RunOrCompile()
    let file_commands = {
                \ 'py': 'python3 ' . shellescape(expand('%')),
                \ 'c': 'make ' . shellescape(expand('%:r')) . ' && ./' . shellescape(expand('%:r'))
                \ }
    
    let filetype = expand('%:e')        " Get the file extension
    let filename = expand('%:t')		" Get the file name
    let start_time = reltime()			" Record the start time

    write								" Save the current file

    if has_key(file_commands, filetype)
        let command = file_commands[filetype]
        let output = system(command)
        if v:shell_error
            echohl ErrorMsg | echo "Command failed for " . filename | echohl None
            call s:DisplayOutput(output, 1)
            return
        endif
        let status = "Operation successful for " . filename
    else
        echo "Unsupported file type: " . filetype
        return
    endif

    " Calculate elapsed time
    let elapsed_time = reltimestr(reltime(start_time))
    echo status . " in " . elapsed_time . "s."
	call s:DisplayOutput(output, 0)
endfunction

function! s:DisplayOutput(output, is_error)
    if strlen(a:output) > 1000 || a:is_error
        " Open a new buffer for output
        botright new
        call setline(1, split(a:output, '\n')) " Insert the output into the buffer
        setlocal buftype=nofile bufhidden=wipe noswapfile " Set temporary buffer options
        if a:is_error
            echohl ErrorMsg | echo "Output displayed in temporary buffer due to error." | echohl None
        else
            echo "Output displayed in temporary buffer."
        endif
    else
        " Print output directly if it's short
        echo "\n\n" . a:output
    endif
endfunction

"Leader key
nnoremap <LocalLeader>r :call RunOrCompile()<CR>
