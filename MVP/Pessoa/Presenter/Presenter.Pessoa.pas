unit Presenter.Pessoa;

interface

uses
  Model.Service.Pessoa,
  Model.Entity.Pessoa,
  View.Pessoa.Interfaces,
  Data.DB,
  uADCompClient,
  Comum.Constants,
  System.SysUtils,
  System.Classes,
  View.Interfaces;

type
  TPessoaPresenter = class
  private
  var
    FAfterDataChange: TProc;
    FRecordState: TDataSetState;
    FService: TPessoaService;
    FView: IView;
    FViewPessoa: IViewPessoa;
    procedure ExecuteAfterDataChange;
    function ObterPessoaDaView: TPessoa;
    procedure SetAfterDataChange(const Value: TProc);
    procedure SetRecordState(const Value: TDataSetState);
  public
    constructor Create(AView: IView; AViewPessoa: IViewPessoa);
    destructor Destroy; override;
    //
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(AId: Integer);
    procedure IniciarNovoRegistro;
    procedure Salvar;
    procedure CarregarId(AId: Integer);
    //
    property AfterDataChange: TProc read FAfterDataChange write SetAfterDataChange;
    property RecordState: TDataSetState read FRecordState;
  end;

implementation

uses
  uADCompDataSet,
  System.UITypes;

procedure TPessoaPresenter.Excluir(AId: Integer);
begin
  if FRecordState in dsEditModes then
    raise Exception.Create('Não é possível excluir registro em edição!');

  FService.Excluir(AId);
  ExecuteAfterDataChange;
end;

procedure TPessoaPresenter.ExecuteAfterDataChange;
begin
  if Assigned(FAfterDataChange) then
    FAfterDataChange;
end;

procedure TPessoaPresenter.Cancelar;
begin
  SetRecordState(dsBrowse);
end;

procedure TPessoaPresenter.CarregarId(AId: Integer);
var
  LPessoa: TPessoa;
begin
  FView.ExibirMensagem('Carregando registro selecionado...', msLog);
  Sleep(2000); //Atraso artifical para simular busca no banco
  LPessoa := FService.ObterPorId(AId); //FService.GetCurrentFromDataset(FDataSetLista);
  FViewPessoa.ExibirRegistro(LPessoa);
end;

constructor TPessoaPresenter.Create(AView: IView; AViewPessoa: IViewPessoa);
begin
  FService := TPessoaService.Create;
  FView := AView;
  FViewPessoa := AViewPessoa;
  FRecordState := dsInactive;
end;

destructor TPessoaPresenter.Destroy;
begin
  FreeAndNil(FService);
  inherited;
end;

procedure TPessoaPresenter.Editar;
begin
  SetRecordState(dsEdit);
end;

procedure TPessoaPresenter.IniciarNovoRegistro;
begin
  FViewPessoa.LimparControlesCadastro;
  SetRecordState(dsInsert);
end;

function TPessoaPresenter.ObterPessoaDaView: TPessoa;
begin
  Result := TPessoa.Create;
  Result.Id := FViewPessoa.ObterId;
  Result.Nome := FViewPessoa.ObterNome;
  Result.Idade := FViewPessoa.ObterIdade;
end;

procedure TPessoaPresenter.Salvar;
var
  LPessoa: TPessoa;
begin
  LPessoa:= ObterPessoaDaView;
  try
    try
      case RecordState of
        dsEdit:
         FService.Atualizar(LPessoa);

        dsInsert:
         FService.Adicionar(LPessoa);
      else
        raise Exception.Create('Registro não disponível para salvar!');
      end;

      SetRecordState(dsBrowse);

      FView.ExibirMensagem('Pessoa registrada com sucesso!', msLog);
      FView.ExibirMensagem('Pessoa registrada com sucesso!', msInformation);

      ExecuteAfterDataChange;
    Except
      on e: Exception do
      begin
        FView.ExibirMensagem(E.Message, msError);
      end;
    end;
  finally
    LPessoa.Free;
  end;
end;

procedure TPessoaPresenter.SetAfterDataChange(const Value: TProc);
begin
  FAfterDataChange := Value;
end;

procedure TPessoaPresenter.SetRecordState(const Value: TDataSetState);
begin
  FViewPessoa.HabilitarControlesCadastro((Value in [dsInsert, dsEdit]));
  FViewPessoa.HabilitarControlesNavegar((Value in [dsBrowse]));
  FViewPessoa.HabilitarControlesAcoes(Value);
  FRecordState := Value;
end;

end.

