unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  System.ImageList, Vcl.ImgList;

type
  TFrmLogin = class(TForm)
    pnlMain: TPanel;
    imgAvatar: TImage;
    imgListAvatar: TImageList;
    procedure FormShow(Sender: TObject);
  private
    FestadoAvatar: Integer;
  public
    property estadoAvatar: Integer read FestadoAvatar write FestadoAvatar;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  estadoAvatar := 0;
end;

end.
