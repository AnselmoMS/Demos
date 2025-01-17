program GenericListProj;

uses
  Vcl.Forms,
  GenericListDEMO in 'GenericListDEMO.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
