open Ast

let rec string_of_bexpr = function
  | Bool b -> string_of_bool b
  | Eq (x, y) ->  (string_of_expr x) ^ " = " ^ (string_of_expr y)
  | Not x -> "!" ^ (string_of_bexpr x)

and string_of_expr = function
  | Int x -> string_of_int x
  | Plus (x, y) -> (string_of_expr x) ^ " + " ^ (string_of_expr y)
  | Minus (x, y) -> (string_of_expr x) ^ " - " ^ (string_of_expr y)
  | Var x -> x
  | Lam (v, e1) -> "(lam " ^ v ^ ". " ^ (string_of_expr e1) ^ ")"
  | App (e1, e2) -> "App(" ^ (string_of_expr e1) ^ ", " ^ (string_of_expr e2) ^ ")"
  | Let (v, e1, in_expr) -> 
      let e1str = string_of_expr e1 in
      let instr = string_of_expr in_expr in
      "let " ^ v ^ " = " ^ e1str ^ " in " ^ instr
  | If (be, e1, e2) ->
      let bestr = string_of_bexpr be in
      let e1str = string_of_expr e1 in
      let e2str = string_of_expr e2 in
      "if " ^ bestr ^ " then " ^ e1str ^ " else " ^ e2str

let string_of_value = function
  | VInt x -> string_of_int x
  | VLam (x, e, _) -> string_of_expr (Lam (x, e))

