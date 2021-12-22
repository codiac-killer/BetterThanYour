" ***** ENABLE FEATURES *****
" for tab size
set tabstop=2
set shiftwidth=2

" Set Colorscheme
syntax enable
set background=dark
colorscheme space-vim-dark
" Set comment style
hi Comment guifg=#5C6370 ctermfg=59
hi Comment cterm=italic

" Make backspace work on insert mode
set backspace=indent,eol,start

" Show linenumbers
set number

" Autoindentation
set smartindent

" hide mode under the statusline
set noshowmode

" tab line
set showtabline=2

" Hightlight current line
set cursorline

" Get file's dir as working dir
set autochdir

" Make title only filename(+ modification status)
set titlestring=%f%m%r%h

" Enable opening buffers 'hidden' on background
set hidden

" Highlight search matches
set hlsearch

" ***** KEYBINDS *****
" Browse through buffers with key binds
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

noremap h <left>
noremap t <down>
noremap n <up>
noremap s <right>

noremap l n
noremap L N

" ***** HOOKS *****

" Compile latex on save
command MakePDF !/usr/local/texlive/2020/bin/x86_64-linux/pdflatex -synctex=1 -interaction=nonstopmode %:t

au BufReadPost *.tex set syntax=tex

" *** CUSTOM STATUS LINE ***

" Enable status line
set laststatus=2

set statusline=
" What MODE
set statusline+=%#StatusLineTerm#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#Insert#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#Replace#%{(mode()=='R')?'\ \ RPLACE\ ':''}
set statusline+=%#VisualMode#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#VisualLine#%{(mode()=='V')?'\ \ V-LINE\ ':''}
set statusline+=%#Cursor#%{(mode()=='c')?'\ \ COMMND\ ':''}
set statusline+=%#Visual#                               " colour
" Important Flags
set statusline+=%{&paste?'\ \ PASTE\ ':''}
set statusline+=%{&spell?'\ \ SPELL\ ':''}

set statusline+=%#CursorLine#                           " colour
set statusline+=\ %t\                                   " short file name
set statusline+=%#ROStatus#%r                           " readonly flag
set statusline+=%#ModStatus#%m                          " modified [+] flag
set statusline+=%#CursorLine#                           " colour

set statusline+=%=                                      " right align
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}\   " encoding
set statusline+=\ %{&ff}\                               " file format
set statusline+=%#Syntax#                               " colour
set statusline+=\ %Y\                                   " syntax
set statusline+=%#CursorPos#                            " colour
set statusline+=\ %3l:%-2c\                             " line + column
set statusline+=%#CursorLine#                           " colour
set statusline+=\ %3p%%\                                " percentage

" Set Cursor ******************************************************************
let &t_SI = "\e[6 q" " Bar cursor for start insert mode
let &t_EI = "\e[2 q" " Block cursor for exit insert mode

" Delay between hitting key and switching mode
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END

