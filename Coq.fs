module Coq 

  (* Mostly F# implementations of OCaml standard library components *)
  
  let string_of_int (i:int) : string = System.Convert.ToString(i)
  
  let succ (i:int) : int = i + 1
  
  let rec ml_assert (b:bool) : 'a =
      assert b;
      ml_assert b;;
