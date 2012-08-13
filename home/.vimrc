" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Set auto-indenting on for programming
set ai

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype plugin on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

" Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Color theme
colors Tomorrow-Night-Eighties

" No more arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" move one line down or up display-wise
nnoremap j gj
nnoremap k gk

" User leader mapping
" -------------------

" Open split window
nnoremap <leader>w <C-w>v<C-w>l

" reselect the text that was just pasted
nnoremap <leader>v V`]

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Toggle highlighting on/off, and show current value.
noremap <leader>hs :set hlsearch! hlsearch?<CR>

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Plugin config
" -------------

" syntastic-options: https://github.com/scrooloose/syntastic/
" -----------------
" Do syntax checks when buffers are first loaded as well as on saving
let g:syntastic_check_on_open=1
" Use this option to control what the syntastic |:sign| text contains
let g:syntastic_error_symbol='✘'
let g:syntastic_style_error_symbol='✪'
let g:syntastic_warning_symbol='⚠'
" Cursor jumps to the first detected error
let g:syntastic_auto_jump=1
" Error window will be automatically opened
let g:syntastic_auto_loc_list=1
" Specify the height of the location lists
let g:syntastic_loc_list_height=4
