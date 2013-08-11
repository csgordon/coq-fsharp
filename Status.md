# Current Status

Currently we're working on extracting the Coq 8.4 version of Bruno Barras's CoqInCoq to F#.

## Problems uncovered

### Minor OCaml vs. F# Library Differences

E.g., OCaml has 'succ' defined, while F# doesn't.

### Pattern matching

OCaml allows pattern matching in let expressions that F# rejects (in weird ways).  Consider the type declaration from the CoqInCoq ML extraction results:

    type ('a, 'b) prod = 
    | Pair of 'a * 'b

In OCaml, you can match on this:

    # let Pair (x, y) = Pair (3,4) in (y, x);;
    - : int * int = (4, 3)
    # 

In F#, this doesn't parse as a match:

    > let Pair (x, y) = Pair (3,4) in (y, x);;
    
      let Pair (x, y) = Pair (3,4) in (y, x);;
      ---------------------------------^
    
    stdin(3,34): error FS0039: The value or constructor 'y' is not defined
    > 

But if you parenthesize the match, it does!

    > let (Pair (x, y)) = Pair (3, 4) in (y, x);;
    val it : int * int = (4, 3)
    > 

So we need a script to reparenthesize such matches.  This particular case would be handled by extracting products to ML pairs, but the issue is a general one with matching on constructors in let expressions.

### Assertions

OCaml and F# give the built-in 'assert' construct different types.  OCaml seems to give it type

    bool -> 'a

whereas F# appears to give it type

    bool -> unit

Both languages have the 'failwith' construct, of type

    string -> 'a

We'll need to rewrite asserts with a new primitive in F#.
