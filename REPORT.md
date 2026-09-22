
# Task 5 Report

## Makefile Linking Rule

The rule `$(TARGET): $(OBJECTS)` says that the executable target depends on all object files. When any object file is newer than the executable, the linker combines the object files into the target executable. This project links object files directly, so the linker command receives files such as `obj/main.o` and `obj/mystrfunctions.o`.

A rule that links against a library uses a library file or library name instead, such as `lib/libmyfunctions.a` or `-lmyfunctions`. The library must first be built, and the linker searches the specified library path and links the required library code.

## Git Tags

A Git tag is a named reference to a specific commit. Tags are useful for marking important project points, such as releases, so that the same version can be found again later.

A simple tag contains only a name that points to a commit. An annotated tag is a Git object that stores the tagger, date, message, and the referenced commit. Annotated tags are preferred for releases because they preserve release metadata.

## GitHub Releases

A GitHub Release presents a tagged version as a downloadable and documented project version. It gives users a stable point to inspect, download, and reproduce.

Attaching a binary such as `bin/client` lets users download and run the compiled program without installing the compiler or rebuilding the source code themselves.
