{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "Header.h"

void yyerror(char *s);
struct ast *newast(int ntype, struct ast *l, struct ast *r);
struct ast *newnum(double d);
struct ast *newassign(char *var_name, struct ast *expr);
double calc_rslt(struct ast *);

extern int yylineno;
extern int yylex();
%}

%union {
	struct ast *a;
	double d;
}

%token ID SEMICOL COL LBRACE RBRACE LBRACKET RBRACKET NL '(' ')' '|'
%token IF THEN ELIF ELSE WHILE FOR DO LET NUM
%left '+' '-'
%left '*' '/'
%right EXCL
%right EQ

%type <a> expr term factor

%start function

%%

function:
	/* Do Nothing */

| expr NL { printf("= %4.4g\n", calc_rslt($1)); }
	;

expr:
	| term  { $$ = $1; }
	| ID EQ expr { $$ = newassign($1, $3); }
	| expr '+' term { $$ = newast('+', $1, $3); }
	| expr '-' term { $$ = newast('-', $1, $3); }
	;

term:
	| factor { $$ = $1; }
	| term '*' factor { $$ = newast('*', $1, $3); }
	| term '/' factor { $$ = newast('/', $1, $3); }
	;

factor:
	| NUM   { $$ = newnum(yylval.d); }
	| '|' expr '|'  { /* insert absolute value function here */ }
	| expr EXCL 	{ /* insert factorial function here */ }
	| '(' expr ')'  { $$ = $2; }
	;

%%

void yyerror(char *s) {
	fprintf(stderr, "error: %s\n", s);
	exit(1);
}

int main(int argc, char **argv) {
	yyparse();
	return 0;
}

