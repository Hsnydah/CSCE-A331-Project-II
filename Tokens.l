%option noyywrap nodefault yylineno

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #include "Header.h"
%}

%%
[ \t]
\n                          {return NL;}
[a-zA-Z][a-zA-Z0-9_]*       {return ID;}
([\d]+[\.[\d]+]{0,1})       {yylval.d = atof(yytext); printf("%f\n", yylval.d); return NUM;}
"+"                         {return ADD;}
"-"                         {return SUB;}
"*"                         {printf("MULT"); return MUL;}
"/"                         {return DIV;}
"="                         {return EQ;}
":"                         {return COL;}
"("                         {return LPAREN;}
")"                         {return RPAREN;}
"{"                         {return LBRACE;}
"}"                         {return RBRACE;}
"["                         {return LBRACKET;}
"]"                         {return RBRACKET;}
"!"                         {return EXCL;}
"|"                         {return PIPE;}
if                          {return IF;}
then                        {return THEN;}
elif                        {return ELIF;}
else                        {return ELSE;}
while                       {return WHILE;}
for                         {return FOR;}
do                          {return DO;}
let                         {return LET;}
%%