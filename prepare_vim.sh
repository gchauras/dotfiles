#!/bin/bash

# update all submodules
git submodule update --init --recursive

# move current .vimrc and .vim
mv ~/.vimrc ~/.vimrc.renamed
mv ~/.vim ~/.vim.renamed

# symlink .vimrc .vim directory
ln -s .vimrc ~/.vimrc
ln -s .vim   ~/.vim
