%{
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "myanalyzer.tab.h"
#include "cgen.h"

int line_num = 1;

%}

IDENT [a-zA-Z_][0-9a-zA-Z_]*
DIGIT  [0-9]
NUMBER  {DIGIT}{DIGIT}*
DECIMAL ("."{NUMBER})|({NUMBER}("."{NUMBER}?)?)
REAL    {DECIMAL}([eE][+-]?{NUMBER})?

ESC  ("\\n")|("\\t")|("\\r")|("\\\\")|("\\\"")|("\\\'")
SYMBOL  ("-"|"+"|"*"|"/"|":"|"_"|"$"|"!"|"#"|"@"|"&"|"("~")"|"^"|","|"("|")"|" "|".")
CHAR    ([A-Z]|[a-z]|[0-9]|" "|{SYMBOL})
STRING  ("\"")({CHAR}*{ESC}*{CHAR}*)*("\"")|("\'")({CHAR}*{ESC}*{CHAR}*)*("\'")



%x comment

%%

number    { fprintf(stderr,"Line %d: Token KEYWORD_NUMBER: %s\n", line_num, yytext);  return KW_NUMBER;}
false     { fprintf(stderr,"Line %d: Token KEYWORD_FALSE: %s\n", line_num, yytext);  return KW_FALSE;}
for       { fprintf(stderr,"Line %d: Token KEYWORD_FOR: %s\n", line_num, yytext);  return KW_FOR;}
not       { fprintf(stderr,"Line %d: Token KEYWORD_NOT: %s\n", line_num, yytext);    return KW_NOT;}
start     { fprintf(stderr,"Line %d: Token KEYWORD_START: %s\n", line_num, yytext);  return KW_START;}

boolean   { fprintf(stderr,"Line %d: Token KEYWORD_BOOL: %s\n", line_num, yytext); return TK_BOOL;}
var       { fprintf(stderr,"Line %d: Token KEYWORD_VAR  : %s\n", line_num, yytext);  return KW_VAR;}
while     { fprintf(stderr,"Line %d: Token KEYWORD_WHILE: %s\n", line_num, yytext);  return KW_WHILE;}
and       { fprintf(stderr,"Line %d: Token KEYWORD_AND: %s\n", line_num, yytext);    return KW_AND;}

string    { fprintf(stderr,"Line %d: Token KEYWORD_STRING: %s\n", line_num, yytext); return TK_STRING;}
const     { fprintf(stderr,"Line %d: Token KEYWORD_CONST: %s\n", line_num, yytext);  return KW_CONST;}
function  { fprintf(stderr,"Line %d: Token KEYWORD_FUNCTION: %s\n", line_num, yytext); return KW_FUNCTION;}
or        { fprintf(stderr,"Line %d: Token KEYWORD_OR: %s\n", line_num, yytext);   return KW_OR;}

void      { fprintf(stderr,"Line %d: Token KEYWORD_VOID: %s\n", line_num, yytext);   return KW_VOID;}
if        { fprintf(stderr,"Line %d: Token KEYWORD_IF: %s\n", line_num, yytext);   return KW_IF;}
break     { fprintf(stderr,"Line %d: Token KEYWORD_BREAK: %s\n", line_num, yytext);  return KW_BREAK;}
return    { fprintf(stderr,"Line %d: Token KEYWORD_RETURN: %s\n", line_num, yytext); return KW_RETURN;}

true      { fprintf(stderr,"Line %d: Token KEYWORD_TRUE: %s\n", line_num, yytext); return KW_TRUE;}
else      { fprintf(stderr,"Line %d: Token KEYWORD_ELSE: %s\n", line_num, yytext); return KW_ELSE;}
continue  { fprintf(stderr,"Line %d: Token KEYWORD_CONTINUE: %s\n", line_num, yytext); return KW_CONTINUE;}
null      { fprintf(stderr,"Line %d: Token KEYWORD_NULL: %s\n", line_num, yytext); return KW_NULL;}



