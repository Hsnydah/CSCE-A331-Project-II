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
/* build an AST */
struct ast *newast(int ntype, struct ast *l, struct ast *r);
struct ast *newnum(double d);
double calc_rslt(struct ast *);