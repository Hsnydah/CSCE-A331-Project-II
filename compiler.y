/* C declarations */
%{
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror (char *s)                 {fprintf(stderr, "error: %s\n", s); exit(1);}
int yyparse();
int yylex();
%}

/* yacc definitions */
%union {int inum; float fnum;}
%start function
%token exit_function
%type<inum> expr term
%token<inum> int_number
%token<fnum> float_number
%left '+' '-' '*' '/'
%right '='

%%

function: expr '='                      {using namespace std; cout << $1 << endl;}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {using namespace std; cout << $2 << endl;}
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
