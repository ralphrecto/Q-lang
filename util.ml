open Ast

let rec string_of_aexpr (ae: aexpr): string = function
  | Int x -> string_of_int x
  | Plus (x, y) -> aexpr_helper x y "+"
  | Minus (x, y) -> aexpr_helper x y "-"
  | Times (x, y) -> aexpr_helper x y "*"

and aexpr_helper f arg1 arg2 sym =
  (string_of_aexpr arg1) ^ sym ^ (string_of_aexpr arg2)

let rec string_of_bexpr (be: bexpr): string = function
  | True -> "T"
  | False -> "F"
  | Eq (x, y) -> aexpr_helper x y "="
  | Not x -> "!" ^ (string_of_bexpr x)

let rec string_of_expr (e: expr): string = function
  | AExpr ae -> string_of_aexpr
  | Lam (v, e1) -> "lam" ^ x ^ ". " ^ (string_of_expr e1)
  | App (e1, e2) -> (string_of_expr e1) ^ " " ^ (string_of_expr e2)
  | Let (v, e1, in_expr) -> 
      let e1str = string_of_expr e1 in
      let instr = string_of_expr in_expr in
      "let " ^ v " = " ^ e1str ^ " in " ^ instr
  | If (be, e1, e2) ->
      let bestr = string_of_bexpr be in
      let e1str = string_of_expr e1 in
      let e2str = string_of_expr e2 in
      "if " ^ bestr ^ " then " ^ e1str ^ " else " ^ e2str

let string_of_value (v: value): string = function
  | Int x -> string_of_int x
  | VLam p -> string_of_expr (Lam p)

