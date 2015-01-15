type var = string
(* todo: use GADTs *)

type bexpr =
  | Bool of bool
  | Eq of expr * expr
  | Not of bexpr

and expr =  
  (* arithmetic expressions *)
  | Int of int
  | Plus of expr * expr
  (* regular expressions *)
  | Var of var
  | Lam of var * expr
  | App of expr * expr
  | Let of var * expr * expr
  | If of bexpr * expr * expr

type value = VInt of int | VLam of var * expr 
