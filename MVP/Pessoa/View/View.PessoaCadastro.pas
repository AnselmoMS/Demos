unit View.PessoaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Samples.Spin, Vcl.StdCtrls;

type
  TfrmPessoaCadastro = class(TForm)
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
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
