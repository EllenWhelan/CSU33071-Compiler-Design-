%{
#  include <stdio.h>
#  include <stdlib.h>
#  include <string.h>
int yylex();
void yyerror(char *s);
int alphaVariables[26];

%}

/* declare tokens */
%token ADD SUB MUL DIV ABS ASSIGN ENDSTATEMEMT PRINT VAR NUM

%%

input:
 | input VAR ASSIGN exp ENDSTATEMEMT {alphaVariables[$2] = $4;}
 | input PRINT VAR ENDSTATEMEMT {printf("%d\n", alphaVariables[$3]);}
;

exp: factor
 | exp ADD factor { $$ = $1 + $3; }
 | exp SUB factor { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: NUM
 | SUB NUM {$$ = ($2*-1);}
 | VAR {$$ = alphaVariables[($1)];}
 ;



%%
int main()
{
  yyparse();
  return 0;
}

void yyerror(char *s)
{
  printf("%s", s);
  exit(0);
}
