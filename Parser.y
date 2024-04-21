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

%token          ID SEMICOL COL LBRACE RBRACE LBRACKET RBRACKET NL '(' ')' '|'
%token          IF THEN ELIF ELSE WHILE FOR DO LET
%token <d>      NUM
%left           '+' '-' '*' '/' EXCL
%right          EQ


%type<a> term expr factor //stmt stmt_list
%start function

%%
function: /* Do Nothing */
    | expr NL               {printf("= %4.4g\n", calc_rslt($1));}
;

expr: 
    | '(' expr ')'          {$$ = $2;}
    | '|' expr '|'          {/*insert absolute value function here*/}
    | expr EXCL             {/*insert factorial function here*/}
    | expr '|' expr         {/*insert or function here*/}
    | term                  {printf("expr:term broke\n");}
;

term:
    | term '+' factor      {$$ = newast('+', $1, $3); printf("ADD\n");}
    | term '-' factor       {$$ = newast('-', $1, $3); printf("SUB\n");}
    | term '*' factor       {$$ = newast('*', $1, $3); printf("MULP: %4.4g\n", calc_rlst($3));}
    | term '/' factor       {$$ = newast('/', $1, $3); printf("DIV\n");}
    | factor                {printf("term:factor broke\n");}
;

factor:
    | NUM                   {printf("Num = %f\n", $1); $$ = newnum($1);}
    | ID EQ expr            {/* insert function to assign exprs to ids*/}
;
%%

int main (int argc, char **argv)
{
	yyparse();
    return 0;
}