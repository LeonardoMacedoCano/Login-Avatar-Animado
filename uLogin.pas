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
    checkBoxMostrar: TCheckBox;
    procedure carregarImagemAvatar(index: Integer);
    procedure mudarEstadoLogin(novoEstado: String);
    procedure validarAvatarPiscar(valor1, valor2: Integer);
    procedure validarStatusEmail;
    procedure timerAvatarTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtEmailEnter(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure edtSenhaEnter(Sender: TObject);
  private
    FestadoLogin: String;
    FpiscarAvatar: Boolean;
    FstatusEmail: Integer;
  public
    property estadoLogin: String read FestadoLogin write FestadoLogin;
    property piscarAvatar: Boolean read FpiscarAvatar write FpiscarAvatar;
    property statusEmail: Integer read FstatusEmail write FstatusEmail;
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

procedure TFrmLogin.edtEmailChange(Sender: TObject);
begin
  if estadoLogin = 'Email' then
  begin
    validarStatusEmail;
  end;
end;

procedure TFrmLogin.edtEmailEnter(Sender: TObject);
begin
  mudarEstadoLogin('Email');
end;

procedure TFrmLogin.edtEmailExit(Sender: TObject);
begin
  mudarEstadoLogin('Normal');
end;

procedure TFrmLogin.edtSenhaEnter(Sender: TObject);
begin
  mudarEstadoLogin('Senha');
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  mudarEstadoLogin('Normal');
  statusEmail := 0;
end;

procedure TFrmLogin.mudarEstadoLogin(novoEstado: String);
begin
  if novoEstado <> estadoLogin then
  begin
    estadoLogin := novoEstado;
    timerAvatar.Interval := 1;
  end;
end;

procedure TFrmLogin.timerAvatarTimer(Sender: TObject);
begin
  if estadoLogin = 'Normal' then
  begin
    validarAvatarPiscar(1,0);
  end
  else if estadoLogin = 'Email' then
  begin
    if Pos('@', edtEmail.Text) <> 0 then
    begin
      validarAvatarPiscar(6,5);
      statusEmail := 2;
    end
    else if edtEmail.Text <> EmptyStr then
    begin
      validarAvatarPiscar(4,3);
      statusEmail := 1;
    end
    else
    begin
      validarAvatarPiscar(1,2);
      statusEmail := 0;
    end;
  end
  else if estadoLogin = 'Senha' then
  begin
    if checkBoxMostrar.Checked then
    begin
      validarAvatarPiscar(8,8);
    end
    else
    begin
      validarAvatarPiscar(7,7);
    end;
  end;

  piscarAvatar := not piscarAvatar;
end;

procedure TFrmLogin.validarAvatarPiscar(valor1, valor2: Integer);
begin
  if piscarAvatar then
  begin
    carregarImagemAvatar(valor1);
    timerAvatar.Interval := 150;
  end
  else
  begin
    carregarImagemAvatar(valor2);
    timerAvatar.Interval := 2000 + random(3000);
  end;
end;

procedure TFrmLogin.validarStatusEmail;
begin
  case statusEmail of
    2:
    begin
      if Pos('@', edtEmail.Text) = 0 then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    1:
    begin
      if (Pos('@', edtEmail.Text) <> 0) or (edtEmail.Text = EmptyStr) then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    0:
    begin
      if edtEmail.Text <> EmptyStr then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
  end;
end;

end.
