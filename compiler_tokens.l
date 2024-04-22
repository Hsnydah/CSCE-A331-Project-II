%{
#include "compiler.tab.h"
%}

%%

"exit"              {return exit_function;}
[+\-*/]             {return yytext[0];}
[0-9]+              {yylval.inum = atoi(yytext); return int_number;}
[0-9]+[.][0-9]+     {yylval.fnum = atof(yytext); return float_number;}
[ \t\n]             ;
.                   {yyerror("Mystery character.");}

%%
int yywrap (void)   {return 1;}
