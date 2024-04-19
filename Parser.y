%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    
%}

%union{
    double dval;
}

%token<dval> NUM
%left ADD SUB DIV MUL EQ
%token ID SEMICOL COL LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET NL

%type<dval> expr
%start trunk

%%
trunk: NL
    | expr NL              {printf("%f\n", $1);}
;

expr: NUM                   {$$ = $1; printf("NUM: %f = %f\n", $$, $1);}
    | expr ADD expr         {$$ = $1 + $3; printf("ADD\n");}
    | expr SUB expr         {$$ = $1 - $3; printf("SUB\n");}
    | expr MUL expr         {$$ = $1 * $3; printf("%f * %f = %f MULP\n", $1, $3, $$);}
    | expr DIV expr         {$$ = $1 / $3; printf("DIV\n");}
    | LPAREN expr RPAREN    {$$ = $2;}
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