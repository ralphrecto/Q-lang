%{
open Ast
%}

%token <int> INT 
%token <string> VAR
%token LAM PLUS MINUS TIMES
  DOT LET EQ IN IF THEN ELSE 
  EOF TRUE FALSE NOT
%start <Ast.expr> program

%%

ae : INT                  { Int $1 }
   | ae PLUS ae         { Plus ($1, $3) }
   | ae MINUS ae        { Minus ($1, $3) }
   | ae TIMES ae        { Times ($1, $3) }

be : TRUE                 { True }
   | FALSE                { False }
   | ae EQ ae             { Eq ($1, $3) }
   | NOT be               { Not $2 }

e : ae                    { AExpr $1 }
  | LAM VAR DOT e         { Lam ($2, $4) }
  | e e                   { App ($1, $2) }
  | LET VAR EQ e IN e     { Let ($2, $4, $6) }
  | IF be THEN e ELSE e   { If ($2, $4, $6) }

program : e EOF           { $1 }
