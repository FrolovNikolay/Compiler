%option noyywrap
%option c++

%{
#include <iostream>
#include <cstring>
%}

%%

"{"		{ std::cout << "LBRACE" << "{ "; std::cout << " }"; }
"}"		{ std::cout << "RBRACE" << "{ "; std::cout << " }"; }
"/*"((("*"[^/])?)|[^*])*"*/"	{}
.		{ std::cout << yytext; }

%%
