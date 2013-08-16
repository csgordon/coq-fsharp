# coq-fsharp

Tools for extracting Coq code to F#.

## Why extract Coq to F#?

There are two main use cases for extracting a Coq program to F#: using F# as a modern runtime system, or using verified code in a .NET project.

### F# As A Runtime System

Coq supports 3 extraction target languages by default:

1. Scheme (dynamically typed, strict, concurrent)
2. Ocaml (statically typed, strict, single-threaded)
3. Haskell (statically typed, lazy, concurrent)

So if you'd like to extract Coq code to a statically typed, strict, concurrent language, you're out
of luck with the default targets (modulo some ongoing experimental work by OCamlPro to have true
parallelism in OCaml).  Admittedly, Coq doesn't actually have any concurrency in its language, but
this seems important for the growing set of DSLs for verified programming that are implemented as an
embedding into Coq (e.g. [Ynot](http://ynot.cs.harvard.edu/),
[Bedrock](http://plv.csail.mit.edu/bedrock/), or [RGref](https://github.com/csgordon/rgref)).

### Embedding Verified Code in a .NET Project

## How

Fortunately, there is a significant subset of OCaml that is also valid F# code, so with a bit of
remapping certain primitives using standard Coq Extraction commands, much Coq code can be extracted
directly to F#.  The main restrictions I'm currently aware of are:

- F#'s module system does not include functors, so Coq code using functors won't extract well.

## Extracting Coq to F#

The heart of the system is currently a script 'ml2fs.sh' which rewrites an OCaml file to an F# file in the same directory (assuming the OCaml code is in the supported subset).  The intent is that the subset of OCaml handled by the script is that resulting from extracting a Coq program with no non-trivial module usage after having imported 'FSharp.v'.

For a simple taste, look at the Makefile, or run 'make test' on a fresh checkout.

Installing F#
-------------

The [F# Software Foundation](http://fsharp.org) has directions for most platforms.  For Debian/Ubuntu, the latest Mono packages are broken, so we suggest following the instructions [here](https://gist.github.com/csgordon/6195154).
