/* interface to the lexer */
extern int yylineno; /* from lexer */
void yyerror(char *s);

/* nodes in the abstract syntax tree */
struct ast {
	int ntype;
	struct ast *l;
	struct ast *r;
};

struct numval {
	int ntype;
	double num;
};

struct assign_stmt {
	int ntype;
	char *var_name;
	struct ast *expr;
};

/* build an AST */
struct ast *newast(int ntype, struct ast *l, struct ast *r);
struct ast *newnum(double d);
struct ast *newassign(char *var_name, struct ast *expr);
double calc_rslt(struct ast *);

