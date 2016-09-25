%option noyywrap
%option c++

%{
#include <iostream>
#include <cstring>

struct YYLTYPE {  
  int first_line;  
  int first_column;  
  int last_line;  
  int last_column;  
} yylloc;

static void updateLocation( char* yytext )
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
	yylloc.last_column = currCol;
}

static void printLocation()
{
	std::cout << "{ ";
	std::cout << yylloc.first_line << ", " << yylloc.first_column << "; ";
	std::cout << yylloc.last_line << ", " << yylloc.last_column;
	std::cout << " }";
}

%}

%%

"{"		{ updateLocation( yytext ); std::cout << "LBRACE"; printLocation(); }
"}"		{ updateLocation( yytext ); std::cout << "RBRACE"; printLocation(); }
"/*"((("*"[^/])?)|[^*])*"*/"	{ updateLocation( yytext ); }
"\n" { updateLocation( yytext ); std::cout << yytext; }
.		{ updateLocation( yytext ); std::cout << yytext; }

%%
