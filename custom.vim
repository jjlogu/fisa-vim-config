" Plugins from github repos:
" Search pattern all
Plug 'dyng/ctrlsf.vim'
" Simple Fold
Plug 'tmhedberg/SimpylFold'
" Pydoc
Plug 'fs111/pydoc.vim'


" ctrlsf finder
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
nmap ,l <Plug>CtrlSFPrompt
vmap ,vl <Plug>CtrlSFVwordPath
vmap ,el <Plug>CtrlSFVwordExec
nmap ,wl <Plug>CtrlSFCwordPath<CR>
nmap ,bl <Plug>CtrlSFCCwordPath<CR>
nmap ,ll <Plug>CtrlSFPwordPath<CR>
nnoremap <F5> :CtrlSFToggle<CR>
inoremap <F6> <Esc>:CtrlSFToggle<CR>

let g:airline_theme = 'papercolor'
" let g:airline_theme = 'bubblegum'
" colorscheme vim-monokai-tasty
colorscheme default

inoremap jj <Esc>