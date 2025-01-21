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
  View.Interfaces,
  Presenter.Pessoa.Types;

type
  TPessoaPresenter = class
  private
  var
    FAfterDataChange: TProc;
    FRecordState: TDataSetState;
    FService: TPessoaService;
    FView: IView;
    FViewCadastro: IViewPessoaCadastro;
    FOnStateChange: TProc<TDataSetState>;
    procedure ExecuteAfterDataChange;
    function ObterPessoaDaView: TPessoa;
    procedure SetAfterDataChange(const Value: TProc);
    procedure SetRecordState(const Value: TDataSetState);
    procedure SetOnStateChange(const Value: TProc<TDataSetState>);
  public
    constructor CreateFromView(AView: IView; AViewPessoa: IViewPessoaCadastro);
    constructor Create(AViewStyle: TPessoaViewStyle);
    destructor Destroy; override;
    //
    procedure Cancelar;
    procedure Editar;
    procedure Excluir(AId: Integer);
    procedure IniciarNovoRegistro;
    procedure Salvar;
    procedure CarregarId(AId: Integer);
    //
    procedure ExibirView;
    //
    property AfterDataChange: TProc read FAfterDataChange write SetAfterDataChange;
    property RecordState: TDataSetState read FRecordState;
    property OnStateChange: TProc<TDataSetState> read FOnStateChange write SetOnStateChange;
  end;

implementation

uses
  uADCompDataSet,
  System.UITypes,
  Presenter.Pessoa.ViewFactory;

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

procedure TPessoaPresenter.ExibirView;
begin
  FView.Exibir;
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
  FViewCadastro.ExibirRegistro(LPessoa);
end;

constructor TPessoaPresenter.Create(AViewStyle: TPessoaViewStyle);
begin
  case AViewStyle of
    pvsCompleto:
    begin
      FViewCadastro:= TPessoaViewFactory.ObterViewCadastroCompleto(Self);
      FView:= FViewCadastro.AsView;
    end;

    pvsSomenteCadastro:
    begin
      FViewCadastro:= TPessoaViewFactory.ObterViewCadastro(Self);
      FView:= FViewCadastro.AsView;
    end;
  end;
end;

constructor TPessoaPresenter.CreateFromView(AView: IView; AViewPessoa: IViewPessoaCadastro);
begin
  FService := TPessoaService.Create;
  FView := AView;
  FViewCadastro := AViewPessoa;
  SetRecordState(dsInactive);
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
  FViewCadastro.LimparControlesCadastro;
  SetRecordState(dsInsert);
end;

function TPessoaPresenter.ObterPessoaDaView: TPessoa;
begin
  Result := TPessoa.Create;
  Result.Id := FViewCadastro.ObterId;
  Result.Nome := FViewCadastro.ObterNome;
  Result.Idade := FViewCadastro.ObterIdade;
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

procedure TPessoaPresenter.SetOnStateChange(const Value: TProc<TDataSetState>);
begin
  FOnStateChange := Value;
end;

procedure TPessoaPresenter.SetRecordState(const Value: TDataSetState);
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(Value);

  FViewCadastro.HabilitarControlesCadastro((Value in [dsInsert, dsEdit]));
  FViewCadastro.HabilitarControlesAcoes(Value);
  FRecordState := Value;
end;

end.

