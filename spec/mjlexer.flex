package rs.ac.bg.etf.rm130666d;

import java_cup.runtime.Symbol;

%%

%{

	// ukljucivanje informacije o poziciji tokena, klasa Symbol se nalazi u java_cup paketu
	private Symbol new_symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn);
	}
	
	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type, Object value) {
		return new Symbol(type, yyline+1, yycolumn, value);
	}

%}

%cup
%line
%column

%xstate COMMENT

%eofval{
	return new_symbol(sym.EOF);
%eofval}

%%

" " 	{ }
"\b" 	{ }
"\t" 	{ }
"\r\n" 	{ }
"\f" 	{ }

"program"   { return new_symbol(sym.PROGRAM, yytext()); }
"break"   { return new_symbol(sym.BREAK, yytext()); }
"class"   { return new_symbol(sym.CLASS, yytext()); }
"else"   { return new_symbol(sym.ELSE, yytext()); }
"const"   { return new_symbol(sym.CONST, yytext()); }
"if"   { return new_symbol(sym.IF, yytext()); }
"new"   { return new_symbol(sym.NEW, yytext()); }
"print"   { return new_symbol(sym.PRINT, yytext()); }
"read"   { return new_symbol(sym.READ, yytext()); }
"return"   { return new_symbol(sym.RETURN, yytext()); }
"void"   { return new_symbol(sym.VOID, yytext()); }
"for"   { return new_symbol(sym.FOR, yytext()); }
"extends"   { return new_symbol(sym.EXTENDS, yytext()); }
"continue"   { return new_symbol(sym.CONTINUE, yytext()); }
"static"   { return new_symbol(sym.STATIC, yytext()); }

"+" 		{ return new_symbol(sym.PLUS, yytext()); }
"-" 		{ return new_symbol(sym.MINUS, yytext()); }
"*" 		{ return new_symbol(sym.MUL, yytext()); }
"/" 		{ return new_symbol(sym.DIV, yytext()); }
"%" 		{ return new_symbol(sym.MOD, yytext()); }
"==" 		{ return new_symbol(sym.EQ, yytext()); }
"!=" 		{ return new_symbol(sym.NEQ, yytext()); }
">" 		{ return new_symbol(sym.GRE, yytext()); }
">=" 		{ return new_symbol(sym.GREQ, yytext()); }
"<" 		{ return new_symbol(sym.LESS, yytext()); }
"<=" 		{ return new_symbol(sym.LEQ, yytext()); }
"&&" 		{ return new_symbol(sym.AND, yytext()); }
"||" 		{ return new_symbol(sym.OR, yytext()); }
"=" 		{ return new_symbol(sym.EQUALS, yytext()); }
"+=" 		{ return new_symbol(sym.ADDEQ, yytext()); }
"-=" 		{ return new_symbol(sym.SUBEQ, yytext()); }
"*=" 		{ return new_symbol(sym.MULEQ, yytext()); }
"/=" 		{ return new_symbol(sym.DIVEQ, yytext()); }
"%=" 		{ return new_symbol(sym.MODEQ, yytext()); }
"++" 		{ return new_symbol(sym.INC, yytext()); }
"--" 		{ return new_symbol(sym.DEC, yytext()); }
";" 		{ return new_symbol(sym.SEMI, yytext()); }
"," 		{ return new_symbol(sym.COMMA, yytext()); }
"(" 		{ return new_symbol(sym.LPAREN, yytext()); }
")" 		{ return new_symbol(sym.RPAREN, yytext()); }
"[" 		{ return new_symbol(sym.LBRACKET, yytext()); }
"]" 		{ return new_symbol(sym.RBRACKET, yytext()); }
"{" 		{ return new_symbol(sym.LBRACE, yytext()); }
"}" 		{ return new_symbol(sym.RBRACE, yytext()); }

"//" 		     { yybegin(COMMENT); }
<COMMENT> .      { yybegin(COMMENT); }
<COMMENT> "\r\n" { yybegin(YYINITIAL); }

[0-9]+  { return new_symbol(sym.NUMCONST, new Integer (yytext())); }
"true" | "false" { return new_symbol(sym.BOOLCONST, new Boolean(yytext())); }
"'"[\040-\176]"'" {return new_symbol (sym.CHARCONST, new Character (yytext().charAt(1)));}
([a-z]|[A-Z])[a-z|A-Z|0-9|_]* 	{return new_symbol (sym.IDENT, yytext()); }

. { log.error("Lexical error (" + yytext() + ") na liniji " + (yyline + 1) + ", kolona " + (yycolumn + 1)); }