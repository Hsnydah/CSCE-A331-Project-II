%{
%}

%%
[ ]                     ;
[\n]                    printf("\n");
[a-zA-Z_][a-zA-Z0-9_]*  printf("ID");
[0-9]+                  printf("INT");
[0-9]+"."[0-9]*         printf("FLOAT");
"+"                     printf("PLUS");
"-"                     printf("MINUS");
"*"                     printf("TIMES");
"/"                     printf("DIVIDE");
"="                     printf("EQUALS");
";"                     printf("END");
"("                     printf("LPAREN");
")"                     printf("RPAREN");
"{"                     printf("LBRACE");
"}"                     printf("RBRACE");
"["                     printf("LBRACKET");
"]"                     printf("RBRACKET");
%%

int main(int argc, char **argv)
{
    yylex();
    return 0;
}