# Setup in a new server

nvim requires to install the plugin manager [vim-plug](https://github.com/junegunn/vim-plug).
to setup de dotfiles open a terminal and run

- `ln -s ~/dotfiles/nvim/vimrc ~/.config/nvim/init.vim`

then run `nvim` to go into a session and run `PlugInstall` to install all the 
plugins listed in the setup dotfile.

# Run scripts in nvim as a REPL
To activate a REPL for a specific script opened in nvim, you need to have installed
the plugin [vimcmdline](https://github.com/jalvesaq/vimcmdline?tab=readme-ov-file).
Once installed you can run in normal mode `\s`. To instance a REPL for R you will 
need to install the plugin [Nvim-R](https://github.com/jalvesaq/Nvim-R). To open the
REPL you need to run in normal mode `\rf`.
