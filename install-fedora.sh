#!/bin/bash

HOME_DIR="/home/$USER"
CFG_DIR="$HOME_DIR/.config"
SOURCE_DIR=$(pwd)
SSH_DIR="$HOME_DIR/.ssh"
SSH_KEY="id_rsa"
VIM_PATH="/usr/share/vim"

USER_FULL_NAME="$(getent passwd "$USER" | cut -d ':' -f 5)"

GIT_REPO_NAME="OpenboxDesktop"
GIT_REPO="https://github.com/rvais/OpenboxDesktop.git"

DOMAIN="redhat.com"

echo "Installing packages ..."

dnf install -y ansible cb-compositor conky g++ gcc gimp git gmrun gnuplot gpaste gvim hexchat htop java-1.8.0-openjdk \
    langpacks-cs maven mc NetworkManager nitrogen nm-applet numlockx openbox perl python3 terminator tint2 vim vlc \
    xbacklight xcompmgr xfce4-pulseaudio-plugin xfce4-screenshooter xorg-x11-server-util xscreensaver

if [ -f "$SSH_DIR/$SSH_KEY" ]; then 
  echo "SSH key '$SSH_DIR/$SSH_KEY' already exists."
else
  echo "Generating SSH key ... It's recomended to use '$SSH_DIR/$SSH_KEY' as path (name)."
  ssh-keygen -t rsa -b 4096 -C
fi

echo "Setting up global configuration for git tool ..."
git config --global user.name $USER_FULL_NAME
git config --global user.email "$USER@$DOMAIN"
git config --global core.editor vim
git config --global user.signingkey "$SSH_DIR/$SSH_KEY"
git config --global branch.autoSetupRebase always
git config --global log.decorate auto
git config --global http.sslVerify true

echo "Downloading repository '$GIT_REPO' ..."
# git clone "$GIT_REPO" "$GIT_REPO_NAME"

cd "$GIT_REPO_NAME"
HERE=$(pwd)
for ITEM in $(ls); do
  if [ -d "${HERE%/}/$ITEM" ]; then
    echo "Configuring $ITEM ..."
    if [ "$ITEM" == "vim" ]; then
      VIM_DIR=$(ls -1 $VIM_PATH | grep -P -e "vim\d+")
      echo "VIM_DIR $VIM_DIR"
      if [ -d "${VIM_PATH%/}/$VIM_DIR" ]; then
        cp -r -t "${VIM_PATH%/}/$VIM_DIR" "${HERE%/}/vim/colors/."
        cp "${HERE%/}/vim/vimrc" "${HOME_DIR%/}/.vimrc"
      else
        echo "Couldn't find specific version (versioned directory) in $VIM_PATH. Skipping configuration of $ITEM..."
      fi
    elif [ "$ITEM" == "git" ]; then
      mkdir -p "${CFG_DIR%/}/gitEnhancement"
      cp -r -t "${CFG_DIR%/}/gitEnhancement" "${HERE%/}/$ITEM/."
    elif [ "$ITEM" == "scripts" ]; then
      mkdir -p "${HOME_DIR%/}/bin"
      cp -r -t "${HOME_DIR%/}/bin" "${HERE%/}/$ITEM/."
    else
      mkdir -p "${CFG_DIR%/}/$ITEM"
      cp -r -t "${CFG_DIR%/}/$ITEM" "${HERE%/}/$ITEM/."
    fi 
  fi
done

echo "Creating custom bashrc ..."
if [ -f "${HOME_DIR%/}/.bashrc" ]; then
  echo "Backing up original bashrc to '$CFG_DIR'..."
  cp "${HOME_DIR%/}/.bashrc" "${CFG_DIR%/}/bashrc.backup"
fi

echo -e "# .bashrc\n# script generated bashrc file" > "${HOME_DIR%/}/.bashrc"
cat << EOF >> ${HOME_DIR%/}/.bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Git enhancing scripts
if [ -x ${CFG_DIR%/}/gitEnhancement/git-completetion.bash ]; then
	. ${CFG_DIR%/}/gitEnhancement/git-completetion.bash
fi
if [ -x ${CFG_DIR%/}/gitEnhancement/aliases.bash ]; then
	. ${CFG_DIR%/}/gitEnhancement/aliases.bash
fi
if [ -x ~/.config/gitEnhancement/prompt.bash ]; then
	. ~/.config/gitEnhancement/prompt.bash
fi

export NAME="$USER_FULL_NAME"
export EMAIL="$USER@$DOMAIN"
export RPM_PACKAGER="$NAME <$EMAIL>"
export EDITOR="vim"
export VISUAL="vim"

alias la='ls -all'
alias spec='if [ -f *.spec ]; then vim *.spec; else echo "No spec"; fi'
alias ..='cd ..'
alias rkinit='kinit $USER@${DOMAIN^^}'
EOF

