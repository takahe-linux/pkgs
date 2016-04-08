#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Strip the resulting library and binary files

for f in /sysroot/usr/bin/* /sysroot/usr/lib/lib*.a; do
    if [ -f $f ] && [ "$(file $f | grep -e 'ELF')" != "" ]; then
        sudo ${_toolroot}/bin/${_target_triplet}-strip --strip-all $f
    fi
done

