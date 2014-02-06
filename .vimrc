silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction

" setting up for windows
if WINDOWS()
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  " the following should actually be triggered when system is GBK encoded, not
  " just on windows.
  set encoding=utf-8
  set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
  set langmenu=zh_CN.UTF-8
  language message zh_CN.UTF-8
endif

" setting up for gvim
if has('gui_running')
  set guioptions-=T           " Remove the toolbar
  set lines=40                " 40 lines of text instead of 24
  set guifont=Consolas:h11:cANSI	"set font
endif

" set vim to support 256 colors since gnome-terminal do support that
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" solve the problem where backspace cannot delete in insert mode
set backspace=indent,eol,start
" encoding used in vim scripts
scriptencoding utf-8
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
" use bundle file
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
filetype plugin indent on
filetype plugin on


" emmet
let g:user_emmet_expandabbr_key = '<c-z>'
let g:use_emmet_complete_tag = 1

" disallow nerdtree to start on gvim start
let g:nerdtree_tabs_open_on_gui_startup=0

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

" neocomplete config from spf13
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_force_overwrite_completefunc = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns._ = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" fencview
let g:fencview_autodetect = 0

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
" Map FencView with
map <F11> :FencView<CR>
" open up vimrc in a new tab
nmap <F12> :tabnew ~/.vimrc<CR>

" map some insert mode shortcut
inoremap <c-l> <End>
inoremap <c-h> <Home>
" map normal mode window moves
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" color schemes
if WINDOWS()
  colorscheme koehler
else
  colorscheme Tomorrow-Night-Bright
endif
