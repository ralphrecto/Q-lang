{ 
open Lexing
open Parser

exception SyntaxError of string
}

(* number definitions *)
let digit = ['0'-'9']
let int = '-'? digit+

(* whitespace *)
let white = [' ' '\t']+
let newline = '\n' | 'r' | "\r\n"

rule read =
  parse
  | white     { read lexbuf }
  | newline   { new_line lexbuf; read lexbuf }
