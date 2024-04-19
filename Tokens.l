%option noyywrap

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #define YY_DECL int yylex()
%}

%%
[ \t]                       ;
\n                          {return NL;}
[0-9]+                      {yylval.ival = atoi(yytext); return INT;}
"."                         {return PER;}
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