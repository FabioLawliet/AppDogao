unit ULista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, IOUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Objects, FMX.Ani, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.MultiView, System.Actions, FMX.ActnList, FMX.ListBox, rtti;

type
  TFrmLista = class(TForm)
    rect_toolbar: TRectangle;
    lbl_titulo: TLabel;
    img_busca: TImage;
    img_cancelar: TImage;
    rect_busca: TRectangle;
    img_cancel_busca: TImage;
    AnimationBusca: TFloatAnimation;
    RoundRect1: TRoundRect;
    edt_busca: TEdit;
    img_salvar: TImage;
    img_favorito: TImage;
    btnMenu: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    Image1: TImage;
    TabItem2: TTabItem;
    VertScrollBoxMinhaLista: TVertScrollBox;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    VertScrollBoxLista: TVertScrollBox;
    TabItem5: TTabItem;
    VertScrollBox2: TVertScrollBox;
    MultiView1: TMultiView;
    LayoutMenuTopo: TLayout;
    CircleFoto: TCircle;
    LabelNomeUser: TLabel;
    VertScrollBox1: TVertScrollBox;
    RectMeusDados: TRoundRect;
    Label1: TLabel;
    RectFavoritos: TRoundRect;
    Label2: TLabel;
    RoundProfissionais: TRoundRect;
    LabelProfissionais: TLabel;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    ChangeTabAction4: TChangeTabAction;
    ChangeTabAction5: TChangeTabAction;
    VertScrollBoxFavoritos: TVertScrollBox;
    ImageFavoritos: TImage;
    Label18: TLabel;
    Layout1: TLayout;
    Circle1: TCircle;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    ComboBox1: TComboBox;
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure img_aba2Click(Sender: TObject);
    procedure RectMeusDadosClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarListaProdutos(id: integer; nome, descricao: string;
      valor: double);
    procedure GetProdutosBase;
    procedure AddItem(Sender: TObject);
    procedure RemoveItem(Sender: TObject);
    procedure GetListafavoritos;
    procedure AddFavoritos(Sender: TObject);
    function favorito(id: integer): boolean;
    procedure Limpar(AScroll: TVertScrollBox);
  public
    { Public declarations }
    FValorTotal: Double;
  end;

var
  FrmLista: TFrmLista;

implementation

{$R *.fmx}

uses UDM;

{ TFrmLista }

procedure TFrmLista.AddFavoritos(Sender: TObject);
var
  AId: string;
begin
  AId := (TRectangle(Sender).TagString);
  dm.FDQProduto.Locate('id', AId, []);

  if (dm.FDQProdutofavorito.AsString = 'N') then
  begin
    dm.FDQProduto.Edit;
    dm.FDQProdutofavorito.AsString := 'S';
    dm.FDQProduto.Post;
  end else
  begin
    dm.FDQProduto.Edit;
    dm.FDQProdutofavorito.AsString := 'N';
    dm.FDQProduto.Post;
  end;
  GetProdutosBase;
end;

procedure TFrmLista.AddItem(Sender: TObject);
begin
  dm.FDQProduto.Locate('id', TButton(Sender).TagString,[]);
  FValorTotal := dm.FDQPedido.FieldByName('vlrPedido').AsFloat;
  dm.FDQPedido.Append;
  dm.FDQPedido.FieldByName('PessoaId').AsInteger := dm.FDQPessoaid.AsInteger;
  dm.FDQPedido.FieldByName('datahora').AsDateTime := now;
  dm.FDQPedido.FieldByName('vlrPedido').AsFloat := FValorTotal + dm.FDQProdutoValor.AsFloat;
  dm.FDQPedido.FieldByName('statusPedido').AsString := 'A';
  dm.FDQPedido.Post;

  dm.FDQItemPedido.FieldByName('idPedido').AsInteger := dm.FDQPedido.FieldByName('id').AsInteger;
  dm.FDQItemPedido.FieldByName('idProduto').AsInteger := dm.FDQProduto.FieldByName('id').AsInteger;
  dm.FDQItemPedido.FieldByName('qtdeProduto').AsInteger := dm.FDQItemPedido.FieldByName('qtdeProduto').AsInteger + 1;
  dm.FDQItemPedido.FieldByName('vlrItem').AsFloat := dm.FDQProdutovalor.AsFloat;
  dm.FDQItemPedido.Post;
end;

procedure TFrmLista.Limpar(AScroll: TVertScrollBox);
var i: integer;
begin
  for i := AScroll.ComponentCount-1 downto 0 do
      if AScroll.Components[i] is TRectangle then
         TButton(AScroll.Components[i]).DisposeOf;
