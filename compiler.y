/* C declarations */
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror (const char *s)           {fprintf(stderr, "error: %s\n", s); exit(1);}
int yyparse();
int yylex();

void print_result(double num);           
%}

/* yacc definitions */
%union {double num;}
%start function
%token exit_function
%token sine cosine tangent cosecant secant cotangent
%type<num> expr term
%token<num> int_number float_number pi
%left '+' '-' '*' '/' '^' '%'
%left '(' ')'
%right '='

%%

function: expr '='                      {print_result($1);}
        | exit_function ';'             {exit(0);}
        /* recursive functions allow for multiple inputs*/
        | function expr '='             {print_result($2);}
        | function exit_function ';'    {exit(0);}
;

expr: term                              {$$ = $1;}
    | '-' expr                          {$$ = 0 - $2;}
    | '(' expr ')'                      {$$ = $2;}
    /*simple calculator functions*/
    | expr '+' expr                     {$$ = $1 + $3;}
    | expr '-' expr                     {$$ = $1 - $3;}
    | expr '*' expr                     {$$ = $1 * $3;}
    | expr '/' expr                     {if ($3 == 0) {yyerror("Cannot divide by 0.");} else {$$ = $1 / $3;}}
    | expr '^' expr                     {$$ = pow($1, $3);}
    | expr '%' expr                     {$$ = fmod($1, $3);}
    /*trigonometry functions*/
    | sine '(' expr ')'                 {$$ = sin((double)$3);}
    | cosine '(' expr ')'               {$$ = cos((double)$3);}
    | tangent '(' expr ')'              {$$ = tan((double)$3);}
    | cosecant '(' expr ')'             {$$ = cosec((double)$3);}
    | secant '(' expr ')'               {$$ = sec((double)$3);}
    | cotangent '(' expr ')'            {$$ = cot((double)$3);}
;

term: int_number                        {$$ = $1;}
    | float_number                      {$$ = $1;}
    | pi                                {$$ = $1;}
;

%%

void print_result(double num) {
    if (floor(num) == num) {
        printf("%d\n\n", (int)num);
    }
    else {
        printf("%f\n\n", num);
    }
}

int main() {

    yyparse();
    return 0;
}
