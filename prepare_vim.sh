#!/bin/bash

# update all submodules
git submodule update --init --recursive

# symlink .vimrc .vim directory
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.vim   ~/.vim

# configure vim plugins
vim +PluginInstall +qall
