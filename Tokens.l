%option noyywrap

%{
    #include <stdio.h>
    #define YY_DECL int yylex()
    #include "Parser.tab.h"
%}

%%
[ \t]                   ;
\n                      {return NL;}
[a-zA-Z_][a-zA-Z0-9_]*  {return ID;}
[0-9]+                  {return INT;}
[0-9]+"."[0-9]*         {return FLOAT;}
"+"                     {return ADD;}
"-"                     {return SUB;}
"*"                     {return MUL;}
"/"                     {return DIV;}
"="                     {return EQ;}
";"                     {return SEMICOL;}
":"                     {return COL;}
"("                     {return LPAREN;}
")"                     {return RPAREN;}
"{"                     {return LBRACE;}
"}"                     {return RBRACE;}
"["                     {return LBRACKET;}
"]"                     {return RBRACKET;}
%%