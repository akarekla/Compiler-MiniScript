%{
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>	
#include <stdbool.h>	
#include "cgen.h"
#include "mslib.h"


extern int yylex(void);
extern int line_num;
extern char* yytext;
%}

%union
{
	char* crepr;
}



%token <crepr> IDENT
%token <crepr> REAL 
%token <crepr> STRING

/*---------------------------------------------------------------------*/
%token KW_NUMBER 
%token KW_FALSE
%token KW_FOR
%token KW_NOT
%token KW_START

%token TK_BOOL
%token KW_VAR
%token KW_WHILE
%token KW_AND

%token TK_STRING
%token KW_CONST
%token KW_FUNCTION
%token KW_OR

%token KW_VOID
%token KW_IF
%token KW_BREAK
%token KW_RETURN

%token KW_TRUE
%token KW_ELSE
%token KW_CONTINUE
%token KW_NULL

%token OP_POW
%token OP_EQ
%token OP_NOTEQUAL
%token OP_LESSEQUAL
%token OP_AND
%token OP_OR
%token OP_NOT
%token ASSIGN

/*---------------------------------------------------------------------*/

%start program

%type <crepr> type_spec
%type <crepr> expr
%type <crepr> argu_list
%type <crepr> func_body
%type <crepr> func_list
%type <crepr> func_decl




%type <crepr> decl_list body decl
%type <crepr> const_decl_id const_decl_body const_decl_init
%type <crepr> const_decl_list

/*---------------------------------------------------------------------*/
%type <crepr> command
%type <crepr> func_call

%type <crepr> for_loop
%type <crepr> command_list
%type <crepr> return_statement
%type <crepr> while_loop
%type <crepr> if_statement
%type <crepr> argu_call
%type <crepr> logic_expr

/*---------------------------------------------------------------------*/
%left '-' '+'
%left '*' '/' '%'
%left '<' OP_LESSEQUAL OP_NOTEQUAL OP_EQ 
%left OP_POW

%left OP_AND OP_OR
%left KW_AND KW_OR
%right OP_NOT KW_NOT


%define parse.error verbose
%debug

%%
/*-----------------------------------PROGRAM----------------------------------*/


program: decl_list func_list KW_FUNCTION KW_START '(' ')' ':' type_spec  '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("%s\n\n", $2);
	  printf("int main() {\t\n%s\n} \n", $10);
	}
}
| decl_list KW_FUNCTION KW_START '(' ')' ':' type_spec  '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\t\n%s\n} \n", $9);
	}
} |
func_list KW_FUNCTION KW_START '(' ')' ':' type_spec  '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\t\n%s\n} \n", $9);
	}
}
| KW_FUNCTION KW_START '(' ')' ':' type_spec  '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("int main() {\t\n%s\n} \n", $8);
	}
};


;
/*DECLARATIONS*/
decl_list: decl_list decl { $$ = template("%s %s\n", $1, $2); }
| decl { $$ = $1; }
;

decl: KW_CONST const_decl_body { $$ = template("const %s", $2); }
| KW_VAR const_decl_body { $$ = template("%s", $2); }
;

const_decl_body: const_decl_list ':' type_spec ';' {  $$ = template("%s %s;", $3, $1); }
| const_decl_list type_spec ';' {  $$ = template("%s* %s;", $2,$1); }
;

const_decl_list: const_decl_list ',' const_decl_init { $$ = template("%s,%s", $1, $3 );}
| const_decl_init { $$ = $1; }
;

const_decl_init: const_decl_id { $$ = $1; }
| const_decl_id ASSIGN expr { $$ = template("%s=%s", $1, $3); }
; 

const_decl_id: IDENT { $$ = $1; } 
| IDENT '['expr']' { $$ = template("%s[%s]", $1,$3); }
| IDENT '['']' { $$ = template("* %s", $1); }
;



/*DATA TYPES*/
type_spec:  KW_NUMBER { $$ = "double"; }
| TK_STRING { $$ = "char*"; }
| TK_BOOL { $$ = "int"; }
| KW_VOID { $$ = "void";}
;


/*FUNCTION*/
func_list: func_decl { $$ = template("%s\n\n",$1); }
| func_decl ';' { $$ = template("%s\n\n",$1); }
| func_list func_decl { $$ = template("%s\n%s\n",$1,$2); }
| func_list func_decl';' { $$ = template("%s\n%s\n",$1,$2); }
;

func_decl: KW_FUNCTION const_decl_id  '(' argu_list ')' ':' type_spec  '{' func_body return_statement ';' '}' {
	$$ = template("%s %s(%s) {\n  %s%s;\n}",  $7,$2,$4,$9,$10); }
|	KW_FUNCTION const_decl_id  '(' argu_list ')' ':' '['']' type_spec  '{' func_body return_statement ';' '}' {
	$$ = template("%s* %s(%s) {\n  %s%s;\n}",  $9,$2,$4,$11,$12); }
| KW_FUNCTION const_decl_id  '(' argu_list ')' ':' type_spec  '{' func_body KW_RETURN ';'  '}' {
	$$ = template("void %s(%s) {\n  %s\n}",  $2,$4,$9); }
|	KW_FUNCTION const_decl_id  '(' argu_list ')' ':' '['']' type_spec  '{' func_body KW_RETURN ';'  '}' {
	$$ = template("void* %s(%s) {\n  %s\n}",  $2,$4,$11); }
| KW_FUNCTION const_decl_id  '(' argu_list ')' ':' type_spec  '{' func_body  '}' {
	$$ = template("void %s(%s) {\n  %s\n}",  $2,$4,$9); }
