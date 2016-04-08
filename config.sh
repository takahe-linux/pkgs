#
# Takahe Linux build preferences.
#


#
# Toolchain preferences
#

_target_arch="mips" # Full name
_target_arch_alias="mips" # Partial name (ie i586->i386)
_target_triplet="${_target_arch}-linux-musl"
_local_triplet="${CHOST}"


#
# Toolchain location preferences
#

_toolroot="/opt/${_target_triplet}"
_sysroot="/sysroot"


#
# Build preferences
#

# Target CFLAGS and ldflags
_target_cflags="-g -Os -ffunction-sections -fdata-sections --sysroot=/sysroot -I/sysroot/usr/include -L/sysroot/usr/lib"
_target_ldflags="-Wl,-static,-rpath,/sysroot/usr/lib,--sysroot,/sysroot,--gc-sections"


