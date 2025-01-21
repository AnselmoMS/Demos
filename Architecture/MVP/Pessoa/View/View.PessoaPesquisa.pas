unit View.PessoaPesquisa;

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
  Vcl.DBGrids,
  Data.DB,
  Presenter.Pessoa,
  View.Pessoa.Interfaces;

type
  TfrmPessoaPesquisa = class(TForm{, IViewPessoaDataset})
    dbgridResultado: TDBGrid;
    edtNome: TEdit;
    Edit2: TEdit;
    btnPesquisar: TButton;
    dsResultado: TDataSource;
    procedure dbgridResultadoDblClick(Sender: TObject);
  private
    //FPresenter: TPessoaPresenter;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmPessoaPesquisa.dbgridResultadoDblClick(Sender: TObject);
begin
  //FPresenter.ExibirPessoaSelecionadaDaLista;
end;

end.
