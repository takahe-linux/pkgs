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
