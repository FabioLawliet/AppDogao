unit USplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TFrmSplash = class(TForm)
    Image1: TImage;
    Image2: TImage;
    RoundRectComecar: TRoundRect;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RoundRectComecarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}

uses UInicial;

procedure TFrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  FrmSplash := nil;
end;

procedure TFrmSplash.FormCreate(Sender: TObject);
begin
  Image1.Align := TAlignLayout.Center;
end;

procedure TFrmSplash.FormShow(Sender: TObject);
begin
  Image1.Opacity := 0;
  Image1.AnimateFloat('Opacity', 1, 0.9);
  Image2.Opacity := 0;
  Image2.AnimateFloat('Opacity', 1, 0.9);
end;

procedure TFrmSplash.RoundRectComecarClick(Sender: TObject);
begin
  if not Assigned(FrmInicial) then
    Application.CreateForm(TFrmInicial, FrmInicial);

  FrmInicial.Show;

end;

end.
