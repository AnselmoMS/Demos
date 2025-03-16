unit View.Pessoa.Interfaces;

interface

uses
  Data.DB,
  Model.Entity.Pessoa,
  DAO.Entity.Pessoa,
  Comum.Types,
  System.UITypes,
  View.Interfaces;

type
  IViewPessoaCadastro = interface
    ['{E76A8A8C-2339-4E58-93E5-02F6B1D2F2B9}']
    function AsView: IView;
    function ObterPessoa: TPessoa;
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure LimparControlesCadastro;
  end;

  IViewPessoaListagem = interface
    ['{7489C0CA-3527-4DCD-9651-14EB467F0393}']
    procedure HabilitarControlesNavegar(ADataSetState: TDataSetState);
    procedure ExibirListagem(APessoaListagem: TArray<TPessoaListagem>);
  end;

implementation

end.

