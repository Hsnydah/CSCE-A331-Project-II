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
%token <d>      NUM
%left           ADD SUB DIV MUL EXCL PIPE
%right          EQ


%type<a> term stmt expr stmt_list factor
%start function

%%
function: /* Do Nothing */
    | expr NL               {printf("= %4.4g\n", calc_rslt($1));}
;

expr: term                  {$$ == $1;}
    | LPAREN expr RPAREN    {$$ = $2;}
    | PIPE expr PIPE        {/*insert absolute value function here*/}
    | expr EXCL             {/*insert factorial function here*/}
    | expr PIPE expr        {/*insert or function here*/}
;

term: factor                {$$ == $1;}
    | term ADD factor       {$$ = newast('+', $1, $3); printf("ADD\n");}
    | term SUB factor       {$$ = newast('-', $1, $3); printf("SUB\n");}
    | term MUL factor       {$$ = newast('*', $1, $3); printf("MULP");}
    | term DIV factor       {$$ = newast('/', $1, $3); printf("DIV\n");}
    | NUM                 {$$ = newnum($1); printf("NUM: = %4.4g\n", $1);}
;

factor: 
    | ID EQ expr            {/* insert function to assign exprs to ids*/}
;
%%

int main (int argc, char **argv)
{
    yyin = stdin;

    do {
		yyparse();
	} while(!feof(yyin));

    return 0;
}