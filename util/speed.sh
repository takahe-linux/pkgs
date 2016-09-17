#!/usr/bin/sh
# Simple benchmarking script for testing purposes.

bs='1M'
count=100

printf -- "--> Vim:"
time sh -c 'yes ":q" | vim > /dev/null 2>&1'

printf -- "--> Bash:"
time sh -c 'bash -c true > /dev/null 2>&1'

printf -- "--> I/O (/dev/null):\n"
dd if=/dev/zero of=/dev/null bs=$bs count=$count

printf -- "--> I/O (in)\n:"
dd if=/dev/zero of=/tmp/test.img bs=$bs count=$count

printf -- "--> I/O (out)\n:"
dd if=/tmp/test.img of=/dev/null bs=$bs count=$count
rm -f /tmp/test.img
