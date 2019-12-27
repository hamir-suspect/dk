%option noyywrap

%{
#include <stdio.h>
#include "prog.tab.h"
#define YY_DECL int yylex()

%}

number                [0-9]
letter  [a-zA-Z]

%%

[ \t]	              ; // ignore all whitespace
print   { return PRINT; }
[pP]rogram      { return PROGRAM; }
{number}+   { yylval.ival= atoi(yytext); return NUM; }
[+()\n-]    { return *yytext; }
{letter}+   { yylval.name = yytext; return NAME; }

%%

