%{
open Ast
%}

%token <int> INT 
%token <string> VAR
%token LAM PLUS MINUS TIMES
  DOT LET EQ IN IF THEN ELSE 
  EOF TRUE FALSE NOT

%start <_ Ast.expr> program

%%

e : INT                   { Int $1 }
  | e PLUS e              { Plus ($1, $3) }
  | TRUE                  { Bool true }
  | FALSE                 { Bool false }
  | e EQ e                { Eq ($1, $3) }
  | NOT e                 { Not $2 }
  | LAM VAR DOT e         { Lam ($2, $4) }
  | e e                   { App ($1, $2) }
  | LET VAR EQ e IN e     { Let ($2, $4, $6) }
  | IF e THEN e ELSE e    { If ($2, $4, $6) }

program : e EOF           { $1 }
