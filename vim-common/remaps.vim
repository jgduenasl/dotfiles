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
nnoremap <C-J> a<CR><Esc>k$

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

" set maps for nerdtree file system explorer
nnoremap <leader>ntc :NERDTreeFocus<CR>
nnoremap <leader>nt :NERDTree<CR>
nnoremap <leader>ntt :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFind<CR>
