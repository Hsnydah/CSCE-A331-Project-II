/* C declarations */
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

bool is_int(float num)                 {return num == floor(num);}
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

function: expr '='                      {if (is_int($1)) {printf("%d\n", $1);} else {printf("%f\n", $1);}}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {if (is_int($2)) {printf("%d\n", $2);} else {printf("%f\n", $2);}}
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
