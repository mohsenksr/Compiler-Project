package com.company.lexer;


%%

%line
%column
%unicode
%public
%class Lexer

%{

private Symbol newSymbol(Token token) {
    return new Symbol(token, yyline, yycolumn);
}

private Symbol newSymbol(Token token, Object value) {
    return new Symbol(token, yyline, yycolumn, value);
}

%}

letter              = [A-Za-z]
digit               = [0-9]
alphanumeric        = {letter}|{digit}
other_id_char       = [_]
identifier          = {letter}({alphanumeric}|{other_id_char})*
integer             = {digit}+
real                = (({digit}+\.{digit}+)|({digit}+\.{digit}*)|({digit}*\.{digit}+))
char                = '.'
string_text         = (\\\"|[^\n\r\"]|\\{white_space_char}+\\)*
white_space_char    = [\n\r\ \t\b\f]

LineTerminator      = \r|\n|\r\n
InputCharacter      = [^\r\n]

Comment             = {TraditionalComment} | {EndOfLineComment1} | {EndOfLineComment2}
TraditionalComment  = "<--" [^-] ~"-->" | "<--" "-"+ "->"
EndOfLineComment1   = "//" {InputCharacter}* {LineTerminator}?
EndOfLineComment2   = "--" {InputCharacter}* {LineTerminator}?

%%

true                { return newSymbol(Token.TRUE); }
false               { return newSymbol(Token.FALSE); }

begin               { return newSymbol(Token.BEGIN); }
end                 { return newSymbol(Token.END); }

array               { return newSymbol(Token.ARRAY); }
of                  { return newSymbol(Token.OF); }

if                  { return newSymbol(Token.IF); }
then                { return newSymbol(Token.THEN); }
else                { return newSymbol(Token.ELSE); }

while               { return newSymbol(Token.WHILE); }
do                  { return newSymbol(Token.DO); }
continue            { return newSymbol(Token.CONTINUE); }
break               { return newSymbol(Token.BREAK); }

var                 { return newSymbol(Token.VAR); }

assign              { return newSymbol(Token.ASSIGN); }

function            { return newSymbol(Token.FUNCTION); }
procedure           { return newSymbol(Token.PROCEDURE); }
return              { return newSymbol(Token.RETURN); }

boolean             { return newSymbol(Token.BOOLEAN); }
integer             { return newSymbol(Token.INTEGER); }
real                { return newSymbol(Token.REAL); }
char                { return newSymbol(Token.CHAR); }
string              { return newSymbol(Token.STRING); }

and                 { return newSymbol(Token.LOGICAL_AND); }
or                  { return newSymbol(Token.LOGICAL_OR); }

"+"                 { return newSymbol(Token.PLUS); }
"-"                 { return newSymbol(Token.MINUS); }
"*"                 { return newSymbol(Token.MULTIPLY); }
"/"                 { return newSymbol(Token.DIVIDE); }
"%"                 { return newSymbol(Token.MOD); }
"&"                 { return newSymbol(Token.BITWISE_AND); }
"|"                 { return newSymbol(Token.BITWISE_OR); }
"^"                 { return newSymbol(Token.EXCLUSIVE_ADD); }
"~"                 { return newSymbol(Token.LOGICAL_NOT); }

";"                 { return newSymbol(Token.SEMICOLON); }
","                 { return newSymbol(Token.COMMA); }
":"                 { return newSymbol(Token.COLON); }
":="                { return newSymbol(Token.ASSESSMENT); }
"."                 { return newSymbol(Token.DOT); }

"("                 { return newSymbol(Token.LEFT_PAREN); }
")"                 { return newSymbol(Token.RT_PAREN); }
"["                 { return newSymbol(Token.LEFT_BRACKET); }
"]"                 { return newSymbol(Token.RIGHT_BRACKET); }

"="                 { return newSymbol(Token.EQUAL); }
"<"                 { return newSymbol(Token.LESS_THAN); }
">"                 { return newSymbol(Token.GREATER_THAN); }
"<="                { return newSymbol(Token.LESS_OR_EQUAL); }
">="                { return newSymbol(Token.GREATER_OR_EQUAL); }
"<>"                { return newSymbol(Token.NOT_EQUAL); }

{identifier}        { return newSymbol(Token.IDENTIFY, yytext()); }
{integer}           { return newSymbol(Token.INTLIT, Integer.valueOf(yytext())); }
{real}              { return newSymbol(Token.REALLIT, new Double(yytext())); }
{char}              { return newSymbol(Token.CHARLIT, yytext().charAt(1)); }
\"{string_text}\"   {
    String str = yytext().substring(1, yylength() - 1);
    return newSymbol(Token.STRINGLIT, str);
}

{Comment}           {}

{white_space_char}  {}

.                   { System.out.println("Illegal char, '" + yytext() + "' line: " + yyline + ", column: " + yychar); }
