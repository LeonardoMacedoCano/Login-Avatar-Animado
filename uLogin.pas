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
    procedure carregarImagemAvatar(index: Integer);
  private
    FestadoLogin: String;
  public
    property estadoLogin: String read FestadoLogin write FestadoLogin;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.carregarImagemAvatar(index: Integer);
begin
  imgAvatar.Canvas.Pen.Style := psClear;
  imgAvatar.Canvas.Rectangle(0, 0, imgAvatar.Width + 1, imgAvatar.Height + 1);
  imgListAvatar.GetBitmap(index, imgAvatar.Picture.Bitmap);
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  estadoLogin := 'Normal';
  carregarImagemAvatar(0);
end;

end.
