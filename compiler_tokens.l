%{
#include "compiler.tab.h"
%}

%%

"exit"              {return exit_function;}
[+\-*/=;]           {return yytext[0];}
[0-9]+              {yylval.num = atoi(yytext); return int_number;}
[0-9]+[.][0-9]+     {yylval.num = atof(yytext); return float_number;}
[ \t\n]             ;
[.]+                {yyerror("Mystery character.");}

%%
int yywrap (void)   {return 1;}
