%option noyywrap

%{
    #include <stdio.h>
    #define YY_DECL int yylex()
    #include "Parser.tab.h"
%}

%%
[ \t]                       ;
\n                          {return NL;}
([0-9]*\.[0-9]+|[0-9]+\.)   {yylval.float = atoi(yytext); printf("%f\n", yylval.float); return FLOAT;}
[0-9]+                      {yylval.int = atoi(yytext); return INT;}
"+"                         {return ADD;}
"-"                         {return SUB;}
"*"                         {return MUL;}
"/"                         {return DIV;}
"="                         {return EQ;}
";"                         {return SEMICOL;}
":"                         {return COL;}
"("                         {return LPAREN;}
")"                         {return RPAREN;}
"{"                         {return LBRACE;}
"}"                         {return RBRACE;}
"["                         {return LBRACKET;}
"]"                         {return RBRACKET;}
%%