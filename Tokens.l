%{
    #include <string>
%}

%%
[ \t\n]                 ;
[a-zA-Z_][a-zA-Z0-9_]*  printf("Identifier\n");
[0-9]+                  printf("Integer\n");
[0-9]+.[0-9]*           printf("Float\n");
%%

main(int argc, char **argv)
{
    yylex();
}