"+"     { fprintf(stderr,"Line %d: Token OPERATION_PLUS: %s\n", line_num, yytext); return '+';   }
"-"     { fprintf(stderr,"Line %d: Token OPERATION_MINUS: %s\n", line_num, yytext);  return '-'; }
"*"     { fprintf(stderr,"Line %d: Token OPERATION_MULTI: %s\n", line_num, yytext); return '*';  }
"/"     { fprintf(stderr,"Line %d: Token OPERATION_DIVIDE: %s\n", line_num, yytext);  return '/'; }
"%"     { fprintf(stderr,"Line %d: Token OPERATION_MODULO: %s\n", line_num, yytext);  return '%'; }
"**"    { fprintf(stderr,"Line %d: Token OPERATION_POW: %s\n", line_num, yytext);  return OP_POW; }


"=="    { fprintf(stderr,"Line %d: Token OPERATION_EQUAL: %s\n", line_num, yytext);  return OP_EQ;}
"!="    { fprintf(stderr,"Line %d: Token OPERATION_NOTEQUAL: %s\n", line_num, yytext); return OP_NOTEQUAL;}
"<"     { fprintf(stderr,"Line %d: Token OPERATION_LESS: %s\n", line_num, yytext);   return '<';}
"<="    { fprintf(stderr,"Line %d: Token OPERATION_LESSEQUAL: %s\n", line_num, yytext);   return OP_LESSEQUAL;}

"&&"    { fprintf(stderr,"Line %d: Token OPERATION_AND: %s\n", line_num, yytext);  return OP_AND; }
"||"      { fprintf(stderr,"Line %d: Token OPERATION_OR: %s\n", line_num, yytext);  return OP_OR; }
"!"     { fprintf(stderr,"Line %d: Token OPERATION_NOT: %s\n", line_num, yytext);   return OP_NOT; }
"="     { fprintf(stderr,"Line %d: Token DELIMETER_ASSIGN: %s\n", line_num, yytext);  return ASSIGN ;}

";"     { fprintf(stderr,"Line %d: Token DELIMETER_SEMI: %s\n", line_num, yytext);  return ';'; }
"("     { fprintf(stderr,"Line %d: Token DELIMETER_LBRACKET: %s\n", line_num, yytext);    return '(';}
")"     { fprintf(stderr,"Line %d: Token DELIMETER_RBRACKET: %s\n", line_num, yytext);    return ')';}
","     { fprintf(stderr,"Line %d: Token DELIMETER_COMMA: %s\n", line_num, yytext); return ',';}
"["     { fprintf(stderr,"Line %d: Token DELIMETER_LSQBRACKET: %s\n", line_num, yytext);return '[';}
"]"     { fprintf(stderr,"Line %d: Token DELIMETER_RSQBRACKET: %s\n", line_num, yytext);  return ']';}
"{"     { fprintf(stderr,"Line %d: Token DELIMETER_LCURLY_BRACKET: %s\n", line_num, yytext);  return '{' ;}
"}"     { fprintf(stderr,"Line %d: Token DELIMETER_RCURLY_BRACKET: %s\n", line_num, yytext);  return '}' ;}
":"     { fprintf(stderr,"Line %d: Token DELIMETER_COLON: %s\n", line_num, yytext);  return ':'; }

{IDENT}  	{ fprintf(stderr,"Line %d: Found the IDENTIFIER: %s\n",line_num, yytext);yylval.crepr = strdup(yytext);   return IDENT; }
{REAL}		{ fprintf(stderr,"Line %d: Found the REAL: %s\n",line_num, yytext);yylval.crepr = strdup(yytext);  return REAL; }
{STRING}	{ fprintf(stderr,"Line %d: Found the STRING: %s\n",line_num, yytext); yylval.crepr = strdup(yytext); return STRING; }



"//"[^\n]*    /* eat line comments */

"/*"          BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+"/"        BEGIN(INITIAL);


[ \r\t]			/* skip whitespace */
\n 					 ++line_num;
<<EOF>> 	return EOF;

.           { fprintf(stderr,"Line %d Lexical Error: Unrecognized literal %s\n", line_num, yytext); }


%%

