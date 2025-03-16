unit Presenter.Pessoa;

interface

uses
  DAO.Entity.Pessoa,
  View.Pessoa.Interfaces,
  Data.DB,
  Comum.Types,
  System.SysUtils,
  System.Classes,
  View.Interfaces,
  Presenter.Pessoa.Types,
  Model.Entity.Pessoa,
  Model.Pessoa.Service;

type
  TPessoaPresenter = class
  private
  var
    FAfterDataChange: TProc;
    FRecordState: TDataSetState;
    FPessoaService: TPessoaService;
    FView: IView;
    FViewCadastro: IViewPessoaCadastro;
    FOnStateChange: TProc<TDataSetState>;
    FDBDelay: Integer;
    procedure ExecuteAfterDataChange;
    procedure SetAfterDataChange(const Value: TProc);
    procedure SetRecordState(const Value: TDataSetState);
    procedure SetOnStateChange(const Value: TProc<TDataSetState>);
    procedure SetDBDelay(const Value: Integer);
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
    property DBDelay: Integer read FDBDelay write SetDBDelay;
  end;

implementation

uses
  System.UITypes,
  Presenter.Pessoa.ViewFactory,
  DAO.Pessoa.Adapter;

procedure TPessoaPresenter.Excluir(AId: Integer);
begin
  if FRecordState in dsEditModes then
    raise Exception.Create('Não é possível excluir registro em edição!');

  FPessoaService.Excluir(AId);
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
  FView.Notificar('Carregando registro selecionado...', msLog);

  Sleep(FDBDelay); //Atraso artifical para simular busca no banco

  LPessoa := FPessoaService.ObterPorId(AId);
  try
    FViewCadastro.ExibirRegistro(LPessoa);
  finally
    LPessoa.Free;
  end;
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
  FPessoaService := TPessoaService.Create;
  FView := AView;
  FViewCadastro := AViewPessoa;
  SetRecordState(dsInactive);
end;

destructor TPessoaPresenter.Destroy;
begin
  FreeAndNil(FPessoaService);
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

procedure TPessoaPresenter.Salvar;
var
  LPessoa: TPessoa;
begin
  LPessoa:= FViewCadastro.ObterPessoa;
  try
    try
      case RecordState of
        dsEdit:
         FPessoaService.Atualizar(LPessoa);

        dsInsert:
         FPessoaService.Adicionar(LPessoa);
      else
        raise Exception.Create('Registro não disponível para salvar!');
      end;

      SetRecordState(dsBrowse);

      FView.Notificar('Pessoa registrada com sucesso!', msLog);
      FView.Notificar('Pessoa registrada com sucesso!', msInformation);

      ExecuteAfterDataChange;
    Except
      on e: Exception do
      begin
        FView.Notificar(E.Message, msError);
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

procedure TPessoaPresenter.SetDBDelay(const Value: Integer);
begin
  FDBDelay := Value;
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

