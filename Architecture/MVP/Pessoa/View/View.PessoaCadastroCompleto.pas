unit View.PessoaCadastroCompleto;

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
  Vcl.StdCtrls,
  Vcl.Grids,
  uADStanIntf, uADStanOption,
  uADStanParam,
  uADStanError,
  uADDatSManager,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Data.DB,
  uADCompClient,
  Vcl.DBGrids,
  Vcl.Samples.Spin,
  Model.Entity.Pessoa,
  JvDataSource,
  uADGUIxIntf,
  uADGUIxFormsWait,
  uADCompGUIx,
  Comum.Types,
  Vcl.ComCtrls,
  Presenter.Pessoa,
  View.Pessoa.Interfaces,
  View.Interfaces,
  Presenter.PessoaDataset;

type
  TfrmPessoaCadastroCompleto = class(TForm, IView, IViewPessoaCadastro, IViewPessoaDataSet{, IViewSaldo})
    edtNome: TEdit;
    btnNovo: TButton;
    DBGrid1: TDBGrid;
    dbnavLista: TDBNavigator;
    lblId: TLabel;
    spnedtIdade: TSpinEdit;
    dsLista: TJvDataSource;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnEditar: TButton;
    chkShowRecordOnScroll: TCheckBox;
    ADGUIxWaitCursor1: TADGUIxWaitCursor;
    memLog: TMemo;
    pbLista: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsListaDataSetScrolled(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FPessoaPresenter: TPessoaPresenter;
    FPessoaDatasetPresenter: TPessoaDatasetPresenter;
    FMemTableLista: TADMemTable;
    FTimerDelayLoadLista: TTimer;
    procedure InicializarPresenter;
    procedure ConfigurarTimerDelayLista;
    procedure NavigateToNextControl(var Key: Char);
    procedure ExibirPessoaSelecionadaDaLista;
    procedure OnTimeOut(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; APresenter: TPessoaPresenter); overload;
    constructor Create(AOwner: TComponent); overload; override;
    function AsView: IView;
    function DataSetLista: TDataSet;
    function ExibirExclusivo: TModalResult;
    function ObterId: Integer;
    function ObterIdade: Integer;
    function ObterNome: string;
    function Perguntar(AMensagem: String): TModalResult;
    procedure Exibir;

    procedure Notificar(const AMensagem: string; AMessageSeverity: TMessageSeverity);
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure HabilitarControlesNavegar(ADataSetState: TDataSetState);
    procedure LimparControlesCadastro;
    procedure SetDataSetLista(ADataSet: TDataSet);
  end;

implementation

{$R *.dfm}

function TfrmPessoaCadastroCompleto.ObterNome: string;
begin
  Result := edtNome.Text;
end;

procedure TfrmPessoaCadastroCompleto.OnTimeOut(Sender: TObject);
begin
  FTimerDelayLoadLista.Enabled := False;
  ExibirPessoaSelecionadaDaLista;
end;

function TfrmPessoaCadastroCompleto.Perguntar(AMensagem: String): TModalResult;
begin
  Result := Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONQUESTION + MB_YESNO)
end;

procedure TfrmPessoaCadastroCompleto.SetDataSetLista(ADataSet: TDataSet);
begin
  FMemTableLista := TADMemTable(ADataSet);
  dsLista.DataSet := FMemTableLista;
end;

function TfrmPessoaCadastroCompleto.ObterId: Integer;
begin
  Result := StrToIntDef(lblId.Caption, 0)
end;

function TfrmPessoaCadastroCompleto.ObterIdade: Integer;
begin
  Result := spnedtIdade.Value;
end;

function TfrmPessoaCadastroCompleto.AsView: IView;
begin
  Result:= Self;
end;

procedure TfrmPessoaCadastroCompleto.btnEditarClick(Sender: TObject);
begin
  FPessoaPresenter.Editar;
  edtNome.SetFocus;
end;

procedure TfrmPessoaCadastroCompleto.btnExcluirClick(Sender: TObject);
begin
  FPessoaPresenter.Excluir(ObterId);
end;

procedure TfrmPessoaCadastroCompleto.btnNovoClick(Sender: TObject);
begin
  FPessoaPresenter.IniciarNovoRegistro;
  edtNome.SetFocus;
end;

procedure TfrmPessoaCadastroCompleto.btnSalvarClick(Sender: TObject);
begin
  FPessoaPresenter.Salvar;
end;

procedure TfrmPessoaCadastroCompleto.ConfigurarTimerDelayLista;
begin
  FTimerDelayLoadLista.Interval := 600;
  FTimerDelayLoadLista.Enabled := False;
  FTimerDelayLoadLista.OnTimer := OnTimeOut;
end;

constructor TfrmPessoaCadastroCompleto.Create(AOwner: TComponent; APresenter: TPessoaPresenter);
begin
  inherited Create(AOwner);
  FPessoaPresenter := APresenter;
  InicializarPresenter;
end;

constructor TfrmPessoaCadastroCompleto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPessoaPresenter := TPessoaPresenter.CreateFromView(Self, Self);
  InicializarPresenter;
