object frmCadastroClientes: TfrmCadastroClientes
  Left = 0
  Top = 0
  Caption = 'Info Sistemas - Cadastro de Clientes'
  ClientHeight = 379
  ClientWidth = 736
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 736
    Height = 379
    Align = alClient
    TabOrder = 0
    ExplicitTop = 224
    ExplicitHeight = 179
    object lblNome: TLabel
      Left = 34
      Top = 32
      Width = 27
      Height = 13
      Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblIdentidade: TLabel
      Left = 321
      Top = 32
      Width = 52
      Height = 18
      Caption = 'Identidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCPF: TLabel
      Left = 531
      Top = 32
      Width = 19
      Height = 13
      Caption = 'CPF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTelefone: TLabel
      Left = 34
      Top = 74
      Width = 42
      Height = 13
      Caption = 'Telefone'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblEmail: TLabel
      Left = 321
      Top = 73
      Width = 24
      Height = 13
      Caption = 'Email'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object gpbEndRes: TGroupBox
      Left = 13
      Top = 126
      Width = 710
      Height = 115
      Caption = ' Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object Label7: TLabel
        Left = 114
        Top = 16
        Width = 54
        Height = 13
        Caption = 'Logradouro'
      end
      object Bairro: TLabel
        Left = 10
        Top = 56
        Width = 27
        Height = 13
        Caption = 'Bairro'
      end
      object Label8: TLabel
        Left = 128
        Top = 56
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label9: TLabel
        Left = 8
        Top = 16
        Width = 21
        Height = 13
        Caption = 'CEP'
      end
      object Label22: TLabel
        Left = 288
        Top = 55
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label47: TLabel
        Left = 501
        Top = 16
        Width = 64
        Height = 13
        Caption = 'Complemento'
      end
      object Label80: TLabel
        Left = 440
        Top = 16
        Width = 37
        Height = 13
        Caption = 'N'#250'mero'
      end
      object Label1: TLabel
        Left = 346
        Top = 55
        Width = 20
        Height = 13
        Caption = 'Pais'
      end
      object btnBuscarCEP: TBitBtn
        Left = 79
        Top = 29
        Width = 29
        Height = 21
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FFF333333333333000333333333
          3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
          3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
          0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
          BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
          33337777773FF733333333333300033333333333337773333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnBuscarCEPClick
      end
      object DBEdit6: TDBEdit
        Left = 9
        Top = 29
        Width = 64
        Height = 21
        Color = clInfoBk
        DataField = 'CEP'
        DataSource = DataSource1
        TabOrder = 0
        OnExit = DBEdit6Exit
      end
      object DBEdit7: TDBEdit
        Left = 114
        Top = 29
        Width = 311
        Height = 21
        Color = clInfoBk
        DataField = 'Logra'
        DataSource = DataSource1
        TabOrder = 2
      end
      object DBEdit8: TDBEdit
        Left = 440
        Top = 29
        Width = 55
        Height = 21
        Color = clInfoBk
        DataField = 'Numero'
        DataSource = DataSource1
        TabOrder = 3
      end
      object DBEdit9: TDBEdit
        Left = 501
        Top = 29
        Width = 164
        Height = 21
        Color = clInfoBk
        DataField = 'Compl'
        DataSource = DataSource1
        TabOrder = 4
      end
      object DBEdit10: TDBEdit
        Left = 10
        Top = 75
        Width = 113
        Height = 21
        Color = clInfoBk
        DataField = 'Bairro'
        DataSource = DataSource1
        TabOrder = 5
      end
      object DBEdit11: TDBEdit
        Left = 129
        Top = 75
        Width = 145
        Height = 21
        Color = clInfoBk
        DataField = 'Localidade'
        DataSource = DataSource1
        TabOrder = 6
      end
      object DBEdit12: TDBEdit
        Left = 290
        Top = 74
        Width = 31
        Height = 21
        Color = clInfoBk
        DataField = 'Estado'
        DataSource = DataSource1
        TabOrder = 7
      end
      object DBEdit13: TDBEdit
        Left = 344
        Top = 74
        Width = 133
        Height = 21
        Color = clInfoBk
        DataField = 'Pais'
        DataSource = DataSource1
        TabOrder = 8
      end
    end
    object DBEdit1: TDBEdit
      Left = 88
      Top = 29
      Width = 212
      Height = 21
      Color = clInfoBk
      DataField = 'Nome'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 379
      Top = 29
      Width = 137
      Height = 21
      Color = clInfoBk
      DataField = 'Identidade'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 556
      Top = 29
      Width = 137
      Height = 21
      Color = clInfoBk
      DataField = 'CPF'
      DataSource = DataSource1
      TabOrder = 2
      OnExit = DBEdit3Exit
    end
    object DBEdit4: TDBEdit
      Left = 88
      Top = 74
      Width = 137
      Height = 21
      Color = clInfoBk
      DataField = 'Telefone'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit5: TDBEdit
      Left = 379
      Top = 70
      Width = 214
      Height = 21
      Color = clInfoBk
      DataField = 'Email'
      DataSource = DataSource1
      TabOrder = 4
      OnExit = DBEdit5Exit
    end
    object DBNavigator1: TDBNavigator
      Left = 13
      Top = 285
      Width = 231
      Height = 49
      DataSource = DataSource1
      VisibleButtons = [nbPrior, nbNext, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object Button1: TButton
      Left = 321
      Top = 286
      Width = 105
      Height = 49
      Caption = 'Enviar Email'
      TabOrder = 7
      OnClick = Button1Click
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 359
      Width = 734
      Height = 19
      Panels = <
        item
          Text = 'Aguarde o Envio do Email.....'
          Width = 50
        end>
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 360
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = ClientDataSet1BeforePost
    AfterPost = ClientDataSet1AfterPost
    Left = 536
    Top = 312
    object ClientDataSet1Nome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object ClientDataSet1Identidade: TStringField
      FieldName = 'Identidade'
    end
    object ClientDataSet1CPF: TStringField
      FieldName = 'CPF'
    end
    object ClientDataSet1Telefone: TStringField
      FieldName = 'Telefone'
    end
    object ClientDataSet1Email: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object ClientDataSet1CEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object ClientDataSet1Logra: TStringField
      FieldName = 'Logra'
      Size = 100
    end
    object ClientDataSet1Numero: TStringField
      FieldName = 'Numero'
      Size = 30
    end
    object ClientDataSet1Compl: TStringField
      FieldName = 'Compl'
      Size = 50
    end
    object ClientDataSet1Bairro: TStringField
      FieldName = 'Bairro'
      Size = 50
    end
    object ClientDataSet1Localidade: TStringField
      FieldName = 'Localidade'
      Size = 50
    end
    object ClientDataSet1Estado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object ClientDataSet1Pais: TStringField
      FieldName = 'Pais'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 616
    Top = 312
  end
end
