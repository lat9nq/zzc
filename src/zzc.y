%{
#include <stdio.h>

extern int yylex(void);
void yyerror(char * const);
%}

%token INT
%token FLOAT
%token CHAR
%token LONG
%token SHORT
%token DOUBLE
%token VOID

%token STATIC
%token FINAL
%token CONST
%token TYPEDEF
%token ENUM
%token UNSIGNED
%token SIGNED
%token REGISTER

%token IF
%token ELSE
%token FOR
%token WHILE
%token DO
%token SWITCH
%token CASE
%token BREAK
%token CONTINUE
%token RETURN
%token GOTO

%token C_INCLUDE
%token C_DEFINE
%token C_IFDEF
%token C_IFNDEF
%token C_ELSE
%token C_ENDIF

%token PLUS
%token MINUS
%token STAR
%token SLASH
%token REM
%token OR
%token XOR
%token AMP
%token NOT
%token LSHIFT
%token RSHIFT

%token INC
%token DEC
%token LBRACKET
%token RBRACKET
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token SEMI
%token DOT
%token COMMA
%token COLON
%token QUESTION
%token SIZEOF

%token ASSIGN
%token PLUS_ASSIGN
%token MINUS_ASSIGN
%token STAR_ASSIGN
%token SLASH_ASSIGN
%token REM_ASSIGN
%token LSHIFT_ASSIGN
%token RSHIFT_ASSIGN
%token AMP_ASSIGN
%token OR_ASSIGN
%token XOR_ASSIGN

%token EQ
%token NEQ
%token LEQ
%token GEQ
%token LT
%token GT
%token L_AND
%token L_OR
%token L_NOT

%token STRING_LITERAL
%token CHAR_LITERAL
%token INCLUDE_LITERAL
%token HEX_LITERAL
%token FLOAT_LITERAL
%token DOUBLE_LITERAL
%token NUM_LITERAL

%token <char const *> ID

%type <char const *> method_decl
%type <int> type

%%

method_decl :
	type[t] ID[id] LPAREN RPAREN LBRACKET RBRACKET {
	}
;

type :
	INT {
		$$ = INT;
	}
	| CHAR {
		$$ = CHAR;
	}
	| LONG {
		$$ = LONG;
	}
	| SHORT {
		$$ = SHORT;
	}
	| FLOAT {
		$$ = FLOAT;
	}
	| DOUBLE {
		$$ = DOUBLE;
	}
	| VOID {
		$$ = VOID;
	}
;

%%

void yyerror(char const * s) {
	fprintf(stderr, "%s\n" s);
}

