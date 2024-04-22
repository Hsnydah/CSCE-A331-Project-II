/* C declarations */
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror (char *s)                 {fprintf(stderr, "error: %s\n", s); exit(1);}
int yyparse();
int yylex();
%}

/* yacc definitions */
%union {double num;}
%start function
%token exit_function
%type<num> expr term
%token<num> int_number float_number
%left '+' '-' '*' '/'
%right '='

%%

function: expr '='                      {printf("%f\n", $1);}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {printf("%f\n", $2);}
        | function exit_function ';'    {exit(0);}
;

expr: term                              {$$ = $1;}
    | expr '+' term                     {$$ = $1 + $3;}
    | expr '-' term                     {$$ = $1 - $3;}
    | expr '*' term                     {$$ = $1 * $3;}
    | expr '/' term                     {if ($3 == 0) {yyerror("Cannot divide by 0."); exit(1);} else {$$ = $1 / $3;}}
;

term: int_number                        {$$ = $1;}
    | float_number                      {$$ = $1;}
;

%%

int main() {
    yyparse();
    return 0;
}
