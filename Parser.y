%{
    #include <stdio.h>
    #include <stdlib.h>
    extern int yylex();
    extern int yyparse();
    extern FILE* yyin;
%}

%union {
    int ival;
    float fval;
} 

%token<ival> INT
%token<fval> FLOAT
%left ADD SUB DIV MUL EQ
%token ID SEMICOL COL LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET NL

%type<ival> expr factor term
%start trunk

%%
trunk: NL
| trunk expr NL {printf("= %d\n", $1);}
;

expr: factor
| expr ADD factor       {$$ = $1 + $3;}
| expr SUB factor       {$$ = $1 - $3;}
;

factor: term
| factor MUL term       {$$ = $1 * $3;}
| factor DIV term       {$$ = $1 / $3;}
;

term: INT               {$$ = $1;}
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

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
    exit(1);
}