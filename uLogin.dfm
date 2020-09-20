object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  VertScrollBar.ParentColor = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 499
  ClientWidth = 349
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = -1
    Top = -1
    Width = 350
    Height = 500
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alCustom
    Anchors = []
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      350
      500)
    object imgAvatar: TImage
      Left = 109
      Top = 50
      Width = 132
      Height = 124
      Anchors = []
      Stretch = True
      Transparent = True
    end
  end
  object imgListAvatar: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 124
    Width = 132
    Left = 295
    Top = 39
  end
end
