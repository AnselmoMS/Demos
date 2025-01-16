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
  View.Pessoa.Interfaces,
  uADStanIntf, uADStanOption,
  uADStanParam,
  uADStanError,
  uADDatSManager,
  uADPhysIntf,
  uADDAptIntf,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Data.DB,
  uADCompDataSet,
  uADCompClient,
  Vcl.DBGrids,
  Presenter.Pessoa,
  Vcl.Samples.Spin,
  Model.Entity.Pessoa,
  JvDataSource,
  uADGUIxIntf,
  uADGUIxFormsWait,
  uADCompGUIx,
  Comum.Constants, Vcl.ComCtrls;

type
  TfrmPessoaCadastroCompleto = class(TForm, IViewPessoa)
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
    FPresenter: TPessoaPresenter;
    FMemTableLista: TADMemTable;
    procedure NavigateToNextControl(var Key: Char);
  public
    function DataSetLista: TDataSet;
    function ObterId: Integer;
    function ObterIdade: Integer;
    function ObterNome: string;
    function Perguntar(AMensagem: String): TModalResult;
    procedure ExibirMensagem(const AMensagem: string; AMessageSeverity: TMessageSeverity);
    procedure ExibirRegistro(APessoa: TPessoa);
    procedure HabilitarControlesAcoes(ARecordState: TDataSetState);
    procedure HabilitarControlesCadastro(AHabilitar: Boolean);
    procedure HabilitarControlesNavegar(AHabilitar: Boolean);
    procedure LimparControlesCadastro;
    procedure SetDataSetLista(ADataSet: TDataSet);

    procedure ResetDelayLoadList;
    procedure SetDelayTimeOut(ACurrentTimeOut: Integer);
  end;

implementation

{$R *.dfm}

function TfrmPessoaCadastroCompleto.ObterNome: string;
begin
  Result := edtNome.Text;
end;

function TfrmPessoaCadastroCompleto.Perguntar(AMensagem: String): TModalResult;
begin
  Result := Application.MessageBox(PChar(AMensagem), PChar(Self.Caption), MB_ICONQUESTION + MB_YESNO)
end;

procedure TfrmPessoaCadastroCompleto.ResetDelayLoadList;
begin
  pbLista.Position := 0;
end;

procedure TfrmPessoaCadastroCompleto.SetDataSetLista(ADataSet: TDataSet);
begin
  FMemTableLista := TADMemTable(ADataSet);
  dsLista.DataSet := FMemTableLista;
end;

procedure TfrmPessoaCadastroCompleto.SetDelayTimeOut(ACurrentTimeOut: Integer);
begin
  pbLista.Position := ACurrentTimeOut;
end;

function TfrmPessoaCadastroCompleto.ObterId: Integer;
begin
  Result := StrToIntDef(lblId.Caption, 0)
end;

function TfrmPessoaCadastroCompleto.ObterIdade: Integer;
begin
  Result := spnedtIdade.Value;
end;

procedure TfrmPessoaCadastroCompleto.btnEditarClick(Sender: TObject);
begin
  FPresenter.Editar;
  edtNome.SetFocus;
end;

procedure TfrmPessoaCadastroCompleto.btnExcluirClick(Sender: TObject);
begin
  FPresenter.Excluir(ObterId);
end;

procedure TfrmPessoaCadastroCompleto.btnNovoClick(Sender: TObject);
begin
  FPresenter.IniciarNovoRegistro;
  edtNome.SetFocus;
end;

procedure TfrmPessoaCadastroCompleto.btnSalvarClick(Sender: TObject);
begin
  FPresenter.Salvar;
end;

function TfrmPessoaCadastroCompleto.DataSetLista: TDataSet;
begin
  Result := dsLista.DataSet;
end;

procedure TfrmPessoaCadastroCompleto.DBGrid1DblClick(Sender: TObject);
begin
  FPresenter.ExibirPessoaSelecionadaDaLista;
end;

procedure TfrmPessoaCadastroCompleto.dsListaDataSetScrolled(Sender: TObject);
begin
  if chkShowRecordOnScroll.Checked then
  begin
    try
      pbLista.Visible := True;
      FPresenter.ExibirPessoaSelecionadaDaLista;
    except
      on e: EAbort do
        Exit;
    else
      raise;
    end;
  end;
end;

procedure TfrmPessoaCadastroCompleto.ExibirMensagem(const AMensagem: string; AMessageSeverity: TMessageSeverity);
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

procedure TfrmPessoaCadastroCompleto.ExibirRegistro(APessoa: TPessoa);
begin
  lblId.Caption := InTToStr(APessoa.Id);
  edtNome.Text := APessoa.Nome;
  spnedtIdade.Value := APessoa.Idade;
  ExibirMensagem('Registro carregado '+ QuotedStr(APessoa.Nome), msLog);
end;

procedure TfrmPessoaCadastroCompleto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree
end;

procedure TfrmPessoaCadastroCompleto.FormCreate(Sender: TObject);
begin
  FPresenter := TPessoaPresenter.Create(Self);
  FPresenter.AfterDataChange := FPresenter.ListarPessoas;
  FMemTableLista := nil;
end;

procedure TfrmPessoaCadastroCompleto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FPresenter);
end;

procedure TfrmPessoaCadastroCompleto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  NavigateToNextControl(Key);
end;

procedure TfrmPessoaCadastroCompleto.FormShow(Sender: TObject);
begin
  FPresenter.ListarPessoas;
  HabilitarControlesCadastro(False);
  HabilitarControlesAcoes(dsBrowse);
  pbLista.Max := FPresenter.TIMEOUT_LOAD_LIST;
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

procedure TfrmPessoaCadastroCompleto.HabilitarControlesNavegar(AHabilitar: Boolean);
begin
  //DBNavigator habilita automaticamente
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
