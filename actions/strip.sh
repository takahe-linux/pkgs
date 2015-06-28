#!/usr/bin/env sh

source "$(dirname $(realpath $0))"/../config.sh

# Strip the resulting library and binary files

for f in ${_sysroot}/usr/bin/* ${_sysroot}/usr/lib/*; do
    if [ -f $f ] && [ "$(file $f | grep -e 'ELF')" != "" ]; then
        sudo ${_toolroot}/bin/${_target_triplet}-strip --strip-all $f
    fi
done

