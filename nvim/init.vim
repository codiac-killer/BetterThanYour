" *** ENABLE FEATURES ***
" Enable line numbers
set number

" Enable mouse use
set mouse=a

" Mathing brackets
set showmatch

" Tab
" Set length
set tabstop=2
set shiftwidth=2
set expandtab

" Common clipboard with system
set clipboard=unnamedplus

" Set my nice colorscheme
colorscheme gruvbox

" *** KEY REMAPS ***
" Move lines up/down with arrows
nnoremap <A-Up>   :<C-u>move-2<CR>==
xnoremap <A-Up>   :move-2<CR>gv=gv
nnoremap <A-Down> :<C-u>move+<CR>==
xnoremap <A-Down> :move'>+<CR>gv=gv

" Home gets you to first character
inoremap <Home> <Esc>^i

" Map Ctrl+Backspace to kill word
inoremap <C-H> <C-W>

" *** HOOKS ***
" Save callbacks
autocmd BufWritePost *.md !pandoc <afile> --pdf-engine=xelatex -o <afile>.pdf

" *** Custom Functions/Commands ***
command MakePDF ! pdflatex -synctex=1 -interaction=nonstopmode %:t

" *** CUSTOM STATUS LINE ***
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=%#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#Visual#       " colour
set statusline+=%{&paste?'\ PASTE\ ':''}
set statusline+=%{&spell?'\ SPELL\ ':''}
set statusline+=%#Cursor#               " colour
" set statusline+=%#CursorLine#     " colour
set statusline+=\ %t\                   " short file name
set statusline+=%#CursorIM#     " colour
set statusline+=%R                        " readonly flag
set statusline+=%M                        " modified [+] flag
set statusline+=%#Cursor#               " colour
set statusline+=%=                          " right align
" set statusline+=%#CursorLine#   " colour
set statusline+=\ %Y\                   " file type
set statusline+=%#CursorIM#     " colour
set statusline+=\ %3l:%-2c\         " line + column
set statusline+=%#Cursor#       " colour
set statusline+=\ %3p%%\                " percentage
