read -r -p "Are you sure you want to remove Oh My Zsh? [y/N] " confirmation
if [ "$confirmation" != y ] && [ "$confirmation" != Y ]; then
  echo "Uninstall cancelled"
  exit
fi

echo "Removing ~/.oh-my-zsh"
if [ -d ~/.config/zsh/.oh-my-zsh ]; then
  rm -rf ~/.config/zsh/.oh-my-zsh
fi

if [ -e ~/.config/zsh/.zshrc ]; then
  ZSHRC_SAVE=~/.config/zsh/.zshrc.omz-uninstalled-$(date +%Y-%m-%d_%H-%M-%S)
  echo "Found ~/.config/zsh/.zshrc -- Renaming to ${ZSHRC_SAVE}"
  mv ~/.config/zsh/.zshrc "${ZSHRC_SAVE}"
fi

echo "Looking for original zsh config..."
ZSHRC_ORIG=~/.config/zsh/.zshrc.pre-oh-my-zsh
if [ -e "$ZSHRC_ORIG" ]; then
  echo "Found $ZSHRC_ORIG -- Restoring to ~/.config/zsh/.zshrc"
  mv "$ZSHRC_ORIG" ~/.config/zsh/.zshrc
  echo "Your original zsh config was restored."
else
  echo "No original zsh config found"
fi

if hash chsh >/dev/null 2>&1 && [ -f ~/.config/zsh/.shell.pre-oh-my-zsh ]; then
  old_shell=$(cat ~/.config/zsh/.shell.pre-oh-my-zsh)
  echo "Switching your shell back to '$old_shell':"
  if chsh -s "$old_shell"; then
    rm -f ~/.config/zsh/.shell.pre-oh-my-zsh
  else
    echo "Could not change default shell. Change it manually by running chsh"
    echo "or editing the /etc/passwd file."
  fi
fi

echo "Thanks for trying out Oh My Zsh. It's been uninstalled."
echo "Don't forget to restart your terminal!"
