# Linking

Originally Takahe Linux utilized static linking, largely because it sounded
like a good idea at the time.

Static linking:

- Harder to break things.
- Development files should be split into separate packages.

Dynamic linking:

- Less full rebuilds are required.
- Performance is roughly the same (similar startup times for python, vim, file,
  and memory usage is nearly identical).
- Better upstream compatiability.
- Makes intepreted languages like python, perl viable.
- More disk space is required, since the libraries are loaded at runtime.

Performance was tested on a Toshiba 310CDS (Pentium-MMX, *very* slow disk,
limited memory).
The numbers suggested that big things are slow regardless, and dynamic linking
just shifts the overhead from kernel space (disk access) to user space
(linking at runtime).
Perhaps if the disk access speed was less significant the ~0.1s extra userspace
overhead might become important.

Fresh boot memory use is just over 4MB for both systems.
`python -c 'import argparse'` takes ~3.5 seconds for both, then ~1.9 seconds.
`bash -c "echo ':q' | vim /etc/fstab"` took ~5.7, ~4.7, ~3.5, ... for static,
~5.4, ~3.7, ~4.0, ~3.5, ... for dynamic.
`bash -c 'for i in $(seq 20); do file / > /dev/null; done'` took 5.1 warm
on a static system, 5.3 on a dynamic system.
`python &` weighed in at 2MB on both a static and a shared system.

