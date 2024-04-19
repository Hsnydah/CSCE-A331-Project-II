all: Compiler

Parser.tab.c Parser.tab.h: Parser.y
	bison -t -v -d Parser.y

lex.yy.c: Tokens.l Parser.tab.h
	flex Tokens.l

Compiler: lex.yy.c Parser.tab.c Parser.tab.h
	gcc Parser.tab.c lex.yy.c -o Compiler -lm