end;

function TfrmPessoaCadastroCompleto.DataSetLista: TDataSet;
begin
  Result := dsLista.DataSet;
end;

procedure TfrmPessoaCadastroCompleto.DBGrid1DblClick(Sender: TObject);
begin
  ExibirPessoaSelecionadaDaLista;
end;

procedure TfrmPessoaCadastroCompleto.dsListaDataSetScrolled(Sender: TObject);
begin
  if chkShowRecordOnScroll.Checked then
  begin
    FTimerDelayLoadLista.Enabled:= False;
    FTimerDelayLoadLista.Enabled:= True;
  end;
end;

procedure TfrmPessoaCadastroCompleto.Exibir;
begin
  Self.Show
end;

function TfrmPessoaCadastroCompleto.ExibirExclusivo: TModalResult;
begin
  Result := Self.ShowModal;
end;

procedure TfrmPessoaCadastroCompleto.Notificar(const AMensagem: string; AMessageSeverity: TMessageSeverity);
begin
  case AMessageSeverity of
    msLog:
      memLog.Lines.Add(Format('[%s] - %s', [FormatDateTime('yyyy-mm-dd HH:MM.SS', Now) , AMensagem]));

    msInformation:
      Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONINFORMATION + MB_OK);

    msWarning:
      Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONWARNING + MB_OK);

    msError:
      Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONERROR + MB_OK);

    msFatal:
      Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONSTOP + MB_OK);
  end;
end;

procedure TfrmPessoaCadastroCompleto.ExibirPessoaSelecionadaDaLista;
var
  LPessoa: TPessoa;
begin
  try
    if FPessoaPresenter.RecordState in [dsInsert, dsEdit] then
      if Perguntar('Descartar alterações?') = mrYes then
        FPessoaPresenter.Cancelar
      else
        Abort;

    LPessoa:= FPessoaDatasetPresenter.ObterPessoaDaLista;
    try
      ExibirRegistro(LPessoa);
    finally
      LPessoa.Free;
    end;
  except
    on e: EAbort do
      Exit;
  else
    raise;
  end;
end;

procedure TfrmPessoaCadastroCompleto.ExibirRegistro(APessoa: TPessoa);
begin
  lblId.Caption := InTToStr(APessoa.Id);
  edtNome.Text := APessoa.Nome;
  spnedtIdade.Value := APessoa.Idade;
  Notificar('Registro carregado '+ QuotedStr(APessoa.Nome), msLog);
end;

procedure TfrmPessoaCadastroCompleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree
end;

procedure TfrmPessoaCadastroCompleto.FormCreate(Sender: TObject);
begin
  FMemTableLista := nil;
  FTimerDelayLoadLista:= TTimer.Create(Self);
  ConfigurarTimerDelayLista;
end;

procedure TfrmPessoaCadastroCompleto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTimerDelayLoadLista);
  FreeAndNil(FPessoaDataSetPresenter);
  FreeAndNil(FPessoaPresenter);
end;

procedure TfrmPessoaCadastroCompleto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NavigateToNextControl(Key);
end;

procedure TfrmPessoaCadastroCompleto.FormShow(Sender: TObject);
begin
  FPessoaDatasetPresenter.CarregarLista;
  HabilitarControlesCadastro(False);
  HabilitarControlesAcoes(dsBrowse);
end;

procedure TfrmPessoaCadastroCompleto.HabilitarControlesAcoes(ARecordState: TDataSetState);
begin
  btnNovo.Enabled := (ARecordState = dsBrowse);
  btnSalvar.Enabled := (ARecordState in [dsInsert, dsEdit]);
  btnEditar.Enabled := (ARecordState = dsBrowse);
  btnExcluir.Enabled := (ARecordState = dsBrowse);
end;

procedure TfrmPessoaCadastroCompleto.HabilitarControlesCadastro(AHabilitar: Boolean);
begin
  edtNome.Enabled := AHabilitar;
  spnedtIdade.Enabled := AHabilitar;
end;

procedure TfrmPessoaCadastroCompleto.HabilitarControlesNavegar(ADataSetState: TDataSetState);
begin
  //DBNavigator habilita automaticamente
end;

procedure TfrmPessoaCadastroCompleto.InicializarPresenter;
begin
  FPessoaDatasetPresenter := TPessoaDatasetPresenter.Create(Self, Self);
  FPessoaPresenter.AfterDataChange := FPessoaDatasetPresenter.CarregarLista;
  FPessoaPresenter.OnStateChange := HabilitarControlesNavegar;
end;

procedure TfrmPessoaCadastroCompleto.LimparControlesCadastro;
begin
  lblId.Caption := '';
  edtNome.Text := TPessoa.DEFAULT_NOME;
  spnedtIdade.Value := TPessoa.DEFAULT_IDADE;
end;

procedure TfrmPessoaCadastroCompleto.NavigateToNextControl(var Key: Char);
begin
  if Key = #13 then // tecla 'Enter'
  begin
    Key := #0; // Suprime o som do "beep"
    SelectNext(ActiveControl, True, True);
  end;
end;

end.
