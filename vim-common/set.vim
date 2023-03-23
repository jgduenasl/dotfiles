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
