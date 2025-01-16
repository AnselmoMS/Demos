unit Vew.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  View.PessoaCadastroCompleto;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    btnBuscarRegistro: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnBuscarRegistroClick(Sender: TObject);
  private
    frmPessoaCadastro: TfrmPessoaCadastroCompleto;
    procedure AbrirCadastroPessoaCompleto;
    procedure AbrirPesquisarPessoa;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.AbrirCadastroPessoaCompleto;
begin
  frmPessoaCadastro := TfrmPessoaCadastroCompleto.Create(Self);
  frmPessoaCadastro.Show;
end;

procedure TfrmMain.AbrirPesquisarPessoa;
begin

end;

procedure TfrmMain.btnBuscarRegistroClick(Sender: TObject);
begin
  AbrirPesquisarPessoa;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  AbrirCadastroPessoaCompleto;
end;

end.
