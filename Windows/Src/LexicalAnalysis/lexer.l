%option noyywrap

%{
#include <iostream>
#include <cstring>
#define YY_DECL extern "C" int yylex()

struct YYLTYPE {  
  int first_line;  
  int first_column;  
  int last_line;  
  int last_column;  
} yylloc;

static void updateLocation()
{
	static int currLine = 1;
	static int currCol  = 1;

	yylloc.first_line = currLine;
	yylloc.first_column = currCol;

	char * currentSymbol;
	for( currentSymbol = yytext; *currentSymbol != '\0'; ++currentSymbol ) {
		if( *currentSymbol == '\n' ) {
			currLine++;
			currCol = 1;
		} else if( *currentSymbol == '\t' ) {
			currCol += 4;
		} else {
			currCol++;
		}
	}

	yylloc.last_line   = currLine;
	yylloc.last_column = currCol - 1;
}

static void printLocation()
{
	std::cout << yylloc.first_line << ", " << yylloc.first_column << "; ";
	std::cout << yylloc.last_line << ", " << yylloc.last_column;
}

#define YY_USER_ACTION updateLocation();

%}

%%

"{"		{ std::cout << "LBRACE" << "{ "; printLocation(); std::cout << " }"; }
"}"		{ std::cout << "RBRACE" << "{ "; printLocation(); std::cout << " }"; }
"/*"((("*"[^/])?)|[^*])*"*/"	{}
.						{ std::cout << yytext; }

%%
extern int YYText();