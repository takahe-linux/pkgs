#
# Takahe Linux build preferences.
#


#
# Toolchain preferences
#

_target_arch="mips" # Full name
_target_arch_alias="mips" # Partial name (ie 1586->i386)
_target_libc="musl" # libc name
_target_libc_alias="musl" # Partial name (ie glibc->gnu)
_target_kernel="linux"
_cc="gcc"

# Add or override some variables.
_target_system="${_target_kernel}-${_target_libc_alias}"
_target_triplet="${_target_arch}-${_target_system}"
_local_triplet="${CHOST}"

# Target CFLAGS
_target_cflags="-g -Os -ffunction-sections -fno-exceptions"


#
# Target preferences
#

_prefix="/usr"
_libdir="${_prefix}/lib"
_tmpdir="/tmp"
_homedir="/home"
_configdir="/etc"
_bindir="${_prefix}/bin"
_includedir="${_prefix}/include"
_docdir="${_prefix}/share/doc"
_infodir="${_prefix}/share/info"
_licensedir="${_prefix}/share/license"
_mandir="${_prefix}/share/man"
_datadir="/var/lib"
_cachedir="/var/cache"
_logdir="/var/log"


#
# Makepkg preferences
#

_pkgroot="${_homedir}/ash/distro"
PKGDEST="${_pkgroot}/pkgs"
SRCDEST="${_pkgroot}/sources"
LOGDEST="${_pkgroot}/logs"

#
# Toolchain location preferences
#

_toolroot="/opt/${_target_triplet}"
_sysroot="${_toolroot}/sysroot"

