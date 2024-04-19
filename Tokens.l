%option noyywrap

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #define YY_DECL int yylex()
%}

%%
[ \t]                       ;
\n                          {return NL;}
([\d]+\.[\d]+)|(\.?[\d]+)   {yylval.dval = atoi(yytext); return NUM;}
"+"                         {return ADD;}
"-"                         {return SUB;}
"*"                         {return MUL;}
"/"                         {return DIV;}
"="                         {return EQ;}
":"                         {return COL;}
"("                         {return LPAREN;}
")"                         {return RPAREN;}
"{"                         {return LBRACE;}
"}"                         {return RBRACE;}
"["                         {return LBRACKET;}
"]"                         {return RBRACKET;}
%%