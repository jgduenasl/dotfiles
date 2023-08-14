"
" Maintainer: JG
" Date: June 4 
" License: GPL-2 or newer
" --------------------------------------------------
" dotfiles/vim-common/remaps.vim
" 
"==================================================================
"=================================================================
" mappings
"" the big picture here is:
"" * remapping std vim keys should be enhancements, not overrides
"" * leader keys are in groups
"" * try to stay off remapping C- keys. There's already lots there.
"" * A-x keys move among windows and do not-vimmy stuff
" Vim inline comments don't work with mappings

"defining global leader key
let g:mapleader='\'

"go up and down prompt
nnoremap <space> <C-d>
"revisar
nnoremap <C-space> <C-u>

""hightligth on and off
nnoremap <leader>c :set cursorline!<CR>
"" tweaks adding functionality to existing keys
nnoremap D Da
" Keep the cursor in place while joining lines
nnoremap J mzJ`z
"split a line in two, inverse of J
nnoremap <leader>J a<CR><Esc>k$

"" direct editing
nnoremap <leader>evim :e ~/dotfiles/nvim/vimrc<cr>
nnoremap <leader>eset :e ~/dotfiles/vim-common/set.vim<cr>
nnoremap <leader>emaps :e ~/dotfiles/vim-common/remaps.vim<cr>
nnoremap <leader>ebash :e ~/dotfiles/bash/bash_profile<cr>
nnoremap <leader>etut :e ~/tutorials/Readme.md<cr>

"save on escape
"inoremap <Esc> <Esc>:w<CR>

"" buffer navigation 
nnoremap <leader>1 :b1<CR>
nnoremap <leader>2 :b2<CR>
nnoremap <leader>3 :b3<CR>
nnoremap <leader>4 :b4<CR>
nnoremap <leader>5 :b5<CR>
nnoremap <leader>6 :b6<CR>
nnoremap <leader>7 :b7<CR>
nnoremap <leader>8 :b8<CR>
nnoremap <leader>9 :b9<CR>
nnoremap <leader>0 :b10<CR>

" set t key will toggle the Tagbar window
"nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>T :TagbarToggle<CR>

"""""""""""""""""""""
"""NERDTree Plugin"""
"""""""""""""""""""""
" Installation
"       - Download NERDTree plugin from here
"         http://www.vim.org/scripts/script.php?script_id=1658
"       - unzip nerdtree.zip -d ~/.vim
"
" Usage
"   - '?' opens quick help
"   - '\z' opens and 'q' closes NERDTree ('\z 'requires setting below)
"       - 't' opens file in new tab
"       - 'T' opens file in new tab silently
"   - 'gt' and 'gT' switch between tabs
"       - 'm' opens menu mode for creating/deleting files, 'Ctrl-c' to exit out of this mode
"

" Instruct NERDTree to always opens in the current folder
"set autochdir
"let NERDTreeChDirMode=2
nnoremap <leader>n :NERDTree .<CR>

" Optional to show special NERDTree browser characters properly (e.g. on remote linux system)
let g:NERDTreeDirArrows=0

" Show bookmarks by default
let NERDTreeShowBookmarks=1
" set maps for nerdtree file system explorer

" Settings
" Opens NERDTree with custom shortcut, here '\z'
nmap <leader>z :NERDTreeToggle<cr>
nnoremap <leader>zc :NERDTreeFocus<CR>
nnoremap <leader>zf :NERDTreeFind<CR>

" Use ctrl-[jkl;] to select the active split
nnoremap <C-k> :wincmd k<cr>
nnoremap <C-j> :wincmd j<cr>
nnoremap <C-h> :wincmd h<cr>
nnoremap <C-l> :wincmd l<cr>
