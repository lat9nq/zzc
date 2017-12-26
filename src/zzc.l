A	[a-zA-Z]
D	[0-9]
Hl	[0-9a-f]
H	{Hl}
Hu	[0-9A-F]
O	[0-7]
S	([!-/:-@[-`{-~]|" ")
E	("\\"([abfnrtv]|"\\"|"\'"|"\""|"?"|{O}{O}{O}|"x"{H}*|"U"{H}{H}{H}{H}{H}{H}{H}{H}|"u"{H}{H}{H}{H}))
C	([!#$%&*+,./;:<>=?@_`{}~]|"["|"]"|"^"|"|"|"-"|"("|")"|"'")
W	[ \n\r\t]

%{
#include <stdio.h>
#include "zzc.tab.h"

#define	MULTILINE	1
#define	SINGLELINE	0

void comment(int mode);
%}

%%

"int"	{ return INT; }
"char"	{ return CHAR; }
"long"	{ return LONG; }
"short"	{ return SHORT; }
"float"	{ return FLOAT; }
"double"	{ return DOUBLE; }
"void"	{ return VOID; }

"static"	{ return STATIC; }
"final"	{ return FINAL; }
"const"	{ return CONST; }
"typedef"	{ return TYPEDEF; }
"enum"	{ return ENUM; }
"unsigned"	{ return UNSIGNED; }
"signed"	{ return SIGNED; }
"register"	{ return REGISTER; }

"if"	{ return IF; }
"else"	{ return ELSE; }
"for"	{ return FOR; }
"while"	{ return WHILE; }
"do"	{ return DO; }
"case"	{ return CASE; }
"switch"	{ return SWITCH; }
"break"	{ return BREAK; }
"continue"	{ return CONTINUE; }
"return"	{ return RETURN; }
"goto"	{ return GOTO; }

"#include"	{ return C_INCLUDE; }
"#define"	{ return C_DEFINE; }
"#ifdef"	{ return C_IFDEF; }
"#ifndef"	{ return C_IFNDEF; }
"#else"	{ return C_ELSE; }
"#endif"	{ return C_ENDIF; }

"+"	{ return PLUS; }
"-"	{ return MINUS; }
"*"	{ return STAR; }
"/"	{ return SLASH; }
"%"	{ return REM; }
"|"	{ return OR; }
"^"	{ return XOR; }
"~"	{ return NOT; }
"&"	{ return AMP; }
"<<"	{ return LSHIFT; }
">>"	{ return RSHIFT; }

"++"	{ return INC; }
"--"	{ return DEC; }
"["	{ return LBRACKET; }
"]"	{ return RBRACKET; }
"("	{ return LPAREN; }
")"	{ return RPAREN; }
"{"	{ return LBRACE; }
"}"	{ return RBRACE; }
";"	{ return SEMI; }
"."	{ return DOT; }
","	{ return COMMA; }
":"	{ return COLON; }
"?"	{ return QUESTION; }
"sizeof"	{ return SIZEOF; }

"="	{ return ASSIGN; }
"+="	{ return PLUS_ASSIGN; }
"-="	{ return MINUS_ASSIGN; }
"*="	{ return STAR_ASSIGN; }
"/="	{ return SLASH_ASSIGN; }
"%="	{ return REM_ASSIGN; }
"<<="	{ return LSHIFT_ASSIGN; }
">>="	{ return RSHIFT_ASSIGN; }
"&="	{ return AMP_ASSIGN; }
"|="	{ return OR_ASSIGN; }
"^="	{ return XOR_ASSIGN; }

"=="	{ return EQ; }
"!="	{ return NEQ; }
"<="	{ return LEQ; }
">="	{ return GEQ; }
"<"	{ return LT; }
">"	{ return GT; }
"&&"	{ return L_AND; }
"||"	{ return L_OR; }
"!"	{ return L_NOT; }

"\""(" "|{A}|{E}|{C}|{D})*"\""	{ return STRING_LITERAL; }
"\'"(" "|{A}|{E}|{C}|{D})"\'"	{ return CHAR_LITERAL; }
"<"(" "|{A}|{C}|{D})*">"	{ return INCLUDE_LITERAL; }
"0x"{Hu}*	{ return HEX_LITERAL; }
"0x"{Hl}*	{ return HEX_LITERAL; }
{D}"."{D}+	{ return DOUBLE_LITERAL; }
{D}"."{D}+f	{ return FLOAT_LITERAL; }
{D}*	{ return NUM_LITERAL; }

"/*"	{ comment(MULTILINE); }
"//"	{ comment(SINGLELINE); }

({A}|"_")({A}|"_"|{D})*	{ return ID; }
[\n\t\r ]	{ /* */ }
.	{ printf("error: \"%s\" wasn't recognized\n", yytext); }

%%

void comment(int mode) {
	if (mode == MULTILINE) {
		int star = 0;
		char c;
		while (c = input()) {
			if ((c == '/') && star) {
				break;
			}
			star = (c == '*');
		}
	}
	else if (mode == SINGLELINE) {
		char c;
		while (c = input()) {
			if (c == '\n') {
				break;
			}
		}
	}
}

