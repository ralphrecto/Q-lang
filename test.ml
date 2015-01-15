open Ast
open Eval

let _ =
  let filename = Sys.argv.(1) in
  let lexbuf = Lexing.from_channel (open_in filename) in
  let prog = Parser.program Lexer.token lexbuf in
  eval (to_expr prog)
