program MVPDemo;

uses
  Vcl.Forms,
  Model.Entity.Pessoa in 'Model\Entity\Model.Entity.Pessoa.pas',
  Model.DAO.Pessoa.Interfaces in 'Model\Model.DAO.Pessoa.Interfaces.pas',
  Model.DAO.Pessoa.Memory in 'Model\Model.DAO.Pessoa.Memory.pas',
  Model.Service.Pessoa in 'Model\Model.Service.Pessoa.pas',
  Presenter.Pessoa in 'Presenter\Presenter.Pessoa.pas',
  Vew.Main in 'View\Vew.Main.pas' {frmMain},
  View.PessoaCadastroCompleto in 'View\View.PessoaCadastroCompleto.pas' {frmPessoaCadastroCompleto},
  Model.Database.Constants in 'Model\Model.Database.Constants.pas',
  Model.DAO.Pessoa.Factory in 'Model\Model.DAO.Pessoa.Factory.pas',
  View.Pessoa.Interfaces in 'View\View.Pessoa.Interfaces.pas',
  Model.Entity.Pessoa.List in 'Model\Entity\Model.Entity.Pessoa.List.pas',
  Model.DAO.Pessoa.Memory.Constants in 'Model\Model.DAO.Pessoa.Memory.Constants.pas',
  Model.DAO.Pessoa.Dataset in 'Model\Model.DAO.Pessoa.Dataset.pas',
  Comum.Constants in 'Comum\Comum.Constants.pas',
  DelayableTask in 'Comum\DelayableTask.pas',
  View.PessoaPesquisa in 'View\View.PessoaPesquisa.pas' {frmPessoaPesquisa},
  View.PessoaCadastro in 'View\View.PessoaCadastro.pas' {frmPessoaCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
