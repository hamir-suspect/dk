%{
#include <stdio.h>
#include <stdlib.h>
#include <string>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
char *name;
void yyerror(const char* s);
%}

%start prog
%union{
	char *name;
	int ival;
}

%token PROGRAM
%token PRINT
%token<ival> NUM
%token<name> NAME
%left '-' '+'

%type<ival> EXPRESSION
%type<name> PROG_NAME


%%

prog: PROGRAM PROG_NAME '\n' STATEMENTS	
	;
PROG_NAME: NAME { name = $1; }
		;

STATEMENTS: STATEMENT '\n' STATEMENTS
			|
			;

STATEMENT: EXPRESSION		{;}
		| PRINT EXPRESSION { printf("> %d\n", $2);}
		| PRINT PROGRAM		{ printf("> %s\n", name);}
		;

EXPRESSION: EXPRESSION '+' EXPRESSION { $$= $1+$3;}
		| EXPRESSION '-' EXPRESSION { $$= $1-$3;}
		| NUM 						{ $$=$1;}
		| '(' EXPRESSION ')'		{ $$=$2; }
		;

%%

int main() {
	yyin = stdin;

	do { 
		yyparse();
	} while(!feof(yyin));
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
