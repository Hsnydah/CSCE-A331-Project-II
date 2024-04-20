%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "Header.h"
    extern FILE* yyin;
%}

%union{
    struct ast *a;
    double d;
}

%token          ID SEMICOL COL LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET NL
%token          IF THEN ELIF ELSE WHILE FOR DO LET
%token<d>       NUM
%left           ADD SUB DIV MUL EXCL PIPE
%right          EQ


%type<a> term stmt expr stmt_list factor
%type<d> 
%start function

%%
function:
    | expr NL               {printf("Finished!\n");}
;

expr: term
    | LPAREN expr RPAREN    {$$ = $2;}
    | PIPE expr PIPE        {/*insert absolute value function here*/}
    | expr EXCL             {/*insert factorial function here*/}
    | NUM                   {$$ = newnum($1); printf("NUM: %f = %f\n", $$, $1);}
    | expr PIPE expr        {/*insert or function here*/}
;

term: factor
    | term ADD factor       {$$ = newast('+', $1, $3); printf("ADD\n");}
    | term SUB factor       {$$ = newast('-', $1, $3); printf("SUB\n");}
    | term MUL factor       {$$ = newast('*', $1, $3); printf("%f * %f = %f MULP\n", $1, $3, $$);}
    | term DIV factor       {$$ = newast('/', $1, $3); printf("DIV\n");}
;

factor:
    | ID EQ expr            {/* insert function to assign exprs to ids*/}
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