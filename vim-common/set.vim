"
" Maintainer: JG
" Date: June 4
" License: GPL-2 or newer
" --------------------------------------------------
" dotfiles/vim-common/set.vim

"=========================================================
"=========================================================
"basic options{{{
"set cursorline
"syntax on
syntax enable                                                " sets up syntax highlighting
set background=dark
set clipboard=unnamed                                        " yank and paste with the system clipboard
set laststatus=2                                             " always show statusline
" light-line config
let g:lightline = {
\ 'colorscheme': 'material'
      \ }

set spelllang=en                                             " English spellcheck
set spell
set ruler                                                    " show where you are
set scrolloff=10                                              " show context above/below cursorline
set showcmd
set textwidth=80

"tabs
set tabstop=4                                                " sets tabs to 4 spaces
set softtabstop=2                                            " insert mode tab and backspace use 2 spaces
set expandtab
set shiftwidth=4 smarttab                                    " normal mode indentation commands use 2 spaces
set smartindent

"search options
set incsearch                                                " search as you type
set smartcase                                                " case-sensitive search if any caps
set ignorecase                                               " case-insensitive search

"completion options
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full

"file types
set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"layout
set number                                                   " sets line numbers
set relativenumber                                           " sets line numbers
highlight LineNr ctermfg=grey
set colorcolumn=80                                           " color columns beyond 80 characters
highlight ColorColumn ctermbg=red guibg=red
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,eol:¬,nbsp:·,trail:·                   " remove trailing space

" sets parenthetical highlighting to just bold
hi MatchParen cterm=bold ctermbg=Black ctermfg=none
"}}}

" sets noexpandtab for Makefiles
if &ft == 'make'
    setlocal noexpandtab
    setlocal tabstop=4
endif

" Python specific settings
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set fileformat=unix |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent

au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/ " Highlight trailing whitespace


""""""""""""""""""""""
"""Nvim-R-tmux config"""
""""""""""""""""""""""
" Fixes weird character problem in some devel versions neovim under tmux sesssion. This might go away in future.
set guicursor=

" Uses color scheme southernlights from Jakson Alves de Aquino here: https://github.com/jalvesaq/southernlights
" To enable it, save file southernlights.vim to ~/.config/nvim/colors/
"colorscheme southernlights

" Preferred default settings
set nowrap

" start R with F2 key
" map <F2> <Plug>RStart
" imap <F2> <Plug>RStart
" vmap <F2> <Plug>RStart
" R version can be specified like this:
" let vimrplugin_r_path = "/opt/R/3.1.2-release/bin/R"
" Send selection or line to R with space bar, respectively.
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" Shortcut for R's assignment operator: 0 turns it off; 1 assigns underscore; 2 assigns two underscores
let R_assign = 2

" Ensures usage of your own ~/.tmux.conf file
let R_notmuxconf = 1

" Shows function rguments in a separate viewport during omni completion with Ctrl-spacebar (or Ctrl-x Ctrl-o:w)
" let R_show_args = 1

" Use Ctrl-Space to do omnicompletion
inoremap <C-Space> <C-x><C-o>

" Remove white background of status line at bottom of nvim viewport (default is 2)
set laststatus=1

"let R_in_buffer = 0
"let R_tmux_split = 1
"let R_applescript = 0
"let R_tmux_close = 0

" The following provides a zoom functionality, similar to Tmux's Ctrl-a z, by pressing 'gz' in normal mode.
function ZoomWindow()
        let cpos = getpos(".")
        tabnew %
        redraw
        call cursor(cpos[1], cpos[2])
        normal! zz
    endfunction
    nmap gz :call ZoomWindow()<CR>


