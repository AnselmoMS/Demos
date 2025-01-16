unit View.Pessoa.Interfaces;

interface

uses
  Data.DB,
  Model.Entity.Pessoa,
  Comum.Constants,
  System.UITypes;

type
  IViewPessoa = interface
    ['{E76A8A8C-2339-4E58-93E5-02F6B1D2F2B9}']
    function DataSetLista: TDataSet;
    function ObterId: Integer;
    function ObterIdade: Integer;
    function ObterNome: string;
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure HabilitarControlesNavegar(AHabilitar: Boolean);
    procedure LimparControlesCadastro;
    procedure SetDataSetLista(ADataSet: TDataSet);
  end;

  IViewPessoaDataSet = interface
    ['{7489C0CA-3527-4DCD-9651-14EB467F0393}']
    function DataSetLista: TDataSet;
    procedure SetDataSetLista(ADataSet: TDataSet);
  end;

implementation

end.

