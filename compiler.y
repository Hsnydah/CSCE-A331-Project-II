/* C declarations */
%{
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>

void yyerror (string s)                 {std::cout << "error: " << s << std::endl; exit(1);}
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

function: expr '='                      {std::cout << $1 << std::endl;}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {std::cout << $2 << std::endl;}
        | function exit_function ';'    {exit(0);}
;

expr: term                              {$$ = $1;}
    | expr '+' term                     {$$ = $1 + $3;}
    | expr '-' term                     {$$ = $1 - $3;}
    | expr '*' term                     {$$ = $1 * $3;}
    | expr '/' term                     {if ($3 == 0) {yyerror("Cannot divide by 0.");} else {$$ = $1 / $3;}}
;

term: int_number                        {$$ = $1;}
    | float_number                      {$$ = $1;}
;

%%

int main() {
    yyparse();
    return 0;
}
