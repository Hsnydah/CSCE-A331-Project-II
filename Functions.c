#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include "Header.h"

void yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
    exit(1);
}

struct ast *
newast(int ntype, struct ast *l, struct ast *r)
{
    struct ast *a = malloc(sizeof(struct ast));
    if (!a)
    {
        yyerror("Out of Memory!\n");
        exit(0);
    }
    a->ntype = ntype;
    a->l = l;
    a->r = r;
    return a;
}

struct ast *
newnum(double d)
{
    struct numval *a = malloc(sizeof(struct numval));
    if (!a)
    {
        yyerror("Out of Memory!\n");
        exit(0);
    }
    a->ntype = 'NUM';
    a->num = d;
    return (struct ast *)a;
}

double calc_rslt(struct ast *a)
{
    double temp;
    
    if (!a)
    {
        yyerror("Error: calc_rslt recieved a NULL value.\n");
        return 0.0;
    }

    switch(a->ntype)
    {
        case 'NUM':
            temp = ((struct numval *)a)->num;
            break;
    }
    
    return temp;
}