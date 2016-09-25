LEXER=Src/LexicalAnalysis/
COMMON=Src/Common/
OBJ=Obj/
CC=g++
FLEX=flex++

all: Compiler

Compiler: main.o lexer.o
	$(CC) $(OBJ)main.o $(OBJ)lexer.o -o Compiler

main.o: obj
	$(CC) -c $(COMMON)main.cpp -o $(OBJ)main.o

lexer.o: obj lexer.cpp
	$(CC) -c $(LEXER)lexer.cpp -o$(OBJ)lexer.o

lexer.cpp:
	$(FLEX) -o $(LEXER)lexer.cpp $(LEXER)lexer.l

obj:
	mkdir --parents Obj

clean:
	rm -rf Compiler Obj/
