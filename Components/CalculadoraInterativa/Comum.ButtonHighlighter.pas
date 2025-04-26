unit Comum.ButtonHighlighter;

interface

uses
  System.Classes,
  VCL.StdCtrls;

type
  TButtonHighlighter = class(TThread)
  private
    FBotao: TButton;
  protected
    procedure Execute; override;
    procedure Press;
    procedure Up;
  public
    constructor Create(AButton: TButton);
  end;

implementation

uses
  WinApi.Messages,
  WinApi.Windows;

{ TButtonHighlighter }

constructor TButtonHighlighter.Create(AButton: TButton);
begin
  inherited Create(False); // False = já inicia a thread
  FreeOnTerminate := True;
  FBotao := AButton;
end;

procedure TButtonHighlighter.Execute;
begin
  Synchronize(Press);
  Sleep(100);
  Synchronize(Up);
end;

procedure TButtonHighlighter.Press;
begin
  if Assigned(FBotao) then
    FBotao.Perform(BM_SETSTATE, WPARAM(1), 0);
end;

procedure TButtonHighlighter.Up;
begin
  if Assigned(FBotao) then
    FBotao.Perform(BM_SETSTATE, WPARAM(0), 0);
end;

end.
