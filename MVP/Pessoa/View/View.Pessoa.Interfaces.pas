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
    function Perguntar(AMensagem: String): TModalResult;
    procedure ExibirMensagem(const Mensagem: string; AMenssageSeverity: TMessageSeverity = msInformation);
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure HabilitarControlesNavegar(AHabilitar: Boolean);
    procedure LimparControlesCadastro;
    procedure SetDataSetLista(ADataSet: TDataSet);
  end;

implementation

end.

