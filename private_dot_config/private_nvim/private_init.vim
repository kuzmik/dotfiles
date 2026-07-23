" ~/.config/nvim/init.vim

" Neovim shares the standard vim config. The vimrc guards vim-only bits
" (e.g. the viminfo path) behind !has('nvim') so nvim keeps its own ShaDa.
execute 'source' expand('~/.config/vim/vimrc')
