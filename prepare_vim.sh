#!/bin/bash

# update all submodules
git submodule update --init --recursive

# move current .vimrc and .vim
mv -f ~/.vimrc ~/.vimrc.renamed
mv -f ~/.vim ~/.vim.renamed

# symlink .vimrc .vim directory
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.vim   ~/.vim
