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
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Data.DB,
  Vcl.DBGrids,
  Vcl.Samples.Spin,
  Comum.Types,
  Vcl.ComCtrls,
  Presenter.Pessoa,
  View.Pessoa.Interfaces,
  View.Interfaces,
  Presenter.PessoaListagem,
  System.Generics.Collections,
  Model.Entity.Pessoa,
  Datasnap.DBClient,
  DAO.Entity.Pessoa, Vcl.Mask;

type
  TfrmPessoaCadastroCompleto = class(TForm, IView, IViewPessoaCadastro, IViewPessoaListagem{, IViewSaldo})
    edtNome: TEdit;
    btnNovo: TButton;
    DBGridListagem: TDBGrid;
    lblId: TLabel;
    btnExcluir: TButton;
    btnSalvar: TButton;
    btnEditar: TButton;
    chkShowRecordOnScroll: TCheckBox;
    memLog: TMemo;
    pbLista: TProgressBar;
    cdsListagem: TClientDataSet;
    cdsListagemId: TIntegerField;
    cdsListagemNome: TStringField;
    cdsListagemIdade: TIntegerField;
    Button1: TButton;
    dsListagem: TDataSource;
    meDataNascimento: TMaskEdit;
    lblIdade: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure DBGridListagemDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dsListagemDataChange(Sender: TObject; Field: TField);
  private
    FPessoaPresenter: TPessoaPresenter;
    FPessoaListagemPresenter: TPessoaListagemPresenter;
    FTimerDelayLoadLista: TTimer;
    procedure RestartDelayList;
    function ObterId: Integer;
    function ObterPessoa: TPessoa;
    procedure InicializarPresenter;
    procedure ConfigurarTimerDelayLista;
    procedure NavigateToNextControl(var Key: Char);
    procedure ExibirPessoaSelecionadaDaLista;
    procedure OnTimeOut(Sender: TObject);
    procedure ExibirListagem(APessoaListagem: TArray<TPessoaListagem>);
    procedure Notificar(const AMensagem: string; AMessageSeverity: TMessageSeverity);
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure HabilitarControlesNavegar(ADataSetState: TDataSetState);
    procedure LimparControlesCadastro;
    function Perguntar(AMensagem: String): TModalResult;
    procedure Exibir;
  public
    constructor Create(AOwner: TComponent; APresenter: TPessoaPresenter); overload;
    constructor Create(AOwner: TComponent); overload; override;
    function AsView: IView;
    function ExibirExclusivo: TModalResult;

  end;

implementation

{$R *.dfm}

procedure TfrmPessoaCadastroCompleto.OnTimeOut(Sender: TObject);
begin
  FTimerDelayLoadLista.Enabled := False;
  ExibirPessoaSelecionadaDaLista;
end;

function TfrmPessoaCadastroCompleto.Perguntar(AMensagem: String): TModalResult;
begin
  Result := Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONQUESTION + MB_YESNO)
end;

function TfrmPessoaCadastroCompleto.ObterId: Integer;
begin
  Result := StrToIntDef(lblId.Caption, 0)
end;

function TfrmPessoaCadastroCompleto.ObterPessoa: TPessoa;
begin
  Result := TPessoa.Create;
  Result.Id := ObterId;
  Result.Nome := edtNome.Text;
  Result.DataNascimento := StrToDate(meDataNascimento.Text);
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
  FTimerDelayLoadLista.Interval := 300;
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
  FTimerDelayLoadLista:= TTimer.Create(Self);

  FPessoaPresenter := TPessoaPresenter.CreateFromView(Self, Self);
  InicializarPresenter;
end;

procedure TfrmPessoaCadastroCompleto.DBGridListagemDblClick(Sender: TObject);
begin
  ExibirPessoaSelecionadaDaLista;
end;

procedure TfrmPessoaCadastroCompleto.dsListagemDataChange(Sender: TObject; Field: TField);
begin
  RestartDelayList
end;

procedure TfrmPessoaCadastroCompleto.RestartDelayList;
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

procedure TfrmPessoaCadastroCompleto.ExibirListagem(APessoaListagem: TArray<TPessoaListagem>);
var
  LPessoa: TPessoaListagem;
begin
  cdsListagem.Close;
  cdsListagem.Open;

  for LPessoa in APessoaListagem do
  begin
    cdsListagem.Append;
    cdsListagemId.AsInteger := LPessoa.Id;
    cdsListagemNome.AsString := LPessoa.Nome;
    cdsListagemIdade.AsInteger := LPessoa.Idade;
    cdsListagem.Post;
  end;
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
begin
  try
    if FPessoaPresenter.RecordState in [dsInsert, dsEdit] then
      if Perguntar('Descartar alterações?') = mrYes then
        FPessoaPresenter.Cancelar
      else
        Abort;

    if not (cdsListagem.Active and (cdsListagem.RecordCount >0)) then
      Exit;

    FPessoaPresenter.CarregarId(cdsListagemId.AsInteger);
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
  meDataNascimento.Text := FormatDateTime('dd/mm/yyyy', APessoa.DataNascimento);
  lblIdade.Caption := APessoa.GetIdade.ToString + ' anos';
  Notificar('Registro carregado '+ QuotedStr(APessoa.Nome), msLog);
end;

procedure TfrmPessoaCadastroCompleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree
end;

procedure TfrmPessoaCadastroCompleto.FormCreate(Sender: TObject);
begin
  ConfigurarTimerDelayLista;
end;

procedure TfrmPessoaCadastroCompleto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTimerDelayLoadLista);
  FreeAndNil(FPessoaListagemPresenter);
  FreeAndNil(FPessoaPresenter);
end;

procedure TfrmPessoaCadastroCompleto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NavigateToNextControl(Key);
end;

procedure TfrmPessoaCadastroCompleto.FormShow(Sender: TObject);
begin
  FPessoaListagemPresenter.CarregarLista;
  dsListagem.Enabled := True;

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
  meDataNascimento.Enabled := AHabilitar;
end;

procedure TfrmPessoaCadastroCompleto.HabilitarControlesNavegar(ADataSetState: TDataSetState);
begin
  //DBNavigator habilita automaticamente
end;

procedure TfrmPessoaCadastroCompleto.InicializarPresenter;
begin
  FPessoaListagemPresenter := TPessoaListagemPresenter.Create(Self, Self);
  FPessoaPresenter.AfterDataChange := FPessoaListagemPresenter.CarregarLista;
  FPessoaPresenter.OnStateChange := HabilitarControlesNavegar;
end;

procedure TfrmPessoaCadastroCompleto.LimparControlesCadastro;
begin
  lblId.Caption := '';
  edtNome.Text := TPessoa.DEFAULT_NOME;
  meDataNascimento.Clear;
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
