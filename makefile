all: compiler

compiler.tab.c compiler.tab.h: compiler.y
	bison -t -v -d compiler.y

lex.yy.c: compiler_tokens.l compiler.tab.h
	flex compiler_tokens.l

compiler: lex.yy.c compiler.tab.c compiler.tab.h
	gcc compiler.tab.c lex.yy.c -o compiler -lm
