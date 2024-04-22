/* C declarations */
%{
void yyerror (char *s)
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yyparse();
int yylex();
%}

/* yacc definitions */
%union {int inum; float fnum;}
%start function
%token exit
%type<inum> expr term
%token<inum> int_number
%token<fnum> float_number
%left '+' '-' '*' '/'
%right '='

%%

function: expr '='                      {printf("%d\n", $1)}
        | exit ';'                      {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {printf("%d\n", $2)}
        | function exit ';'             {exit(0);}
;

expr: term                              {$$ = $1;}
    | expr '+' term                     {$$ = $1 + $2}
    | expr '-' term                     {$$ = $1 - $2}
    | expr '*' term                     {$$ = $1 * $2}
    | expr '/' term                     {if ($3 == 0) {yyerror ("Cannot divide by 0."); exit(0);} else $$ = $1 + $2}
;

term: int_number                        {$$ = $1}
    | float_number                      {$$ = $1}
;

%%

int main() {
    yyparse();
    return();
}