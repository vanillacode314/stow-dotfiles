default: reinstall

submodules:
  git submodule update --init --recursive

install: submodules
  stow --dotfiles --no-folding --target=${HOME} .
reinstall: submodules
  stow --dotfiles --restow --no-folding --target=${HOME} .
install-adopt: submodules
  stow --dotfiles --adopt --no-folding --target=${HOME} .
uninstall: submodules
  stow --dotfiles --delete --target=${HOME} .
