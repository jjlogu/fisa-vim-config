call plug#begin('~/.vim/plugged')

" < Other Plugins, if they exist >

Plug 'fatih/vim-go'
Plug 'fatih/molokai'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-airline/vim-airline'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Better file browser
Plug 'scrooloose/nerdtree'
"comment
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Go to alternate
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
nmap <silent> at :AT<CR>
nmap <silent> aa :A<CR>

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_highlight_types = 1
let g:go_highlight_fields = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']

"Go Debug
"Step Over
map <silent> <F8> :GoDebugNext<CR>
imap <silent> <F8> :GoDebugNext<CR>
"Step Into
map <silent> <F7> :GoDebugStep<CR>
imap <silent> <F7> :GoDebugStep<CR>
"Step Out
map <silent> <S-F8> :GoDebugStepOut<CR>
imap <silent> <S-F8> :GoDebugStepOut<CR>
"Continue Run
map <silent> <F6> :GoDebugContinue<CR>
imap <silent> <F6> :GoDebugContinue<CR>
"Stop
map <silent> <S-F6> :GoDebugStop<CR>
imap <silent> <S-F6> :GoDebugStop<CR>
"Breakpoint
map <silent> <F9> :GoDebugBreakpoint<CR>
imap <silent> <F9> :GoDebugBreakpoint<CR>

" Custom config
" toggle nerdtree display
map <silent> <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap <silent> ,t :NERDTreeFind<CR>
" don't show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Switch between test and code
nmap <silent> ,ga :GoAlternate<CR>

" Enable folder icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" save as sudo
ca w!! w !sudo -S tee "%"

" tab navigation mappings
map <silent> tt :tabnew
map <silent> tl :tabn<CR>
imap <silent> tl <ESC>:tabn<CR>
map <silent> th :tabp<CR>
imap <silent> th <ESC>:tabp<CR>

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

" Folding
set foldmethod=syntax

" Light Theme
" let g:airline_theme = 'papercolor'
" colorscheme default


" Dark Theme
let g:airline_theme = 'onehalfdark'
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1

inoremap <silent> jj <Esc>

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END
set cursorline

