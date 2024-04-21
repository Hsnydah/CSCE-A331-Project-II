%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "Header.h"
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


%type<a> term expr factor //stmt stmt_list
%start function

%%
function: /* Do Nothing */
    | expr NL               {printf("= %4.4g\n", calc_rslt($1));}
;

expr: term                  {printf("expr:term broke\n");}
    | '(' expr ')'    {$$ = $2;}
    | '|' expr '|'        {/*insert absolute value function here*/}
    | expr EXCL             {/*insert factorial function here*/}
    | expr '|' expr        {/*insert or function here*/}
;

term: factor                {printf("term:factor broke\n");}
    | term '+' factor      {$$ = newast('+', $1, $3); printf("ADD\n");}
    | term '-' factor       {$$ = newast('-', $1, $3); printf("SUB\n");}
    | term '*' factor       {$$ = newast('*', $1, $3); printf("MULP");}
    | term '/' factor       {$$ = newast('/', $1, $3); printf("DIV\n");}
;

factor:                     //{printf("factor broke\n");}
    | NUM            {printf("%f", $2); $$ = newnum($2);}
    | ID EQ expr            {/* insert function to assign exprs to ids*/}
;
%%

int main (int argc, char **argv)
{
	yyparse();
    return 0;
}