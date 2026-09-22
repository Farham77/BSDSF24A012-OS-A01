
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

# Static Library Report

## Makefile Differences

The direct-compilation Makefile links the object files directly into the executable. The static-library Makefile adds an `AR` macro for the `ar` utility, a `LIBRARY` macro for `lib/libmyutils.a`, and separate driver and library object lists. Its rules first compile the objects, then archive the string and file objects into the static library, and finally link `main.o` with that library to create `bin/client_static`.

## Purpose of `ar` and `ranlib`

The `ar` command creates and modifies archive files. In this project, `ar rcs` combines the utility object files into `lib/libmyutils.a`, which the linker can use as a static library. `ranlib` creates or updates the archive symbol index so the linker can quickly find the object file that defines a requested symbol. The `s` option in `ar rcs` commonly creates this index automatically, so a separate `ranlib` command is usually unnecessary here.

## Static Symbols in the Executable

Yes, `nm bin/client_static` shows symbols such as `mystrlen`, `mystrcpy`, `mystrncpy`, `mystrcat`, `wordCount`, and `mygrep`. Their presence as defined text symbols shows that the required object code was copied from the static archive into the final executable during linking. Static linking includes the selected library code inside the executable, so the program does not need `libmyutils.a` at runtime.
