%{
open Ast
%}

%token <int> INT 
%token <string> VAR
%token LAM PLUS MINUS TIMES
  DOT LET EQ IN IF THEN ELSE 
  EOF TRUE FALSE NOT LPARENS
  RPARENS
%start <Ast.expr> program

%%

be : TRUE                 { Bool true }
   | FALSE                { Bool false }
   | e EQ e               { Eq ($1, $3) }
   | NOT be               { Not $2 }

e1 : INT                   { Int $1 }
  | e PLUS e              { Plus ($1, $3) }
  | e MINUS e              { Minus ($1, $3) }
  | LAM VAR DOT e         { Lam ($2, $4) }
  | e e                   { App ($1, $2) }
  | LET VAR EQ e IN e     { Let ($2, $4, $6) }
  | IF be THEN e ELSE e   { If ($2, $4, $6) }
  | VAR                   { Var $1 }

e : LPARENS e1 RPARENS    { $2 }
  | e1                    { $1 }

program : e EOF           { $1 }
