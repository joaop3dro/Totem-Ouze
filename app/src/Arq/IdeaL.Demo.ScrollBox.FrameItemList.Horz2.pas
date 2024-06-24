unit IdeaL.Demo.ScrollBox.FrameItemList.Horz2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  IdeaL.Lib.View.Fmx.FrameItemListModel, FMX.Controls.Presentation, FMX.Objects,
  FMX.Layouts, System.Skia, FMX.Skia, uGosObjects;

type
  TFilHorz2 = class(TFrameItemListModel)
    skloading: TSkAnimatedImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FilHorz2: TFilHorz2;

implementation

{$R *.fmx}

end.
