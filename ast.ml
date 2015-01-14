type var = string
(* todo: use GADTs *)
type aexpr = 
    Int of int
  | Plus of aexpr * aexpr
  | Minus of aexpr * aexpr
  | Times of aexpr * aexpr

type bexpr =
    True
  | False
  | Eq of aexpr * aexpr
  | Not of bexpr

type expr =  
    AExpr of aexpr
  | Lam of var * expr
  | App of expr * expr
  | Let of var * expr * expr
  | If of bexpr * expr * expr

type value = Int of int | VLam of var * expr 

