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
    FEstadoLogin: TEstadoLogin;
    FPiscarAvatar: Boolean;
    FStatusEmail: TStatusEmail;
    FMostrarSenha: Boolean;
    procedure carregarImagemAvatar(AIndex: Integer);
    procedure mudarEstadoLogin(ANovoEstado: TEstadoLogin);
    procedure validarAvatarPiscar(AIndexPiscar, AIndexNaoPiscar: Integer);
    procedure validarStatusEmail;
  public
    property EstadoLogin: TEstadoLogin read FEstadoLogin write FEstadoLogin;
    property PiscarAvatar: Boolean read FPiscarAvatar write FPiscarAvatar;
    property StatusEmail: TStatusEmail read FStatusEmail write FStatusEmail;
    property MostrarSenha: Boolean read FMostrarSenha write FMostrarSenha;
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.carregarImagemAvatar(AIndex: Integer);
begin
  imgAvatar.Canvas.Pen.Style := psClear;
  imgAvatar.Canvas.Rectangle(0, 0, imgAvatar.Width + 1, imgAvatar.Height + 1);
  imgListAvatar.GetBitmap(AIndex, imgAvatar.Picture.Bitmap);
end;

procedure TFrmLogin.checkBoxMostrarClick(Sender: TObject);
var
  vPasswordChar: Char;
begin
  if not (checkBoxMostrar.Checked = FMostrarSenha) then
  begin
    FMostrarSenha := not FMostrarSenha;
    timerAvatar.Interval := 1;

    if FMostrarSenha then
    begin
      vPasswordChar := #0;
    end
    else
    begin
      vPasswordChar := '*';
    end;

    edtSenha.PasswordChar := vPasswordChar;
  end;
end;

procedure TFrmLogin.edtEmailChange(Sender: TObject);
begin
  if (FEstadoLogin = elEmail) then
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
  FStatusEmail := seVazio;
  FMostrarSenha := checkBoxMostrar.Checked;
end;

procedure TFrmLogin.mudarEstadoLogin(ANovoEstado: TEstadoLogin);
begin
  if (ANovoEstado <> FEstadoLogin) then
  begin
    FEstadoLogin := ANovoEstado;
    timerAvatar.Interval := 1;
  end;
end;

procedure TFrmLogin.timerAvatarTimer(Sender: TObject);
begin
  case FEstadoLogin of
    elNormal:
    begin
      validarAvatarPiscar(1,0);
    end;
    elEmail:
    begin
      if (Pos('@', edtEmail.Text) <> 0) then
      begin
        validarAvatarPiscar(6,5);
        FStatusEmail := seFinal;
      end
      else if (edtEmail.Text <> EmptyStr) then
      begin
        validarAvatarPiscar(4,3);
        FStatusEmail := seMeio;
      end
      else
      begin
        validarAvatarPiscar(1,2);
        FStatusEmail := seVazio;
      end;
    end;
    elSenha:
    begin
      if checkBoxMostrar.Checked then
      begin
        validarAvatarPiscar(9,8);
        FMostrarSenha := True;
      end
      else
      begin
        validarAvatarPiscar(7,7);
        FMostrarSenha := False;
      end;
    end;
  end;

  FPiscarAvatar := not FPiscarAvatar;
end;

procedure TFrmLogin.validarAvatarPiscar(AIndexPiscar, AIndexNaoPiscar: Integer);
begin
  if FPiscarAvatar then
  begin
    carregarImagemAvatar(AIndexPiscar);
    timerAvatar.Interval := 150;
  end
  else
  begin
    carregarImagemAvatar(AIndexNaoPiscar);
    timerAvatar.Interval := 2000 + random(3000);
  end;
end;

procedure TFrmLogin.validarStatusEmail;
begin
  case FStatusEmail of
    seFinal:
    begin
      if (Pos('@', edtEmail.Text) = 0) then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    seMeio:
    begin
      if ((Pos('@', edtEmail.Text) <> 0) or (edtEmail.Text = EmptyStr)) then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
    seVazio:
    begin
      if (edtEmail.Text <> EmptyStr) then
      begin
        timerAvatar.Interval := 1;
      end;
    end;
  end;
end;

end.
