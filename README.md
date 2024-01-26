# DotFiles
The repo includes my dot config files.

# Installation
Run this command to link all dotfiles in homedir:
```
for file in $(pwd)/dotfiles/.*; do ln -sf "$file" ~/"$(basename "$file")"; done
```

## Track commands
Just tracking commands that might come handy in the future.

### Re-link
If you need to update the symbolic links for your dotfiles to point to a new directory.
This can be done by using the ln command with the -sf options in a Unix-like environment.
The -s option makes the link symbolic, and -f forces the link to be updated if it already exists.
```
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.aliases ~/.aliases
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.bashrc ~/.bashrc
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.speedswapper ~/.speedswapper
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.vimrc ~/.vimrc
ln -sf /home/thorgeir/git/hub/thorgeir/dotfiles/dotfiles/.Xdefaults ~/.Xdefaults
```