end;

procedure TFrmLista.CarregarListaProdutos(id: integer; nome, descricao: string;
  valor: double);
var
  rect, rect_barra: TRectangle;
  rect_icone: TCircle;
  lbl: TLabel;
  img: TImage;
  btn: TButton;
  i, valorEstrela: integer;
begin
  // fundo
  rect := TRectangle.Create(VertScrollBoxMinhaLista);
  with rect do
  begin
    Align := TAlignLayout.Top;
    Height := 110;
    Fill.Color := $FFFFFFFF;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    XRadius := 8;
    YRadius := 8;
    TagString := IntToStr(id);
  end;
  // Barra inferior...
  rect_barra := TRectangle.Create(rect);
  with rect_barra do
  begin
    Align := TAlignLayout.Bottom;
    Height := 45;
    Fill.Color := $FFF4F4F4;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Sides := [TSide.Left, TSide.Bottom, TSide.Right];
    XRadius := 8;
    YRadius := 8;
    Corners := [TCorner.BottomLeft, TCorner.BottomRight];
    HitTest := False;
    rect.AddObject(rect_barra);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FF333333;
    Text := nome;
    font.Size := 16;
    font.Style := [TFontStyle.fsBold];
    Position.x := 50;
    Position.Y := 10;
    Width := 200;
    rect.AddObject(lbl);
  end;

  lbl := TLabel.Create(rect_barra);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFDF0B0B;
    Text := descricao;
    font.Size := 11;
    font.Style := [TFontStyle.fsBold];
    Position.x := 5;
    Position.Y := 70;
    Width := 500;
    rect.AddObject(lbl);
  end;

  //btn adicionar
  btn := TButton.Create(rect_barra);
  with btn do
  begin
    nome := 'btnAdd' +  IntToStr(id);
    StyleLookup := 'additembutton';
    Position.x := 180;
    Position.y := 85;
    Height := 25;
    Width := 25;
    TagString := IntToStr(id);
    OnClick := AddItem;
    rect.AddObject(btn);
  end;

  lbl := Tlabel.Create(rect_barra);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFDF0B0B;
    font.Size := 16;
    font.Style := [TFontStyle.fsBold];
    Position.x := 230;
    Position.y := 85;
    Width := 30;
    Text := '0';
    nome := 'labelAdd' + IntToStr(id);
    rect.AddObject(lbl);
  end;

  lbl := Tlabel.Create(rect_barra);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFDF0B0B;
    font.Size := 16;
    font.Style := [TFontStyle.fsBold];
    Position.x := 230;
    Position.y := 10;
    Width := 150;
    Text := 'R$ ' + CurrToStr(dm.FDQProdutovalor.AsFloat);
    nome := 'labelAdd' + IntToStr(id);
    rect.AddObject(lbl);
  end;

  //btn remover
  btn := TButton.Create(rect_barra);
  with btn do
  begin
    nome := 'btnRemove' +  IntToStr(id);
    StyleLookup := 'deleteitembutton';
    Position.x := 270;
    Position.y := 85;
    Height := 25;
    Width := 25;
    TagString := IntToStr(id);
    OnClick := RemoveItem;
    rect.AddObject(btn);
  end;

  // ImgFavoritos
  img := TImage.Create(rect);
  if not favorito(id) then
  begin
    with img do
    begin
      {$IFDEF MSWINDOWS}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('D:\Users\fgbezerra\Downloads\tralhas\Aula3\img',
        'heart_nosel.png'));
      {$ENDIF}
      {$IF DEFINED(iOS) or DEFINED(ANDROID)}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'heart_nosel.png'));
      {$ENDIF}
      Height := 30;
      Width := 30;
      Position.x := 280;
      Position.Y := 5;
      name := 'imgheartNoSel' + IntToStr(id);
      TagString := IntToStr(id);
      OnClick := AddFavoritos;
      Visible := true;
      rect.AddObject(img);
    end;
  end
  else
  begin

    with img do
    begin
      {$IFDEF MSWINDOWS}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine
        ('D:\Users\fgbezerra\Downloads\tralhas\Aula3\img',
        'heart_yessel.png'));
      {$ENDIF}
      {$IF DEFINED(iOS) or DEFINED(ANDROID)}
      Bitmap.LoadFromFile
        (IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
        'heart_yessel.png'));
      {$ENDIF}
      Height := 30;
      Width := 30;
      Position.x := 280;
      Position.Y := 5;
      name := 'imgheartYesSel' + IntToStr(id);
      TagString := IntToStr(id);
      OnClick := AddFavoritos;
      Visible := true;
      rect.AddObject(img);
    end;
  end;
  VertScrollBoxMinhaLista.AddObject(rect);
