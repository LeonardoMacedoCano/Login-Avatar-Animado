unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TFrmLogin = class(TForm)
    pnlMain: TPanel;
    imgAvatar: TImage;
    imgListAvatar: TImageList;
    timerAvatar: TTimer;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    btnEntrar: TButton;
    procedure FormShow(Sender: TObject);
    procedure carregarImagemAvatar(index: Integer);
    procedure timerAvatarTimer(Sender: TObject);
  private
    FestadoLogin: String;
    FpiscarAvatar: Boolean;
  public
    property estadoLogin: String read FestadoLogin write FestadoLogin;
    property piscarAvatar: Boolean read FpiscarAvatar write FpiscarAvatar;
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
  piscarAvatar := True;
  carregarImagemAvatar(0);
  timerAvatar.Interval := 2000 + random(3000);
end;

procedure TFrmLogin.timerAvatarTimer(Sender: TObject);
begin
  if estadoLogin = 'Normal' then
  begin
    if piscarAvatar then
    begin
      carregarImagemAvatar(1);
      timerAvatar.Interval := 150;
    end
    else
    begin
      carregarImagemAvatar(0);
      timerAvatar.Interval := 2000 + random(3000);
    end;

    piscarAvatar := not piscarAvatar;
  end;
end;

end.
