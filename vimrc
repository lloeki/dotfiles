" lloeki's vimrc

set nocompatible

"bundle loading via pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

scriptencoding "utf-8"

"make sure backspace behaves
set backspace=indent,eol,start

if has('gui_running') "GUI specific settings
    
    "better font
    set guifont=Menlo:h12
    
    "no toolbar
    set guioptions-=T

    set background=light
    set transparency=8

    "window size
    set columns=90
    set lines=30

else "non-GUI
    set background=dark
    set showtabline=0           "no tab bar
endif

"color theme
"colorscheme desert
"colorscheme delek
let g:solarized_termcolors=16
colorscheme solarized

"special case fixes
"if &term =~ "vt100"
"    let &term="xterm"
"endif

"if &term =~ "xterm"
"    if has("terminfo")
"        let &t_Co=8
"        let &t_Sf="\e[3%p1%dm"
"        let &t_Sb="\e[4%p1%dm"
"    else
"        let &t_Co=8
"        let &t_Sf="\e[3%dm"
"        let &t_Sb="\e[4%dm"
"    endif
"endif

"enable syntax highlighting if term supports enough colors
if has('syntax') && (&t_Co > 2)
    syntax on
endif

"enable filetype detection
"filetype on
filetype plugin on
filetype indent on

"ignore some files
set wildignore+=*.o,*.obj,.git,.svn,*.pyc

"display more info
set showmode        "display current mode at the bottom
set showcmd         "display command info at the bottom
set ruler           "display coordinates and relative position at the bottom
set number          "show line numbers in left margin
set laststatus=1


" search tweaks
set incsearch
set ignorecase      "ignore case when searching
set smartcase       "... but be nice when actually typing caps

" tabbing settings
set shiftwidth=4            "indent size
set shiftround              "round indent to next offset
set tabstop=4               "size of tab character
set expandtab               "insert spaces instead of tab
set softtabstop=4           "... and that much spaces are inserted
set smarttab                "tab insertion actually indents on line start
set autoindent              "new line copies indent from above

"feedback
set cursorline              "highlight current line
set showmatch               "highlight both matching parentheses
set listchars=eol:¬,tab:→\ ,nbsp:•,trail:⋅
set list

"filetype specific settings
autocmd FileType make set noexpandtab   "makefiles need tabs

"swap files
"set directory=/var/tmp,.

"key mappings
let mapleader = ','

"Command-T mappings
let g:CommandTAcceptSelectionTabMap='<CR>'
let g:CommandTAcceptSelectionMap='<C-r>'

" xterm escape codes for osx-like cursor motion
"noremap [1;3D <C-Left>
"noremap [1;3C <C-Right>
"noremap [H <Home>
"noremap [F <End>
"noremap [1;5D <Home>
"noremap [1;5C <End>
"noremap! [1;3D <C-Left>
"noremap! [1;3C <C-Right>
"noremap! [H <Home>
"noremap! [F <End>
"noremap! [1;5D <Home>
"noremap! [1;5C <End>

" highlight background for >80
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


" restore last known cursor position
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

" unfold at cursor position
if has("folding")
  function! UnfoldCur()
    if !&foldenable
      return
    endif
    let cl = line(".")
    if cl <= 1
      return
    endif
    let cf  = foldlevel(cl)
    let uf  = foldlevel(cl - 1)
    let min = (cf > uf ? uf : cf)
    if min
      execute "normal!" min . "zo"
      return 1
    endif
  endfunction
endif

" restore last known cursor position on open
augroup resCur
  autocmd!
  if has("folding")
    autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
  else
    autocmd BufWinEnter * call ResCur()
  endif
augroup END

