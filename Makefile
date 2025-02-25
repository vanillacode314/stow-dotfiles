.PHONY: install uninstall
install:
	git submodule update --init --recursive
	stow --no-folding --target=${HOME} .

install-adopt:
	git submodule update --init --recursive
	stow --adopt --no-folding --target=${HOME} .

uninstall:
	git submodule update --init --recursive
	stow --delete --target=${HOME} .
