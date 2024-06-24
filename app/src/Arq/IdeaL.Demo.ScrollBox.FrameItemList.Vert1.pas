unit IdeaL.Demo.ScrollBox.FrameItemList.Vert1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IdeaL.Lib.View.Fmx.FrameItemListModel, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, System.Skia, FMX.Skia, uGosObjects;

type
  TFilVert1 = class(TFrameItemListModel)
    procedure Button1Tap(Sender: TObject; const Point: TPointF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FilVert1: TFilVert1;

implementation

{$R *.fmx}

procedure TFilVert1.Button1Tap(Sender: TObject; const Point: TPointF);
begin
  inherited;
  ShowMessage('tapped');
end;

end.
