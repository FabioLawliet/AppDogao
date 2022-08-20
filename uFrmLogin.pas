unit uFrmLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, idhashSHA, uDataModule,
  FMX.Objects, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Controls.Presentation,
  System.Math.Vectors, FMX.Controls3D, FMX.Layers3D, FMX.ExtCtrls, FMX.Menus,
  System.Actions, FMX.ActnList;

type
  TForm1 = class(TForm)
    MenuBar: TMenuBar;
    PnlRodape: TPanel;
    ltLogin: TLayout;
    lbUsuario: TLabel;
    edtUsuario: TEdit;
    lbSenha: TLabel;
    edtSenha: TEdit;
    btnConfirmar: TButton;
    ltLogo: TLayout;
    Image1: TImage;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    ActionList1: TActionList;
    procedure btnConfirmarClick(Sender: TObject);
    function ReturnPasswordSHA1(const APassword: string): string;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.Surface.fmx MSWINDOWS}
{$R *.Windows.fmx MSWINDOWS}

procedure TForm1.btnConfirmarClick(Sender: TObject);
begin
  dm.QueryUsuario.open;
  dm.QueryUsuario.Append;
  dm.QueryUsuariologin.AsString := ReturnPasswordSHA1(edtUsuario.Text);
  dm.QueryUsuariosenha.AsString := edtSenha.Text;
  dm.QueryUsuario.Post;
  dm.QueryUsuario.connection.Commit;
  showMessage('usuario cadastrado');
end;

function TForm1.ReturnPasswordSHA1(const APassword: string): string;
var
  hash: TIdHashSHA1;
begin
  hash := TIdHashSHA1.Create;
  try
    result := hash.HashStringAsHex(APassword);
  finally
    hash.Free;
  end;
end;

end.
