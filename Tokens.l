%option noyywrap yylineno

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #include "Header.h"
%}

%%
([\d]+[\.[\d]+]{0,1})       {yylval.d = atof(yytext); return NUM;}
"+" |
"-" |
"*" |
"/" |
"|" |
"(" |
")" { return yytext[0];}
"="                         {return EQ;}
";"                         {return SEMICOL;}
":"                         {return COL;}
"{"                         {return LBRACE;}
"}"                         {return RBRACE;}
"["                         {return LBRACKET;}
"]"                         {return RBRACKET;}
"!"                         {return EXCL;}
if                          {return IF;}
then                        {return THEN;}
elif                        {return ELIF;}
else                        {return ELSE;}
while                       {return WHILE;}
for                         {return FOR;}
do                          {return DO;}
let                         {return LET;}
\n                          {return NL;}
[ \t]                       {}
[a-zA-Z][a-zA-Z0-9_]*       {return ID;}
[.]+                         {yyerror("Mystery character %c\n");}
%%