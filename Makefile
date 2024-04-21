all: Compiler

Parser.tab.c Parser.tab.h: Parser.y
	bison -t --debug -v -d Parser.y

lex.yy.c: Tokens.l Parser.tab.h
	flex --debug Tokens.l

Compiler: lex.yy.c Parser.tab.c Parser.tab.h
	gcc Parser.tab.c lex.yy.c Functions.c -o Compiler -lm