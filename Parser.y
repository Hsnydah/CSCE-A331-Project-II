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

%type<ival> expr
%type<fval> flt_expr
%start trunk

%%
trunk: NL
    | expr NL                   {printf("= %i\n", $1);}
    | flt_expr NL               {printf("= %i\n", $1);}
;

expr: INT                       {$$ = $1;}
    | expr ADD expr             {$$ = $1 + $3;}
    | expr SUB expr             {$$ = $1 - $3;}
    | expr MUL expr             {$$ = $1 * $3;}
    | LPAREN expr RPAREN        {$$ = $2;}
;

flt_expr: FLOAT                 {$$ = $1;}
    | expr ADD flt_expr         {$$ = $1 + $3;}
    | expr SUB flt_expr         {$$ = $1 - $3;}
    | expr MUL flt_expr         {$$ = $1 * $3;}
    | expr DIV flt_expr         {$$ = $1 / $3;}
    | flt_expr ADD expr         {$$ = $1 + $3;}
    | flt_expr SUB expr         {$$ = $1 - $3;}
    | flt_expr MUL expr         {$$ = $1 * $3;}
    | flt_expr DIV expr         {$$ = $1 / $3;}
    | flt_expr ADD flt_expr     {$$ = $1 + $3;}
    | flt_expr SUB flt_expr     {$$ = $1 - $3;}
    | flt_expr MUL flt_expr     {$$ = $1 * $3;}
    | flt_expr DIV flt_expr     {$$ = $1 / $3;}
    | expr DIV expr             {$$ = $1 / (float)$3;}
    | LPAREN flt_expr RPAREN    {$$ = $2;}
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