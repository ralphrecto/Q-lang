(* open Ast *)

type env = var -> value 

let empty_env = fun _ -> failwith "unclosed lambda"

let add_binding (e: env)(x: var)(v: value): env =
  fun y -> if x = y then v else e y

(*
let rec evala (ae: aexpr): int = function
  | Int x -> x
  | Plus (x, y) -> (evala x) + (evala y)
  | Minus (x, y) -> (evala x) - (evala y)
  | Times (x, y) -> (evala x) * (evala y)

let rec evalb (ae: bexpr): bool = function
  | True -> true
  | False -> false
  | Eq (ae1, ae2) -> (evala ae1) = (evala ae2)
  | Not be -> not (evalb be)

let rec eval' (exp: expr)(envr: env): value = function
  | AExpr x -> Int (evala x)
  | Lam (v, e1) -> VLam (v, e1)
  | _ -> failwith "lol implement me tho"
*)

(* eval w/ GADTs *)
let rec eval : type a . a expr -> a = function
  | Int x -> x
  | Plus (e1, e2) -> (eval e1) + (eval e2)
  | Bool b -> b
  | Not e -> not (eval e)
  | Eq (e1, e2) -> (eval e1) = (eval e2)
  | Lam p -> p
  | App (e1, e2) -> let (v, e1') = eval e1 in eval e1' (* TODO *)
  | Let (v, e1, e2) -> eval e2 (* TODO *)
  | If (be, e1, e2) -> if (eval be) then eval e1 else eval e2
