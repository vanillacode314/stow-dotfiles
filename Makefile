.PHONY: install uninstall
install:
	git submodule update --init --recursive
	stow --dotfiles --no-folding --target=${HOME} .

reinstall:
	git submodule update --init --recursive
	stow --restow --dotfiles --no-folding --target=${HOME} .

install-adopt:
	git submodule update --init --recursive
	stow --dotfiles --adopt --no-folding --target=${HOME} .

uninstall:
	git submodule update --init --recursive
	stow --dotfiles --delete --target=${HOME} .
