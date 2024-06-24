unit uFunctions;

interface

uses System.SysUtils, FMX.Edit, Classes, System.MaskUtils, FMX.StdCtrls, uGosEdit, vcl.Printers;


function GetDefaultPrinterName: String;
function DeletaBoletoSalvo(Adir: string): Boolean;

implementation

uses controller.log;

function GetDefaultPrinterName : string;
var
  LLista: TStrings;
begin
   if(Printer.PrinterIndex >= 0)then
     begin
       Result := Printer.Printers[Printer.PrinterIndex];
       Log('Impressora padrao: '+Result);
       Log('Impressora Index: '+inttostr(Printer.PrinterIndex));
     end
   else
     begin
       Result := 'BK-T6112(U) 1'; // 'Nenhuma Impressora Detectada';
       Log('Impressora padrao não localizada, Porém foi setado manualmente');
       Log('Impressora Index: '+inttostr(Printer.PrinterIndex));
     end;
end;

function DeletaBoletoSalvo(Adir: string): Boolean;
var
  SearchRec : TSearchRec;
begin
  try
    try
      if FindFirst(Adir +'\*.pdf', faAnyFile, SearchRec) = 0 then
      begin
        repeat
          DeleteFile(Adir+'\'+ SearchRec.name)
        until FindNext(SearchRec) <> 0;
      end;
    except
      result := false;
    end;

    result := true;
  finally
    FindClose(SearchRec);
  end;
end;
end.
