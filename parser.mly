%{
open Ast
%}

%token <int> INT 
%token <string> VAR
%token LAM PLUS DOT LET 
  EQ IN IF THEN ELSE EOF
  LEFT_PARENS RIGHT_PARENS
%start p

%%

e : INT                       { Int $1 }
  | e PLUS e                  { Plus ($1, $3) }
  | LAM VAR DOT e             { Lam ($2, $4) }
  | e e                       { App ($1, $2) }
  | LET VAR EQ e IN e         { Let ($2, $4, $6) }
  | IF e EQ e THEN e ELSE e   { If ($2, $4, $6, $8) }
