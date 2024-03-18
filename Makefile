install:
	git submodule update --init --recursive
	stow --target=${HOME} .
