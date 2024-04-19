%{
    #include <stdio.h>
    #include <std.lib.h>
    extern int yylex();
    extern int yyparse();
    extern FILE* yyin;
%}

%union {
    int ival;
    float fval;
} 

%token<ival> INT
%left ADD SUB DIV MUL EQ
%token SEMICOL COL LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET

%type<ival> expr factor term
%start trunk

%%
trunk:
| trunk expr SEMICOL    {printf("= %i\n", $1);}
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

main (int argc, char **argv)
{
    yyparse();
}

yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
}