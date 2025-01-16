unit View.PessoaCadastro;

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
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  View.Interfaces,
  View.Pessoa.Interfaces;

type
  TfrmPessoaCadastro = class(TForm{, IView, IViewPessoa})
    lblId: TLabel;
    edtNome: TEdit;
    btnNovo: TButton;
    spnedtIdade: TSpinEdit;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnEditar: TButton;
  private
    { Private declarations }
  public
    procedure ExibirRegistroId(AId: Integer);
  end;

implementation

{$R *.dfm}

{ TfrmPessoaCadastro }

procedure TfrmPessoaCadastro.ExibirRegistroId(AId: Integer);
begin

end;

end.
