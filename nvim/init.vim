" Maintainer: JG
" Date: June 4 
" License: GPL-2 or newer
" --------------------------------------------------
" dotfiles/vim/vimrc

set nocompatible
let g:vim_bootstrap_editor = 'nvim'	
set runtimepath+=$HOME/dotfiles/vim-common

"=========================================================
"=========================================================
" Plugins will be downloaded under the specified directory.
call plug#begin(expand('~/.config/nvim/plugged'))
" screen and window management
"Plug 'mhinz/vim-startify'             " cute!
"Plug 'qpkorr/vim-bufkill'             " :BD is very useful

"editing and formatting
Plug 'tpope/vim-sensible'
Plug 'tomtom/tcomment_vim'
Plug 'ntpeters/vim-better-whitespace' " to remove trailing whitespace on save
"Plug 'tpope/vim-surround'             " adds surround action to create cmts
"Plug 'tpope/vim-unimpaired'           " many additional movements with [ and ]
"Plug 'machakann/vim-highlightedyank'  " blink
"Plug 'haya14busa/incsearch.vim'

" completion
Plug 'lifepillar/vim-mucomplete'

" navigation
Plug 'justinmk/vim-sneak'             "Powerful and minimal motion plugin
Plug 'SirVer/ultisnips'               " Track the engine.
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

"" files, buffers, and tags
Plug 'ap/vim-buftabline'         " adds buffer tabs and numbers
Plug 'dhruvasagar/vim-vinegar'   " - for curdir and adds some netrw behaviors

" colors and UI
Plug 'airblade/vim-gitgutter'          " put chars in gutter
Plug 'kshenoy/vim-signature'           " less cluttered, marks more visible
Plug 'luochen1990/rainbow'             "showing different levels of parentheses in different colors
"Plug 'itchyny/lightline.vim'           " workable. Prob could be done by hand.
"Plug 'itchyny/vim-cursorword'          " this works w * operator
Plug 'mhartington/oceanic-next'       "theme inspired by Oceanic Next for Sublime
Plug 'junegunn/seoul256.vim'          "low-contrast Vim color scheme based on Seoul Colors

" languages
Plug 'sheerun/vim-polyglot'
" Plug 'lervag/vimtex'
Plug 'reedes/vim-pencil'
Plug 'vim-scripts/dbext.vim'

" markdown stuff
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'

Plug 'dense-analysis/ale'             "providing linting (syntax checking and semantic errors)
Plug 'vim-airline/vim-airline'        "Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'
Plug 'ncm2/ncm2'                      "slim, fast and hackable completion framework
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-github'
" Plug 'ncm2/ncm2-syntax'
" Plug 'ncm2/ncm2-jedi'
" Plug 'ncm2/ncm2-vim'
" Plug 'ervandew/supertab'
" Plug 'godlygeek/tabular'

Plug 'jalvesaq/Nvim-R', {'branch':'stable'} "Vim's support to edit R code
Plug 'jalvesaq/vimcmdline'            "Send code to command line interpreter

"List ends here. Plugins become visible to Vim after this call.
call plug#end()

" must follow all Plug calls
filetype plugin indent on

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
if (has("termguicolors"))
 set termguicolors
endif

"colorscheme OceanicNext
colorscheme default

source $HOME/github/dotfiles/vim-common/remaps.vim
source $HOME/github/dotfiles/vim-common/set.vim   " for the lightline config
