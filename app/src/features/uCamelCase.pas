unit uCamelCase;

interface

uses System.SysUtils;

function CamelCase(const s: string): string;

implementation

function CamelCase(const s: string): string;
var t1: integer;
   first: boolean;
begin
   result := AnsiLowerCase(s);
   first := true;
   for t1 := 1 to length(result) do
     if result[t1] = ' ' then begin
       first := true;
     end else
   if first then begin
     result[t1] := UpCase(result[t1]);
     first := false;
   end;

end;

end.