|	KW_FUNCTION const_decl_id  '(' argu_list ')' ':' '['']' type_spec  '{' func_body  '}' {
	$$ = template("void* %s(%s) {\n  %s\n}",  $2,$4,$11); }
;

argu_list: %empty { $$ = template(""); }
|   const_decl_id ':' type_spec { $$ = template("%s %s", $3, $1); }
|   argu_list ',' const_decl_id ':' type_spec { $$ = template("%s , %s %s", $1, $5,$3); }
;

func_body: body { $$ = template("%s", $1); };
| decl_list { $$ = template("%s", $1); }
| decl_list body { $$ = template("%s %s", $1,$2); }



argu_call: %empty { $$ = template(""); }
|   expr { $$ = template("%s", $1); }
|   argu_call ','  expr { $$ = template("%s,%s",$1,$3); }
;

func_call: IDENT'('argu_call')' { $$ = template("%s(%s)",$1,$3); }
;

/*EXPRESSION*/
expr: REAL { $$ = $1; }
| STRING { $$ = $1; }
| IDENT '['expr']' { $$ = template("%s[%s]", $1,$3); }
| IDENT '['']' { $$ = template("%s", $1); }
| IDENT { $$ = $1; } 
| func_call { $$ = $1; }
| '(' expr ')' { $$ = template("(%s)", $2); }
| expr '+' expr { $$ = template("%s + %s", $1, $3); }
| expr '-' expr { $$ = template("%s - %s", $1, $3); }
| expr '*' expr { $$ = template("%s * %s", $1, $3); }
| expr '/' expr { $$ = template("%s / %s", $1, $3); }
| expr '%' expr { $$ = template("%s %% %s", $1, $3); }
| KW_TRUE { $$ = template("1"); }
| KW_FALSE { $$ = template("0"); }
| KW_NOT expr  { $$ = template("not %s", $2); }
| OP_NOT expr  { $$ = template("!s", $2); }
| '+' expr { $$ = template("+%s",  $2); }
| '-' expr { $$ = template("-%s",  $2); }
| logic_expr { $$ = template("%s",  $1); }
;



logic_expr: expr KW_AND expr { $$ = template("%s && %s", $1, $3); }
| expr KW_OR expr { $$ = template("%s || %s", $1, $3); }
| expr OP_AND expr { $$ = template("%s && %s", $1, $3); }
| expr OP_OR expr { $$ = template("%s || %s", $1, $3); }
| expr OP_EQ expr { $$ = template("%s == %s", $1, $3); }
| expr OP_POW expr { $$ = template("%s *= %s", $1, $3); }
| expr OP_NOTEQUAL expr { $$ = template("%s != %s", $1, $3); }
| expr OP_LESSEQUAL expr { $$ = template("%s <= %s", $1, $3); }
| expr '<' expr { $$ = template("%s < %s", $1, $3); }
;



/*COMMANDS*/

command:  ';' { $$ = template(";\n"); }
| const_decl_id';' { $$ = template("%s;\n",$1); }
| const_decl_id ASSIGN expr ';' { $$ = template("\n%s = %s;", $1, $3); }
| const_decl_id ASSIGN expr { $$ = template("\n%s = %s", $1, $3); }
| const_decl_id '[' expr']' ASSIGN expr ';' { $$ = template("\n%s %s = %s;", $1,$3,$6);}
| func_call ';' { $$ = template("\n  %s;",$1); }
| while_loop { $$ = template("\n%s",$1); }
| if_statement { $$ = template("%s",$1); }
| for_loop { $$ = template("%s",$1); }
| KW_BREAK ';' { $$ = template("\n  break;"); }
| KW_CONTINUE ';' { $$ = template("\n  continue;"); }
;

while_loop: 
KW_WHILE '(' expr ')' '{'body'}'{ $$ = template("while (%s) {%s}", $3,$6); }
| KW_WHILE '(' expr ')' body { $$ = template("while (%s) {%s}", $3,$5); };


return_statement: KW_RETURN expr { $$ = template("\n  return %s",$2); };

for_loop:
KW_FOR '(' command expr ';' command ')' body { $$ = template("\nfor(%s%s;%s)\n  {%s}",$3,$4,$6,$8); }
| KW_FOR '(' command expr ';' command ')' '{' body '}' { $$ = template("\nfor(%s%s;%s)\n  {%s}",$3,$4,$6,$9); }
;


if_statement:
KW_IF '(' expr ')' '{' body '}' { $$ = template("\nif (%s) {%s} ", $3,$6); }
| KW_IF '(' expr ')'  command { $$ = template("\nif (%s) {%s} ", $3,$5); }
|   if_statement KW_ELSE'{' body '}'  { $$ = template("%s \nelse {%s} ", $1,$4); }
|   if_statement  KW_ELSE command { $$ = template("%s \nelse  {%s} ", $1,$3); }
;


command_list: command{ $$ = template("%s", $1); }
| command_list command { $$ = template("%s %s", $1, $2); }
;

body: %empty { $$ = template(""); } 
| decl_list { $$ = template("%s", $1); }
| command_list { $$ = template("%s", $1); }
| decl_list command_list { $$ = template("%s %s", $1,$2); }
;


%%

int main () {
  if ( yyparse() == 0 ){
     printf("/*correct!*/\n");
  }
  else{
    printf("/*rejected!*/\n");
    printf("/* Unrecognized token %s in line %d: ",yytext,line_num);
  }
}