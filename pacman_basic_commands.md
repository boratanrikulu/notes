#### to install a package

	pacman -S packagae

#### to remove a package (removes config files (not configs in home folder))

	pacman -Rsn package

#### to autoremove packages which are no longer needed

	pacman -Qdtq | pacman -Rs -

#### to clean all local caches

	pacman -Sc && pacman -Scc

#### to see information about a package

	pacman -Si package

#### to see installed packages

	pacman -Q

#### to see how many packages you installed

	pacman -Q | wc -l

#### to see installed packages which are from AUR.

	pacman -Qm

source : https://wiki.archlinux.org/index.php/Pacman

source2: https://wiki.archlinux.org/index.php/Pacman/Rosetta