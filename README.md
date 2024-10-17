# DotFiles
The repo includes my dot config files.

# Installation

## Move dotfiles to right place
Run this command to link all dotfiles in homedir:
```
for file in $(pwd)/dotfiles/.*; do ln -sf "$file" ~/"$(basename "$file")"; done
```

## Install URxvt plugins

### In- and decrease font size
```
mkdir -p ~/.urxvt/ext
pushd ~/.urxvt/ext
wget https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font
popd
```
