install:
	git submodule update --init --recursive
	stow --no-folding --target=${HOME} .
