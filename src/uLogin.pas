unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TEstadoLogin = (elNormal, elEmail, elSenha);

  TStatusEmail = (seVazio, seMeio, seFinal);

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
    procedure timerAvatarTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtEmailEnter(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure edtSenhaEnter(Sender: TObject);
    procedure checkBoxMostrarClick(Sender: TObject);
  private
    FestadoLogin: TEstadoLogin;
    FpiscarAvatar: Boolean;
    FmostrarSenha: Boolean;
    FstatusEmail: TStatusEmail;
    procedure carregarImagemAvatar(index: Integer);
    procedure mudarEstadoLogin(novoEstado: TEstadoLogin);
    procedure validarAvatarPiscar(valor1, valor2: Integer);
    procedure validarStatusEmail;
  public
    property estadoLogin: TEstadoLogin read FestadoLogin write FestadoLogin;
    property piscarAvatar: Boolean read FpiscarAvatar write FpiscarAvatar;
    property statusEmail: TStatusEmail read FstatusEmail write FstatusEmail;
    property mostrarSenha: Boolean read FmostrarSenha write FmostrarSenha;
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

procedure TFrmLogin.checkBoxMostrarClick(Sender: TObject);
var
  iPasswordChar: String;
begin
  if not (checkBoxMostrar.Checked = mostrarSenha) then
  begin
    mostrarSenha := not mostrarSenha;
    timerAvatar.Interval := 1;

    if mostrarSenha then
    begin
      iPasswordChar := #0;
    end
    else
    begin
      iPasswordChar := '*';
    end;

    edtSenha.PasswordChar := iPasswordChar[1];
  end;
end;

procedure TFrmLogin.edtEmailChange(Sender: TObject);
begin
  if estadoLogin = elEmail then
  begin
    validarStatusEmail;
  end;
end;

procedure TFrmLogin.edtEmailEnter(Sender: TObject);
begin
  mudarEstadoLogin(elEmail);
end;

procedure TFrmLogin.edtEmailExit(Sender: TObject);
begin
  mudarEstadoLogin(elNormal);
end;

procedure TFrmLogin.edtSenhaEnter(Sender: TObject);
begin
  mudarEstadoLogin(elSenha);
  carregarImagemAvatar(10);
  timerAvatar.Interval := 35;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  mudarEstadoLogin(elNormal);
  statusEmail := seVazio;
  mostrarSenha := checkBoxMostrar.Checked;
end;

procedure TFrmLogin.mudarEstadoLogin(novoEstado: TEstadoLogin);
begin
  if novoEstado <> estadoLogin then
  begin
    estadoLogin := novoEstado;
    timerAvatar.Interval := 1;
  end;
end;

procedure TFrmLogin.timerAvatarTimer(Sender: TObject);
begin
  if estadoLogin = elNormal then
  begin
    validarAvatarPiscar(1,0);
  end
  else if estadoLogin = elEmail then
  begin
    if Pos('@', edtEmail.Text) <> 0 then
    begin
      validarAvatarPiscar(6,5);
      statusEmail := seFinal;
    end
    else if edtEmail.Text <> EmptyStr then
    begin
      validarAvatarPiscar(4,3);
      statusEmail := seMeio;
    end
    else
    begin
      validarAvatarPiscar(1,2);
      statusEmail := seVazio;
    end;
  end
  else if estadoLogin = elSenha then
  begin
    if checkBoxMostrar.Checked then
    begin
      validarAvatarPiscar(9,8);
      mostrarSenha := True;
    end
    else
    begin
      validarAvatarPiscar(7,7);
      mostrarSenha := False;
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
    seFinal:
    begin
      if Pos('@', edtEmail.Text) = 0 then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    seMeio:
    begin
      if (Pos('@', edtEmail.Text) <> 0) or (edtEmail.Text = EmptyStr) then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    seVazio:
    begin
      if edtEmail.Text <> EmptyStr then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
  end;
end;

end.
