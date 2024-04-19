%option noyywrap

%{
    #include <stdio.h>
    #include "Parser.tab.h"
    #define YY_DECL int yylex()
%}

%%
[ \t]                       ;
\n                          {return NL;}
([\d]+[\.[\d]+]{0,1})      {yylval.dval = atoi(yytext); printf("%f\n", yylval.dval); return NUM;}
"+"                         {return ADD;}
"-"                         {return SUB;}
\*                         {printf("MULT"); return MUL;}
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