unit View.Pessoa.Interfaces;

interface

uses
  Data.DB,
  Model.Entity.Pessoa,
  Comum.Types,
  System.UITypes,
  View.Interfaces;

type
  IViewPessoaCadastro = interface
    ['{E76A8A8C-2339-4E58-93E5-02F6B1D2F2B9}']
    function AsView: IView;
    function ObterId: Integer;
    function ObterIdade: Integer;
    function ObterNome: string;
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);

    procedure LimparControlesCadastro;
  end;

  IViewPessoaDataSet = interface
    ['{7489C0CA-3527-4DCD-9651-14EB467F0393}']
    function DataSetLista: TDataSet;
    procedure SetDataSetLista(ADataSet: TDataSet);
    procedure HabilitarControlesNavegar(ADataSetState: TDataSetState);
  end;

implementation

end.

