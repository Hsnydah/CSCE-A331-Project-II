%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    extern int yylex();
    extern int yyparse();
    extern FILE* yyin;
    
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
    | expr NL               {printf("%f\n", $1);}
;

expr: 
    | expr ADD expr         {$$ = $1 + $3; printf("ADD\n");}
    | expr SUB expr         {$$ = $1 - $3; printf("SUB\n");}
    | expr MUL expr         {$$ = $1 * $3; printf("MUL\n");}
    | expr DIV expr         {$$ = $1 / $3; printf("DIV\n");}
    | NUM                   {$$ = $1; printf("NUM\n");}
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