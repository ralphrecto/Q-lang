open Ast
open Util

exception TypeError of string
exception VarError of string

let empty_env = fun x -> raise (VarError ("var " ^ x ^ " not found "))

let add_binding (e: env) (x: var) (v: value): env =
  fun y -> if x = y then v else e y

let lookup (e: env) (x: var): value = e x

let rec evalb (exp: bexpr)(envr: env): bool =
  match exp with
  | Bool b -> b
  | Eq (ae1, ae2) -> begin
      match eval' ae1 envr, eval' ae2 envr with
      | VInt x, VInt y -> x = y
      | _ -> raise (TypeError "= takes 2 arithmetic expressions")
    end
  | Not be -> not (evalb be envr)

and eval' (exp: expr)(envr: env): value =
  match exp with
  | Int x -> VInt x
  | Plus (x, y) -> begin
      match eval' x envr, eval' y envr with
      | VInt x', VInt y' -> VInt (x' + y')
      | _ -> raise (TypeError "+ takes 2 arithmetic expressions")
    end
  | Minus (x, y) -> begin
      match eval' x envr, eval' y envr with
      | VInt x', VInt y' -> VInt (x' - y')
      | _ -> raise (TypeError "+ takes 2 arithmetic expressions")
    end
  | Var x -> envr x 
  | Lam (v, body) -> VLam (v, body, envr)
  | App (e1, e2) -> begin
    match eval' e1 envr with
    | VInt _ -> raise (TypeError "trying to apply args to int")
    | VLam (v, e1', in_env) ->
        eval' e1' (add_binding in_env v (eval' e2 envr))
    end
  | Let (v, e1, e2) ->
      eval' e2 (add_binding envr v (eval' e1 envr))
  | If (be, e1, e2) ->
      if evalb be envr then eval' e1 envr else eval' e2 envr

let eval exp = eval' exp empty_env
