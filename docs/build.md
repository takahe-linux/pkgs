# Build script info #

The build script shouldn't be _too_ complicated...

Here's the basic requirements:

- Build Takahe Linux
- Rebuild individual packages and all that depended on them
- Skip installing packages if not explicitely told to build them
- Support clean chroots for building in

Here's the nice-to-haves:

- Nice cross compile support
- Testing integration
- Abstracted so that it can also act as a generic makeworld kind of
  package script.

## Mk.1 ##

The first version is pretty simple; run through an ordered list of packages
and rebuild them as required.
It's simple, but not particularily quick - it rebuilds _everything_, and if
you just want to repackage something, you will have to go through a whole
bunch of redundant steps that take forever.

## Mk.2 ##

The more complex, yet-to-be-written version.

The goal is to have a dependency-driven system.

Being dependency-driven basically means that the system uses dependencies to
figure out what needs to be done.


