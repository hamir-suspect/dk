%option noyywrap

%{
#include <stdio.h>
#include "prog.tab.h"
%}

number                [0-9]

%%

[ \t]	              ; // ignore all whitespace

%%

