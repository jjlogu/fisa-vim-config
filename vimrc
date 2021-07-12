set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

call plug#begin('~/.vim/plugged')
" Vim GO
Plug 'fatih/vim-go'
" Theme
Plug 'fatih/molokai'
Plug 'vim-airline/vim-airline'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Autocompleter
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-terminal', {'do': 'yarn install --frozen-lockfile'}

" Code commenter
Plug 'scrooloose/nerdcommenter'
"Plug 'tpope/vim-commentary'
" Better file browser
Plug 'scrooloose/nerdtree'
" Class/module browser
Plug 'majutsushi/tagbar'
" Search results counter
Plug 'vim-scripts/IndexedSearch'
" Airline
Plug 'vim-airline/vim-airline'
" Code and files fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
" ctrl+Shift+P (ctrlsf)
Plug 'dyng/ctrlsf.vim'
" Pending tasks list
Plug 'fisadev/FixedTaskList.vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'
" Nice icons in the file explorer and file type status line.
Plug 'ryanoasis/vim-devicons'

" Vim tmux Navigator
Plug 'christoomey/vim-tmux-navigator'

" Vim Maximizer
Plug 'szw/vim-maximizer'

" Debugger plugins
"Plug 'mfussenegger/nvim-dap'
"Plug 'puremourning/vimspector'
"Plug 'sebdah/vim-delve'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

call plug#end()

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    " no vi-compatible
    set nocompatible

    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on

    " always show status bar
    set ls=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    " syntax highlight on
    syntax on

    " Command menu auto completion
    set wildmenu
    set wildmode=longest,list,full

    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end


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

let mapleader = ','

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

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

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

" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" save as sudo
ca w!! w !sudo -S tee "%"

" clear search results
nnoremap <silent> // :noh<CR>

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" tab navigation mappings
map tt :tabnew 
map tl :tabn<CR>
imap tl <ESC>:tabn<CR>
map th :tabp<CR>
imap th <ESC>:tabp<CR>

" Fzf ------------------------------

" file finder mapping
nmap ,e :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" the same, but with the word under the cursor pre filled
nmap ,wg :execute ":BTag " . expand('<cword>')<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tags<CR>
" the same, but with the word under the cursor pre filled
nmap ,wG :execute ":Tags " . expand('<cword>')<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wf :execute ":BLines " . expand('<cword>')<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" the same, but with the word under the cursor pre filled
nmap ,wF :execute ":Lines " . expand('<cword>')<CR>
" commands finder mapping
nmap ,c :Commands<CR>

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

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227


" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" VIM-tmux-Navigator -----------------------------
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <ctrl-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <ctrl-j> :TmuxNavigateDown<cr>
nnoremap <silent> <ctrl-k> :TmuxNavigateUp<cr>
nnoremap <silent> <ctrl-l> :TmuxNavigateRight<cr>
nnoremap <silent> <ctrl-h> :TmuxNavigatePrevious<cr>

" VIM-window-maximizer
let g:maximizer_default_mapping_key = '<F4>'

" Folding
set foldmethod=syntax

" Switch between vim window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Neovim-dap settings
"let g:vimspector_enable_mappings = 'HUMAN'
"nmap <leader>vl :call vimspector#Launch()<CR>
"nmap <leader>vr :VimspectorReset<CR>
"nmap <leader>ve :VimspectorEval
"nmap <leader>vw :VimspectorWatch
"nmap <leader>vo :VimspectorShowOutput
"nmap <leader>vi <Plug>VimspectorBalloonEval
"xmap <leader>vi <Plug>VimspectorBalloonEval

" for normal mode - the word under the cursor
nmap <leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <leader>di <Plug>VimspectorBalloonEval

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]


" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal 
" (if you aren't using one of those fonts, you will see funny characters here. 
" Turst me, they look nice when using one of those fonts).
let fancy_symbols_enabled = 1

" Fancy Symbols!!
if fancy_symbols_enabled
    let g:webdevicons_enable = 1

    " custom airline symbols
    if !exists('g:airline_symbols')
       let g:airline_symbols = {}
    endif
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = '⭠'
    let g:airline_symbols.readonly = '⭤'
    let g:airline_symbols.linenr = '⭡'
else
    let g:webdevicons_enable = 0
endif

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

" remove ugly vertical lines on window division
set fillchars+=vert:\

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
