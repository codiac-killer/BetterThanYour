" Enable line numbers
set number

" Enable mouse use
set mouse=a

" Ctrl + s to save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Ctrl + q to exit
nmap <C-q> :q<CR>
imap <C-q> <Esc>:q<CR>
imap <C-H> <C-W>

" Common clipboard with system
set clipboard=unnamedplus


" Save callbacks
autocmd BufWritePost *.md !pandoc <afile> --pdf-engine=xelatex -o <afile>.pdf

" Move lines up/down with arrows
nnoremap <A-Up>   :<C-u>move-2<CR>==
xnoremap <A-Up>   :move-2<CR>gv=gv
nnoremap <A-Down> :<C-u>move+<CR>==
xnoremap <A-Down> :move'>+<CR>gv=gv

" Tab
" Set length
set tabstop=2
set shiftwidth=2
set expandtab
" Set keybinds for indentation
vnoremap <Tab> >
vnoremap <S-Tab> <
inoremap <S-Tab> <C-D>
