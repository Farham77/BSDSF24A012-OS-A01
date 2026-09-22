
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

# Dynamic Library Report

## Position-Independent Code

Position-Independent Code, enabled by `-fPIC`, can execute correctly regardless of the memory address where the shared library is loaded. Shared libraries may be loaded at different addresses by different processes, so their machine code cannot depend on fixed absolute addresses. The compiler and linker use position-independent addressing and relocation-friendly references, which makes the code suitable for a `.so` library.

## Static and Dynamic Client Sizes

The static client contains the required utility function code copied from `libmyutils.a`, while the dynamic client contains references to functions in `libmyutils.so` and loads that code at runtime. Therefore, a static executable is normally larger than its dynamic counterpart, although the shared library must be distributed separately. In this small project, `ls -lh bin/` showed both clients at approximately 17K because executable metadata and runtime startup code dominate the small amount of application code. The dynamic release therefore needs both `client_dynamic` and `libmyutils.so`.

## LD_LIBRARY_PATH

`LD_LIBRARY_PATH` is an environment variable containing directories that the Linux dynamic loader searches for shared libraries. It was necessary because `libmyutils.so` is in the project's `lib/` directory, which is not one of the loader's default search locations. Exporting the directory allowed the loader to resolve the dependency before starting the program. This shows that the loader is responsible for locating and mapping shared libraries at runtime, while the application or its launch environment must provide a discoverable library path.
