%{
#include "compiler.tab.h"
%}

%%

"exit"              {return exit_function;}
"sin"               {return sine;}
"cos"               {return cosine;} 
"tan"               {return tangent;}
[+\-*/=;\(\)^%]     {return yytext[0];}
[0-9]+              {yylval.num = atoi(yytext); return int_number;}
[0-9]+[.][0-9]+     {yylval.num = atof(yytext); return float_number;}
[ \t\n]             ;
[.]+                {yyerror("Mystery character.");}
"pi"                {yylval.num = 3.14159265358979323846; return pi;}

%%

int yywrap (void)   {return 1;}
