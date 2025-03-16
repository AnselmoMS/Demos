program MVPDemo;

uses
  Vcl.Forms,
  Presenter.Pessoa in 'Presenter\Presenter.Pessoa.pas',
  Vew.Main in 'View\Vew.Main.pas' {frmMain},
  View.PessoaCadastroCompleto in 'View\View.PessoaCadastroCompleto.pas' {frmPessoaCadastroCompleto},
  View.Pessoa.Interfaces in 'View\View.Pessoa.Interfaces.pas',
  Comum.Types in 'Comum\Comum.Types.pas',
  View.PessoaPesquisa in 'View\View.PessoaPesquisa.pas' {frmPessoaPesquisa},
  View.PessoaCadastro in 'View\View.PessoaCadastro.pas' {frmPessoaCadastro},
  View.Interfaces in 'View\View.Interfaces.pas',
  Presenter.PessoaListagem in 'Presenter\Presenter.PessoaListagem.pas',
  Presenter.Pessoa.ViewFactory in 'Presenter\Presenter.Pessoa.ViewFactory.pas',
  Presenter.Pessoa.Types in 'Presenter\Presenter.Pessoa.Types.pas',
  DAO.Pessoa.Factory in 'DAO\Pessoa\DAO.Pessoa.Factory.pas',
  DAO.Pessoa.Interfaces in 'DAO\Pessoa\DAO.Pessoa.Interfaces.pas',
  DAO.Pessoa.Memory.Constants in 'DAO\Pessoa\DAO.Pessoa.Memory.Constants.pas',
  DAO.Pessoa.Memory in 'DAO\Pessoa\DAO.Pessoa.Memory.pas',
  DAO.Pessoa.Repository in 'DAO\Pessoa\DAO.Pessoa.Repository.pas',
  DAO.Database.Constants in 'DAO\DAO.Database.Constants.pas',
  DAO.Entity.Pessoa.List in 'DAO\Pessoa\DAO.Entity.Pessoa.List.pas',
  DAO.Entity.Pessoa in 'DAO\Pessoa\DAO.Entity.Pessoa.pas',
  Model.Entity.Pessoa in 'Model\Entity\Model.Entity.Pessoa.pas',
  DAO.Pessoa.Adapter in 'DAO\Pessoa\DAO.Pessoa.Adapter.pas',
  Model.Pessoa.Service in 'Model\Model.Pessoa.Service.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
