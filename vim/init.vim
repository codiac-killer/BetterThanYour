" *** ENABLE FEATURES ***
" Enable line numbers
set number

" Enable syntax highlighting
syntax on

" Enable mouse use
set mouse=a

" Mathing brackets
set showmatch

" Tab
" Set length
set tabstop=2
set shiftwidth=2
set expandtab

" Make backspace work on insert mode
set backspace=indent,eol,start

" Common clipboard with system
set clipboard=unnamedplus

" Set my nice colorscheme, darkversion
set background=dark
colorscheme space-vim-dark
" Change comment to grey
hi Comment guifg=#5C6370 ctermfg=59
hi Comment cterm=italic

" Set title to only file name(+modification status)
set title
set titlestring=%f%m%r%h

" Show statusline and tabbar
set laststatus=2
set showtabline=2

" Hide mode in command line
set noshowmode

" Highlight current line
set cursorline

" Allow buffers to open even if current is not saved
set hidden

" *** HOOKS ***
" Save callbacks
autocmd BufWritePost *.md !pandoc <afile> --pdf-engine=xelatex -o <afile>.pdf

" *** Custom Functions/Commands ***
command MakePDF ! pdflatex -synctex=1 -interaction=nonstopmode %:t

" *** CUSTOM STATUS LINE ***
" set statusline=
" set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
" set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
" set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
" set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
" set statusline+=\ %n\           " buffer number
" set statusline+=%#Visual#       " colour
" set statusline+=%{&paste?'\ PASTE\ ':''}
" set statusline+=%{&spell?'\ SPELL\ ':''}
" set statusline+=%#Cursor#               " colour
" set statusline+=%#CursorLine#     " colour
" set statusline+=\ %t\                   " short file name
" set statusline+=%#CursorIM#     " colour
" set statusline+=%R                        " readonly flag
" set statusline+=%M                        " modified [+] flag
" set statusline+=%#Cursor#               " colour
" set statusline+=%=                          " right align
" set statusline+=%#CursorLine#   " colour
" set statusline+=\ %Y\                   " file type
" set statusline+=%#CursorIM#     " colour
" set statusline+=\ %3l:%-2c\         " line + column
" set statusline+=%#Cursor#       " colour
" set statusline+=\ %3p%%\                " percentage
