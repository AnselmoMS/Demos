program FormKeyDownSelectiveDEMO;

uses
  {$IFDEF EurekaLog}
  EMemLeaks,
  EResLeaks,
  EDebugJCL,
  EDebugExports,
  EFixSafeCallException,
  EMapWin32,
  EAppVCL,
  EDialogWinAPIMSClassic,
  EDialogWinAPIEurekaLogDetailed,
  EDialogWinAPIStepsToReproduce,
  ExceptionLog7,
  {$ENDIF EurekaLog}
  Vcl.Forms,
  View.Main in 'View.Main.pas' {Form1},
  ShortcutManager in 'ShortcutManager.pas',
  ShortcutManager.TemplateFactory in 'ShortcutManager.TemplateFactory.pas',
  ShortcutManager.Types in 'ShortcutManager.Types.pas',
  ShortcutManager.Helpers in 'ShortcutManager.Helpers.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.



