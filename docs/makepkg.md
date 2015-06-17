# Makepkg replacment/enhancement ideas and notes #

I intend to eventually do away with my build script and just use makepkg.
However, it needs to support cross-compiled builds first!

## Notes ##

- I should just be able to use the 'global' depends and makedepends, and not
  worry about split packages - see FS42191. In other words, sourcing the
  PKGBUILD should give me all of the information I need to build a dependency
  tree!

## Ideas ##

I perhaps should make a few scripts dedicated to extracting information from
PKGBUILDs - that should help with simplifying the task of creating a dependency
tree and building the packages.
It would also make it more language-independent!

I should look at makepkg itself for details - it's quite cool. Although I don't
think that I can easily borrow from it.

For ordering, have a look at tsort. It will do that bit for me!
Or, I'll implement my own. If I do so, I'll have to be quite careful.
Also, I should look at using SBU's to determine ordering based on build time.

