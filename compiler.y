/* C declarations */
%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror (const char *s)           {fprintf(stderr, "error: %s\n", s); exit(1);}
int yyparse();
int yylex();

void print_float(double num);           
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

function: expr '='                      {print_float($1);}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {print_float($2);}
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
    void print_float(double num) {
        num = floor(num * 10 + .5)/10; 
        if (num == (int)num) {
            printf("%d\n", (int)num);
        } 
        else {
            printf("%f\n", (double)num);
        }
    }

    yyparse();
    return 0;
}
