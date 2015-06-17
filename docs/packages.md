# Packages that I intend to build #

I would like all of the below; however, I also to intend to have 100 packages
or less. So...

- coreutils
- util-linux
- file
- gcc + friends (or generally a toolchain)
- ssh
- web browser (lynx? webkit-based)
- go
- vim
- tex (pdflatex, at least)
- fbv
- qemu
- python3
- bash
- pacman
- git
- unison
- diffutils
- patch

This list is very incomplete!

# Packages and dependencies #

bash: readline, ncurses, libc
coreutils: libc, gmp
diffutils: bash
file: zlib
git: curl, perl, openssl, expat, perl-error, pcre

readline: libc
ncurses: libc
zlib: libc
