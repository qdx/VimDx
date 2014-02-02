" set vim to support 256 colors since gnome-terminal do support that
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" general settings
set nocompatible
" hybrid line number
set relativenumber
set number
" use 2 space as tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
" TODO: some indent options I don't really get
set autoindent
set smartindent
set smarttab
" assume dark background
set background=dark
" automatically detect file types
" syntax highlighting on
syntax on
" auto detect mouse
set mouse=a
" hide mouse when typing
set mousehide
" allow for cursor beyond last character
set virtualedit=onemore
" store a lot history than default 20
set history=1000
" allow buffer switching without saving
" set hidden
" enable backup
set backup
" use persistent undo
set undofile
" maximum number of changes that can be undone
set undolevels=1000
" maximum number lines to save for undo on a buffer reload
set undoreload=10000
" appearance
" show current mode
set showmode
" highlight current line
set nocursorline
" show matching brackets
set showmatch
" find as you type
set incsearch 
" case insensitive search
set ignorecase
" Lines to scroll when cursor leaves screen
set scrolljump=5
" minimum lines to keep above and below cursor
set scrolloff=5
" Highlight problematic whitspaces
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace "
" do not wrap long lines
set nowrap
" split windows on the right
set splitright
" split windows below
set splitbelow
" windows can be 0 line hight
" set winminheight=0
" change the leader key
let mapleader = ','

" Initialize directories, mainly borrowed from Steve who wrote spf13-vim configuration
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
        \ 'backup' : 'backupdir',
        \ 'views'  : 'viewdir',
        \ 'swap'   : 'directory',
        \ 'undo'   : 'undodir'}
  let common_dir = parent . '/.' . prefix
  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create directory:" . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

" vundle setup
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
filetype plugin indent on
" use bundle file
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" colorscheme 
colorscheme Tomorrow-Night-Bright

" emmet
let g:user_emmet_expandabbr_key = '<c-z>'
let g:use_emmet_complete_tag = 1

" vimwiki
let g:vimwiki_use_mouse=1
let g:vimwiki_list=[{'path' : '~/.vimwiki/main',
      \ 'path_html' : '~/.vimwiki/main/html' ,
      \ 'diary_link_count' : 1},
      \ {'path' : '~/.vimwiki/vim/',
      \'path_html' : '~/.vimwiki/vim/html'},
      \ {'path' : '~/.vimwiki/music/',
      \'path_html' : '~/.vimwiki/music/html'},
      \ {'path' : '~/.vimwiki/programmer/',
      \'path_html' : '~/.vimwiki/programmer/html'},
      \ {'path' : '~/.vimwiki/bicycle/',
      \'path_html' : '~/.vimwiki/bicycle/html'},
      \ {'path' : '~/.vimwiki/Facemeet/',
      \'path_html' : '~/.vimwiki/Facemeet/html'},
      \ {'path' : '~/.vimwiki/graduatePaper/',
      \'path_html' : '~/.vimwiki/graduatePaper/html'},
      \ {'path' : '~/.vimwiki/Github/',
      \'path_html' : '~/.vimwiki/Github/html'},
      \ {'path' : '~/.vimwiki/Mathematica/',
      \'path_html' : '~/.vimwiki/Mathematica/html'} ]

" airline
set laststatus=2

" MRU
nmap <F2> :CtrlPMRU<CR>
" toggle nerd tree with
nmap <F3> <ESC>:NERDTreeToggle<CR>
" toggle search highlights
nmap <silent><F4> :set invhlsearch<CR>
" toggle spell check
nmap <silent><F6> :set spell!<CR><BAR>:echo "spell check:" . strpart("offon", 3 * &spell, 3)<CR>
" avoid auto indenting when pasting from other place to terminal
set pastetoggle=<F7>
" toggle gundo tree
nmap <F10> :GundoToggle<CR>
" open up vimrc in a new tab
nmap <F12> :tabnew ~/.vimrc<CR>

" map some insert mode shortcut
imap <c-l> <End>
imap <c-h> <Home>
" map normal mode window moves
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l


