unit uFormataCampos;
  //Criada por João Pedro
interface

uses
   System.SysUtils, System.MaskUtils;

  function FormataCPF(Atexto: string): string;
  function FormataCNPJ(Atexto: string): string;
  function FormataTelefone(Atexto: string): string;
  function FormataCelular(Atexto: string): string;
  function FormataCEP(Atexto: string): string;
  function FormataCPF2(Atexto: string): string;
  function FormataParcela(Atexto: string): string;
  function FormataNome(Atexto: string): string;
  function StrToCardinal(const S : String) : Cardinal;

implementation


function FormataCPF(Atexto: string): string;
begin
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('/', Atexto), 1);
  Result := FormatmaskText('000\.000\.000\-00;0;', Atexto);
end;

function FormataCPF2(Atexto: string): string;
begin
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos(' ', Atexto), 1);
  Result := FormatmaskText('000\ 000\ 000\ 00;0;', Atexto);
end;

function FormataCNPJ(Atexto: string): string;
begin
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('/', Atexto), 1);
  Result := FormatmaskText('00\.000\.000\/0000\-00;0;', Atexto);
end;

function FormataTelefone(Atexto: string): string;
begin
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('(', Atexto), 1);
  Delete(Atexto, ansipos(')', Atexto), 1);
  Result := FormatmaskText('\(00\)0000\-0000;0;', Atexto);
end;

function FormataCelular(Atexto: string): string;
begin
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('(', Atexto), 1);
  Delete(Atexto, ansipos(')', Atexto), 1);
  Result := FormatmaskText('\(00\)00000\-0000;0;', Atexto);
end;

function FormataCEP(Atexto: string): string;
begin
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('.', Atexto), 1);
  Delete(Atexto, ansipos('-', Atexto), 1);
  Delete(Atexto, ansipos('/', Atexto), 1);
  Result := FormatmaskText('00000\-000;0;', Atexto);
end;

function FormataParcela(Atexto: string): string;
var
 Ltexto : string;
 LtextoCount : integer;
begin
  LtextoCount := length(copy(Atexto,1,Pos('/',Atexto)));
  if LtextoCount = 2 then
   Ltexto := '0'+copy(Atexto,1,Pos('/',Atexto))
  else
   Ltexto := copy(Atexto,1,Pos('/',Atexto));

  if length(copy(Atexto,Pos('/',Atexto),length(Atexto))) = 2 then
   Ltexto := Ltexto+'0'+copy(Atexto,Pos('/',Atexto)+1,length(Atexto))
  else
   Ltexto := Ltexto+copy(Atexto,Pos('/',Atexto)+1,length(Atexto));

  Result := Ltexto;
end;

function FormataNome(Atexto: String): string;
const
  excecao: array[0..5] of string = ('da', 'de', 'do', 'das','dos', 'e');
var
  tamanho, j: integer;
  i: byte;
begin
  Result := AnsiLowerCase(Atexto);
  tamanho := Length(Result);

  for j := 1 to tamanho do
    // Se é a primeira letra ou se o caracter anterior é um espaço
    if (j = 1) or ((j>1) and (Result[j-1]=Chr(32))) then
      Result[j] := AnsiUpperCase(Result[j])[1];
  for i := 0 to Length(excecao)-1 do
    result:= StringReplace(result,excecao[i],excecao[i],[rfReplaceAll, rfIgnoreCase]);
end;

function StrToCardinal(const S : String) : Cardinal;
var
    I64 : UInt64;
begin
    I64 := StrToUInt64(S);
    if (I64 shr 32) <> 0 then
        raise EConvertError.Create('StrToCardinal invalid value');
    Result := Cardinal(I64);
end;

end.