end;

function TFrmLista.favorito(id: integer): boolean;
begin
  dm.FDQFavoritos.Close;
  dm.FDQFavoritos.ParamByName('pIdProduto').AsInteger := id;
  dm.FDQFavoritos.Open();

  if not dm.FDQFavoritos.IsEmpty then
    Result := True
  else
    Result := False;
end;

procedure TFrmLista.FormCreate(Sender: TObject);
begin
  ChangeTabAction1.Execute;
  GetProdutosBase;
  GetListafavoritos;
end;

procedure TFrmLista.GetListafavoritos;
var
  rect, rect_barra: TRectangle;
  rect_icone: TCircle;
  lbl: TLabel;
  img: TImage;
  i, valorEstrela: integer;
begin
  dm.FDQListaFavoritos.Close;
  dm.FDQListaFavoritos.Open;

  while not dm.FDQListaFavoritos.eof do
  begin
    // fundo
    rect := TRectangle.Create(VertScrollBoxMinhaLista);
    with rect do
    begin
      Align := TAlignLayout.Top;
      Height := 110;
      Fill.Color := $FFFFFFFF;
      Stroke.Kind := TBrushKind.Solid;
      Stroke.Color := $FFD4D5D7;
      Margins.Top := 10;
      Margins.Left := 10;
      Margins.Right := 10;
      XRadius := 8;
      YRadius := 8;
      TagString := dm.FDQListaFavoritos.FieldByName('id').AsString;
    end;
    // Barra inferior...
    rect_barra := TRectangle.Create(rect);
    with rect_barra do
    begin
      Align := TAlignLayout.Bottom;
      Height := 45;
      Fill.Color := $FFF4F4F4;
      Stroke.Kind := TBrushKind.Solid;
      Stroke.Color := $FFD4D5D7;
      Sides := [TSide.Left, TSide.Bottom, TSide.Right];
      XRadius := 8;
      YRadius := 8;
      Corners := [TCorner.BottomLeft, TCorner.BottomRight];
      HitTest := False;
      rect.AddObject(rect_barra);
    end;

    lbl := TLabel.Create(rect);
    with lbl do
    begin
      StyledSettings := StyledSettings - [TStyledSetting.Size,
        TStyledSetting.FontColor, TStyledSetting.Style];
      TextSettings.FontColor := $FF333333;
      Text := dm.FDQListaFavoritos.FieldByName('nome').AsString;
      font.Size := 16;
      font.Style := [TFontStyle.fsBold];
      Position.x := 50;
      Position.Y := 10;
      Width := 200;
      rect.AddObject(lbl);
    end;
    lbl := TLabel.Create(rect_barra);
    with lbl do
    begin
      StyledSettings := StyledSettings - [TStyledSetting.Size,
        TStyledSetting.FontColor, TStyledSetting.Style];
      TextSettings.FontColor := $FFDF0B0B;
      Text := dm.FDQListaFavoritos.FieldByName('descricao').AsString;
      font.Size := 11;
      font.Style := [TFontStyle.fsBold];
      Position.x := 5;
      Position.Y := 70;
      Width := 500;
      rect.AddObject(lbl);
    end;
    VertScrollBoxFavoritos.AddObject(rect);
    dm.FDQListaFavoritos.Next;
  end;
end;

procedure TFrmLista.GetProdutosBase;
begin
  Limpar(VertScrollBoxMinhaLista);
  dm.FDQProduto.Close;
  dm.FDQProduto.Open();
  while not dm.FDQProduto.Eof do
  begin
    CarregarListaProdutos(dm.FDQProdutoid.AsInteger, dm.FDQProdutonome.AsString,
      dm.FDQProdutodescricao.AsString, dm.FDQProdutovalor.AsFloat);
    dm.FDQProduto.next;
  end;

end;

procedure TFrmLista.img_aba2Click(Sender: TObject);
begin
  ChangeTabAction2.Execute;
end;

procedure TFrmLista.RectMeusDadosClick(Sender: TObject);
begin
  btnMenu.OnClick(Self);
  ChangeTabAction5.Execute;
end;

procedure TFrmLista.RemoveItem(Sender: TObject);
begin

end;

end.
