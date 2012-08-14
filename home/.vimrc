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
" Splitting a window will put the new window below
set splitbelow
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

" Color theme
colors Tomorrow-Night-Eighties

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
" use tabs at the start of a line, spaces elsewhere
set smarttab
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
set autoindent
set smartindent

" switch on spell checking everywhere in en_us using sane highlighting
set spell
:highlight clear SpellBad
:highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
:highlight clear SpellCap
:highlight SpellCap term=underline cterm=underline
:highlight clear SpellRare
:highlight SpellRare term=underline cterm=underline
:highlight clear SpellLocal
:highlight SpellLocal term=underline cterm=underline

" If we're in a wide window, enable line numbers.
fun! <SID>WindowWidth()
	if winwidth(0) < 75
		setlocal nonumber
	else
		setlocal number
	endif
endfun

" Force active window to the top of the screen without losing its size.
fun! <SID>WindowToTop()
	let l:h=winheight(0)
	wincmd K
	execute "resize" l:h
endfun

" Force active window to the bottom of the screen without losing its size.
fun! <SID>WindowToBottom()
	let l:h=winheight(0)
	wincmd J
	execute "resize" l:h
endfun

" Enable file type settings
filetype on
filetype plugin on
filetype indent on

" Automatic commands
if has("autocmd")
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Turn off search highlight when idle
	autocmd CursorHold * nohls | redraw
	" Automagic line numbers
	autocmd BufEnter * :call <SID>WindowWidth()
	" Always do a full syntax refresh
	autocmd BufEnter * syntax sync fromstart
	" For help files, move them to the top window and make <Return>
	" behave like <C-]> (jump to tag)
	autocmd FileType help :call <SID>WindowToTop()
	autocmd FileType help nmap <buffer> <Return> <C-]>
	" For the quickfix window, move it to the bottom
	autocmd FileType qf :3 wincmd _ | :call <SID>WindowToBottom()
	" give us an error window, but only if results are available.
	autocmd QuickFixCmdPost * :cwindow 3
endif

" mappings
" -------------------

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

" Make <space> in normal mode go down a page
noremap <space> <C-f>

" User leader mapping
" -------------------

" open split window
nnoremap <leader>w <C-w>v<C-w>l

" reselect the text that was just pasted
nnoremap <leader>v V`]

" strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" turn current search highlighting off, toggle with n (,hs)
noremap <leader>hs :noh<CR>

" stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

" Plugin configuration
" --------------------

" pathogen: https://github.com/tpope/vim-pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" syntastic-options: https://github.com/scrooloose/syntastic/
" Do syntax checks when buffers are first loaded as well as on saving
let g:syntastic_check_on_open=1
" Use this option to control what the syntastic |:sign| text contains
let g:syntastic_error_symbol='✪'
let g:syntastic_style_error_symbol='✘'
let g:syntastic_warning_symbol='⚠'
" Cursor jumps to the first detected error
let g:syntastic_auto_jump=1
" Error window will be automatically opened
let g:syntastic_auto_loc_list=0
" Specify the height of the location lists
let g:syntastic_loc_list_height=4
