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
  System.Classes;

type
  TPessoaPresenter = class
  private
  var
    FDataSetLista: TDataSet;
    FAfterDataChange: TProc;
    FRecordState: TDataSetState;
    FService: TPessoaService;
    FView: IViewPessoa;
    FBeforeLoadList: TProc;
    FAfterLoadList: TProc;
    FOnListScroll: TProc;
    procedure CarregarRegistroDoBanco;
    procedure ExecuteAfterDataChange;
    function ObterPessoaDaView: TPessoa;
    procedure SetAfterDataChange(const Value: TProc);
    procedure SetRecordState(const Value: TDataSetState);
  public
    const
      TIMEOUT_LOAD_LIST = 500;

    constructor Create(AView: IViewPessoa);
    destructor Destroy; override;
    //
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(AId: Integer);
    procedure ExibirPessoaSelecionadaDaLista;
    procedure IniciarNovoRegistro;
    procedure ListarPessoas;
    procedure Salvar;
    //
    property AfterDataChange: TProc read FAfterDataChange write SetAfterDataChange;
    property RecordState: TDataSetState read FRecordState;
    property BeforeLoadList: TProc read FBeforeLoadList write FBeforeLoadList;
    property AfterLoadList: TProc read FAfterLoadList write FAfterLoadList;
    property OnListScroll: TProc read FOnListScroll write FOnListScroll;
  end;

implementation

uses
  uADCompDataSet,
  System.UITypes,
  DelayableTask;

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

procedure TPessoaPresenter.CarregarRegistroDoBanco;
var
  LPessoa: TPessoa;
begin
  FView.ExibirMensagem('Carregando registro selecionado...', msLog);
  Sleep(2000); //Atraso artifical para simular busca no banco
  LPessoa := FService.ObterPorId( FDataSetLista.FieldByName('Id').AsInteger );
  //FService.GetCurrentFromDataset(FDataSetLista);
  FView.ExibirRegistro(LPessoa);
end;

constructor TPessoaPresenter.Create(AView: IViewPessoa);
begin
  FService := TPessoaService.Create;
  FView := AView;
  FRecordState := dsInactive;
end;

destructor TPessoaPresenter.Destroy;
begin
  if Assigned(FDataSetLista) then
    FreeAndNil(FDataSetLista);

  FService.Free;
  inherited;
end;

procedure TPessoaPresenter.Editar;
begin
  SetRecordState(dsEdit);
end;

procedure TPessoaPresenter.ExibirPessoaSelecionadaDaLista;
begin
  if not Assigned(FDataSetLista) then
    raise Exception.Create('Lista não carregada');

  if FDataSetLista.RecordCount = 0 then
    raise Exception.Create('Lista não possui registros em exibição');

  if RecordState in [dsInsert, dsEdit] then
    if FView.Perguntar('Descartar alterações?') = mrYes then
      Cancelar
    else
      Abort;

  TDelayableTask
    .GetInstance
    .OnCheckTimeOut(
        procedure (ACurrentTimeOut: Integer)
        begin
          TThread.Synchronize(nil,
            procedure
            begin
              FView.SetDelayTimeOut(ACurrentTimeOut);
            end);
        end
    )
    .Start(TIMEOUT_LOAD_LIST, CarregarRegistroDoBanco);
end;

procedure TPessoaPresenter.IniciarNovoRegistro;
begin
  FView.LimparControlesCadastro;
  SetRecordState(dsInsert);
end;

procedure TPessoaPresenter.ListarPessoas;
begin
  if Assigned(FDataSetLista) then
  begin
    FDataSetLista.DisableControls;
    FDataSetLista.Free;
  end;

  FDataSetLista := FService.GetDataSetLista;
  FView.SetDataSetLista(FDataSetLista);
end;

function TPessoaPresenter.ObterPessoaDaView: TPessoa;
begin
  Result := TPessoa.Create;
  Result.Id := FView.ObterId;
  Result.Nome := FView.ObterNome;
  Result.Idade := FView.ObterIdade;
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
  FView.HabilitarControlesCadastro((Value in [dsInsert, dsEdit]));
  FView.HabilitarControlesNavegar((Value in [dsBrowse]));
  FView.HabilitarControlesAcoes(Value);
  FRecordState := Value;
end;

end.

