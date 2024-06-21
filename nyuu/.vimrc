" autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel --input --clipboard")
" filetype plugin on
" syntax on
set clipboard=unnamedplus

set nocompatible

set backspace=indent,eol,start

" backups and other junky files
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set writebackup
set undodir=~/.vim/undo
set undofile

set history=1000
set laststatus=2
set lazyredraw
set matchtime=2
set number
set ruler
set showcmd
set showmatch
set relativenumber
set cursorline
set display=lastline,uhex

set incsearch
set ignorecase
set smartcase
" set gdefault

set autoindent
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set smarttab
set fileformats=unix,dos
set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣

set formatoptions=crqlj
" set tabstop=4

set colorcolumn=+1 "
set linebreak
set showbreak=↳\
set textwidth=80 "
set virtualedit=block

set ttymouse=xterm2
set mouse=a
set guifont=Source\ Code\ Pro\ 16

set encoding=utf-8
setglobal fileencoding=utf-8
set nobomb
set fileencodings=ucs-bom,utf-8,iso-8859-1

set wildmenu
set wildmode=full
set wildignore+=.*.sw*,__pycache__,*.pyc

set complete-=i
set completeopt-=preview

set scrolloff=2
set foldmethod=indent
set foldlevel=99
set timeoutlen=1000
set ttimeoutlen=100
set nrformats-=octal

set autoread
autocmd FocusGained * if mode() != 'c' | checktime | endif
autocmd BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | execute 'checktime'     expand("<abuf>") | endif

call pathogen#infect()

" Key bindings for FZF
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> g/ :Rg<cr>

" Using Ripgrep with FZF
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview(), <bang>0)


let g:ycm_python_binary_path = 'python'

" ALE (linter)
" Only use flake8 for Python, because pylint is huge and impossible to appease

let g:ale_linters = {
  \ 'c': ['gcc', 'clang'],
  \ 'python': ['flake8'],
  \ }

let g:ale_c_clang_options = '-Wall -Wextra -std=c11 -pedantic'

" Stupid Unicode tricks
let g:ale_sign_info = "🚩"
let g:ale_sign_warning = "🚨"
let g:ale_sign_error = "💥"
let g:ale_sign_style_warning = "💈"  " get it?  /style/ issues?  wow tough crowd
let g:ale_sign_style_error = "🚨"

" Airline; use powerline-style glyphs and colors
let g:airline_powerline_fonts = 1
" ALE
let g:airline#extensions#ale#error_symbol = "🚨"
let g:airline#extensions#ale#warning_symbol = "🚩"

"some stuff goes here

if &t_Co > 2 || has("gui_running")
  syntax enable
  set background=dark
  set hlsearch
endif


set t_Co=256  " force 256 colors
colorscheme molokai

if has("autocmd")
  " Filetypes and indenting settings
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif " has("autocmd")

" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
hi ColorColumn ctermbg=black guibg=darkgray
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/

" molokai's diff coloring is terrible
highlight DiffAdd    ctermbg=22
highlight DiffDelete ctermbg=52
highlight DiffChange ctermbg=17
highlight DiffText   ctermbg=53

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Automatically compile and run the program in tmux on saving a C file
autocmd BufWritePost *.c silent execute "!tmux send-keys -t right 'clear; /home/nyuu/scripts/compile_and_run.sh " . shellescape(expand('%:p'), 1) . "' C-m"

