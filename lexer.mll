{ 
open Lexing
open Parser

exception SyntaxError of string

let error lexbuf =
  raise (SyntaxError ("Unexpected character: " ^ (lexeme lexbuf)))
}

(* number definitions *)
let digit = ['0'-'9']
let num = '-'? digit+

(* whitespace *)
let white = [' ' '\t']+
let newline = '\n' | 'r' | "\r\n"
let var = ['a'-'z'] ['a'-'z' '0'-'9']*

rule token =
  parse
  | white       { token lexbuf }
  | newline     { new_line lexbuf; token lexbuf }
  | "*"         { TIMES }
  | "/"         { LAM }
  | "+"         { PLUS }
  | "-"         { MINUS }
  | "."         { DOT }
  | "="         { EQ }
  | "let"       { LET }
  | "in"        { IN }
  | "if"        { IF }
  | "then"      { THEN }
  | "else"      { ELSE }
  | "true"      { TRUE }
  | "false"     { FALSE }
  | "not"       { NOT }
  | num as n    { INT(int_of_string n) }
  | eof         { EOF }
  | _           { error lexbuf }
