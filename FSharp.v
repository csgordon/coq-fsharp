Extraction Language Ocaml.

(* Unless otherwise noted, these are actually the default extraction settings *)

(* Reduce dummy beta/iota etc. *)
Set Extraction Optimize.

(* Consider types with a single 1-argument ctor as type aliases instead of wrappers. *)
Unset Extraction KeepSingleton.

(* Let the F# compiler to the inlining (NONDEFAULT) *)
Unset Extraction AutoInline.

(* Eventually we'll want a set of Coq primitives to erase more
   arguments for, like erasing vector indices and such... *)
(* Extraction Implicit Vector.t ... *)

(* Unlikely we'll ever need a /standard/ set of constant extractions. *)
(* Extract Constant qualid => string. *)

(* Remap a few standard types to .NET primitives *)
(* First, a couple straight from the manual *)
Extract Inductive unit => "unit" [ "()" ].
Extract Inductive bool => "bool" [ "true" "false" ].
Extract Inductive sumbool => "bool" [ "true" "false" ].

Extract Inductive list => "list" [ "[]" "(::)" ].
Extract Inductive prod => "(*)" [ "(,)" ].

