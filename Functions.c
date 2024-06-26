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
    a->ntype = 'K';
    a->num = d;
    printf("%4.4g\n", d);
    return (struct ast *)a;
}

double calc_rslt(struct ast *a)
{
    double rslt;
    
    if (!a)
    {
        yyerror("calc_rslt recieved a NULL value.\n");
        return 0.0;
    }

    switch(a->ntype)
    {
        case 'K':
            rslt = ((struct numval *)a)->num;
            //printf("Num Val: %4.4g\n", ((struct numval *)a)->num);
            break;
        case '+':
            rslt = calc_rslt(a->l) + calc_rslt(a->r);
            break;
        case '-':
            rslt = calc_rslt(a->l) - calc_rslt(a->r);
            break;
        case '*':
            rslt = calc_rslt(a->l) * calc_rslt(a->r);
            //printf("Left: %4.4g Right: %4.4g\n", calc_rslt(a->l), calc_rslt(a->r));
            break;
        case '/':
            rslt = calc_rslt(a->l) / calc_rslt(a->r);
            break;
    }
    
    return rslt;
}