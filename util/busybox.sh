#!/usr/bin/bash
# Check that the busybox binary and symlinks are as expected.

set -e

export failed="false"
finish() {
    if [ "${failed}" != "false" ]; then
        echo "Fail!"; exit 1
    else
        echo "Success!"; exit 0
    fi
}
fail() { printf "%s\n" "$1"; failed="true"; }

# Generate the list and check that all applets exist.
links="$(mktemp "${TMPDIR:-/tmp}/busybox_links.XXXXXX")"
trap "rm -f '${links}'" EXIT
busybox --list > "${links}"
while IFS= read link; do
    if [ ! -h "/usr/bin/${link}" ]; then
        fail "Symlink for '${link}' does not exist!"
    fi
done < "${links}"

# Check that no symlink points to busybox with no corresponding applet.
for link in /usr/bin/*; do
    if target="$(readlink "${link}")" && \
        [ "${target##*/}" == "busybox" ]; then
        if [ "${link##*/}" != "[" ] && [ "${link##*/}" != "[[" ] && \
            ! grep "${links}" -e "^${link##*/}\$" > /dev/null; then
            fail "'${link}' points to busybox, but no applet exists!"
        fi
    fi
done

finish
