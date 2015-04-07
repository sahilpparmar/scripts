"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

inoremap jj <ESC>                                                                                                                                     
set nocompatible
set number
set autoindent
set smartindent
set shiftwidth=4 softtabstop=4
set incsearch ignorecase hlsearch
set showmatch
filetype plugin on
set ft=cpp
set smartcase
set smarttab
set cul 
set noswapfile
set nobackup
set expandtab
set backspace+=indent,eol,start
set whichwrap+=l,h
set nowrap
set hidden
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap Y y$
set path+=/home/sahil/cse506/**
syntax on
set background=dark
colorscheme desert

" Run maximized in GUI
if has("gui_running")
   au GUIEnter * simalt ~x
endif

" Save and restore folding of lines
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

au BufRead,BufNewFile *.* set filetype=cpp

" Generate ctags in required dir and switch back to current directory
if has("win32") || has("win64")
    let g:tagsDir = 'c:/tmp'
    set clipboard=unnamed
else
    let g:tagsDir = '~/ctags'
    set clipboard=
endif

function! CtagsOverPath()
    let l:curdir = getcwd()
    execute 'silent cd ' . g:tagsDir
    execute 'silent !ctags -R ~/linux' 
    execute 'silent cd ' . l:curdir
endfunction

execute 'silent set tags=' . g:tagsDir . '/tags'
command! GenerateCtags call CtagsOverPath()
nnoremap <silent> <F9> :GenerateCtags<CR>
