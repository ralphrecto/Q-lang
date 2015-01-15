type var = string
(* todo: use GADTs *)

type _ expr =  
  | Int : int -> int expr
  | Plus : (int expr * int expr) -> int expr
  | Bool : bool -> bool expr
  | Not : bool expr -> bool expr
  | Eq : (int expr * int expr) -> bool expr
  | Lam : (var * 'a expr) -> (var * 'a expr) expr
  | App : ((var * 'a expr) expr * ('b expr)) -> 'a expr
  | Let : (var * 'a expr * 'b expr) -> 'b expr
  | If : (bool expr * 'a expr * 'a expr) -> 'a expr

(*
(* "untyped" version of expr *)
type any_expr =
  | AInt of int
  | APlus of any_expr * any_expr
  | ABool of bool
  | ANot of any_expr
  | AEq of any_expr * any_expr 
  | ALam of var * any_expr
  | AApp of any_expr * any_expr
  | ALet of var * any_expr * any_expr
  | AIf of any_expr * any_expr * any_expr

let rec to_expr: type a. any_expr -> _ expr = function
  | AInt x -> Int x
  | APlus (e1, e2) -> Plus (to_expr e1, to_expr e2)
  | ABool b -> Bool b
  | ANot e -> Not (to_expr e)
  | AEq (e1, e2) -> Eq (to_expr e1, to_expr e2)
  | ALam (v, e1) -> Lam (v, to_expr e1)
  | AApp (e1, e2) -> App (to_expr e1, to_expr e2)
  | ALet (v, e1, e2) -> Let (v, to_expr e1, to_expr e2)
  | AIf (e1, e2, e3) -> If (to_expr e1, to_expr e2, to_expr e3)
  *)
