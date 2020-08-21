"
" Maintainer: JG
" Date: June 4 
" License: GPL-2 or newer
" --------------------------------------------------
" dotfiles/vim/vimrc
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
nnoremap <leader>evim :e ~/github/dotfiles/vim/vimrc<cr>
nnoremap <leader>envim :e ~/github/dotfiles/nvim/init.vim<cr>
nnoremap <leader>ebash :e ~/github/dotfiles/bash/bash_profile<cr>
nnoremap <leader>etut :e ~/github/tutorials/Readme.md<cr>

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

