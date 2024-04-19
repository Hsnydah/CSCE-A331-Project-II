%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "Header.h"
    extern FILE* yyin;
%}

%union{
    struct ast *a;
    double dval;
}

%token<dval> NUM
%left ADD SUB DIV MUL EQ
%token ID SEMICOL COL LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET NL

%type<a> expr
%start trunk

%%
trunk:
    | trunk expr NL              {printf("%4.4g\n", eval($2)); treefree($2);}
;

expr:
    | expr ADD expr         {$$ = newast('+', $1, $3); printf("ADD\n");}
    | expr SUB expr         {$$ = newast('-', $1, $3); printf("SUB\n");}
    | expr MUL expr         {$$ = newast('*', $1, $3); printf("%f * %f = %f MULP\n", $1, $3, $$);}
    | expr DIV expr         {$$ = newast('/', $1, $3); printf("DIV\n");}
    | NUM                   {$$ = newnum($1); printf("NUM: %f = %f\n", $$, $1);}
;
%%

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
    exit(1);
}

int main (int argc, char **argv)
{
    yyin = stdin;

    do {
		yyparse();
	} while(!feof(yyin));

    return 0;
}