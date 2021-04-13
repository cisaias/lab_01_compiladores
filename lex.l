%{
    int count = 1;
    char *variables[10000];
    int x=1;
    int sw ;
    int indice;
    int errores=0;

%}

  

digit       [0-9]
entero      "-"?({digit})+
decimal     \.{digit}+
imag        "-"?({entero}|{real})(j|J)
real        "-"?{digit}+?{decimal}
exp         "-"?({entero}|{real})(e)({entero}|{real})
long        {entero}(L|l)+
letter      [a-zA-Z]
COMENT      "#".*
Var         "_"?{letter}({letter}|{digit}|"_")* 
caracter    [^\"\’\‘\'\n]
cadena     ((\")({caracter}*)(\"))|((\')({caracter}*)(\'))|((\’|‘)({caracter}*)(\’|‘))
error4      {real}(L|l)+
error       ({entero}|{decimal}){letter}+((l|L|j|J)+)
error2       ({entero}|{decimal})[a-d|A-D|E|e|f-i|F-I|k|K|m-z|M-Z]+
error3       ({imag}|{long}|error4)({letter}|{digit})+ 
espacio     " "
AND         and
ELSE        else
IS          is
RETURN      return
BREAK       break
FOR         for
NOT         not
WHILE       while
CONTINUE    continue
IF          if
OR          or
DEF         def
IMPORT      import
PASS        pass
ELIF        elif
IN          in
PRINT       print
RANGE       range
TRUE        True
FALSE       False



%%
{AND} { fprintf(yyout,"AND ");}
{ELSE} { fprintf(yyout,"ELSE ");}
{IS} { fprintf(yyout,"IS ");}
{RETURN} { fprintf(yyout,"RETURN ");}
{BREAK} { fprintf(yyout,"BREAK ");}
{FOR} { fprintf(yyout,"FOR ");}
{IF} { fprintf(yyout,"IF ");}
{NOT} { fprintf(yyout,"NOT ");}
{WHILE} { fprintf(yyout,"WHILE ");}
{CONTINUE} { fprintf(yyout,"CONTINUE ");}
{OR} { fprintf(yyout,"OR ");}
{DEF} { fprintf(yyout,"DEF ");}
{IMPORT} { fprintf(yyout,"IMPORT ");}
{PASS} { fprintf(yyout,"PASS ");}
{ELIF} { fprintf(yyout,"ELIF ");}
{IN} { fprintf(yyout,"IN ");}
{PRINT} { fprintf(yyout,"PRINT ");}
{RANGE} { fprintf(yyout,"RANGE ");}
{TRUE}  { fprintf(yyout,"TRUE ");}
{FALSE} { fprintf(yyout,"FALSE ");}
{error} {fprintf(yyout,"ERROR=%s ", yytext);errores++;}
{error2} {fprintf(yyout,"ERROR=%s ", yytext);errores++;}
{error3} {fprintf(yyout,"ERROR=%s ", yytext);errores++;}
{error4} {fprintf(yyout,"ERROR=%s ", yytext);errores++;}
{real} { fprintf(yyout,"REAL=%s ", yytext);}
{exp} { fprintf(yyout,"REAL=%s ", yytext);}
{Var} {
    sw = 0;
    variables[count]=malloc(10*sizeof(yytext));
    for (x=1; x < count; x++){
        if(strcmp(yytext,variables[x]) == 0 && sw == 0){
            sw = 1;
            indice = x;
        }
    }  
    if (sw == 1){
         fprintf(yyout,"id%d=%s ",indice,variables[indice]);
    }else{    
        strcpy(variables[count], yytext);
        fprintf(yyout,"id%d=%s ",count,yytext);
        count++;
    }
}
{entero} { fprintf(yyout,"ENTERO=%s ", yytext);}
{imag} { fprintf(yyout,"IMAGINARIO=%s ", yytext);}
{long} { fprintf(yyout,"LONG=%s ", yytext);}
{cadena} { fprintf(yyout,"cadena=%s ", yytext);}
{COMENT} {}



"+" { fprintf(yyout,"suma=%s ", yytext);}
"-" { fprintf(yyout,"menos=%s ", yytext);}
"*" { fprintf(yyout,"mult=%s ", yytext);}
"**" { fprintf(yyout,"exp=%s ", yytext);}
"/" { fprintf(yyout,"div=%s ", yytext);}
"//" { fprintf(yyout,"divEnt=%s ", yytext);}
"%" { fprintf(yyout,"mod=%s ", yytext);}
"<<" { fprintf(yyout,"deslpIzq=%s ", yytext);}
">>" { fprintf(yyout,"despDer=%s ", yytext);}
"&" { fprintf(yyout,"Y=%s ", yytext);}
"|" { fprintf(yyout,"or=%s ", yytext);}
"^" { fprintf(yyout,"elv=%s ", yytext);}
"~" { fprintf(yyout,"virgulilla=%s ", yytext);}
"<" { fprintf(yyout,"menque=%s ", yytext);}
">" { fprintf(yyout,"mayque=%s ", yytext);}
"<=" { fprintf(yyout,"menoigu=%s ", yytext);}
">=" { fprintf(yyout,"mayoigu=%s ", yytext);}
"==" { fprintf(yyout,"comp= %s ", yytext);}
"!=" { fprintf(yyout,"differ=%s ", yytext);}
"<>" { fprintf(yyout,"noesiguala=%s ", yytext);}
"(" { fprintf(yyout,"parabre=%s ", yytext);}
")" { fprintf(yyout,"parcierr=%s ", yytext);}
"[" { fprintf(yyout,"corchabre=%s ", yytext);}
"]" { fprintf(yyout,"corchcierr=%s ", yytext);}
"=" { fprintf(yyout,"asign= %s ", yytext);}
";" { fprintf(yyout,"puntcomma=%s ", yytext);}
"," { fprintf(yyout,"comma=%s ", yytext);}
":" { fprintf(yyout,"dospunt=%s ", yytext);}
"." { fprintf(yyout,"punt=%s ", yytext);}
">>=" { fprintf(yyout,"maymayigu=%s ", yytext);}
"<<=" { fprintf(yyout,"menmenigu=%s ", yytext);}
"+=" { fprintf(yyout,"masigu=%s ", yytext);}
"-=" { fprintf(yyout,"menigu=%s ", yytext);}
"*=" { fprintf(yyout,"astigu=%s ", yytext);}
"/=" { fprintf(yyout,"slashigu=%s ", yytext);}
"&=" { fprintf(yyout,"amperigu=%s ", yytext);}
"|=" { fprintf(yyout,"origu=%s ", yytext);}
"^=" { fprintf(yyout,"cirigu=%s ", yytext);}
"**=" { fprintf(yyout,"astastigu=%s ", yytext);}
"%=" { fprintf(yyout,"porcigu=%s ", yytext);}
{espacio}       { }
[\n] {fprintf(yyout,"\n");}
[\t] {fprintf(yyout,"\t");}
.    {fprintf(yyout,"ERROR ");errores++;}

%%
int main(){
    FILE *f1, *f2;
    f1=fopen("code.py","r");
    f2=fopen("Output.txt", "w");
    yyin=f1;
    yyout=f2;
    yylex();
    fprintf(yyout,"\n%d Identificadores\n",count-1);
    for( int x = 1; x < count ; x++){
      fprintf(yyout,"id%d=%s \n",x,variables[x]);
    }
    fprintf(yyout, "\n%d Errores\n",errores);

    return 1;
}

int yywrap(){
    return 1;
}
