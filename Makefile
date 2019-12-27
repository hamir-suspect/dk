all: prog

prog.tab.c prog.tab.h:	prog.y
	bison -d prog.y

lex.yy.c: prog.l prog.tab.h
	flex prog.l

prog: lex.yy.c prog.tab.c prog.tab.h
	g++ -o prog prog.tab.c lex.yy.c 

clean:
	rm prog prog.tab.c lex.yy.c prog.tab.h
