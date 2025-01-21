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
  View.PessoaCadastroCompleto,
  Presenter.Pessoa;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    btnBuscarRegistro: TButton;
    btnViewFromPresenter: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnBuscarRegistroClick(Sender: TObject);
    procedure btnViewFromPresenterClick(Sender: TObject);
  private
    frmPessoaCadastro: TfrmPessoaCadastroCompleto;
    FPessoaPresenter: TPessoaPresenter;
    procedure AbrirCadastroPessoaCompleto;
    procedure AbrirPesquisarPessoa;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Presenter.Pessoa.Types;

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

procedure TfrmMain.btnViewFromPresenterClick(Sender: TObject);
begin
  FPessoaPresenter:= TPessoaPresenter.Create(pvsCompleto);
  FPessoaPresenter.ExibirView;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  AbrirCadastroPessoaCompleto;
end;

end.
