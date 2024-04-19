%option noyywrap nodefault yylineno

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #include "Header.h"
%}

%%
[ \t]                       ;
\n                          {return NL;}
([\d]+[\.[\d]+]{0,1})       {yylval.dval = atof(yytext); printf("%f\n", yylval.dval); return NUM;}
"+"                          {return ADD;}
"-"                          {return SUB;}
"*"                          {printf("MULT"); return MUL;}
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