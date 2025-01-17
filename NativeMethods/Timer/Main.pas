unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btStartStop: TButton;
    lblHorario: TLabel;
    procedure btStartStopClick(Sender: TObject);
  private
    { Private declarations }
    FActive: Boolean;
    const
      MY_TIMER_ID = 20240905;
      CAPTIONS: array[Boolean] of string = ('Start', 'Stop');

    procedure SwitchTimer(TimerID: Integer; Intervalo: Integer; Ativado: Boolean);
    procedure TimerMensagem(var Msg: TWMTimer); message WM_TIMER;
    procedure Atualizarhorario;
    procedure UpdateButtonCaption;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Atualizarhorario;
begin
  lblHorario.Caption := FormatDateTime('HH:MM:SS', Now)
end;

procedure TForm1.btStartStopClick(Sender: TObject);
begin
  Atualizarhorario;
  FActive := not FActive;
  SwitchTimer(MY_TIMER_ID, 1000, FActive);
  UpdateButtonCaption;
end;

procedure TForm1.SwitchTimer(TimerID, Intervalo: Integer; Ativado: Boolean);
begin
  if Ativado then
    SetTimer(Handle, TimerID, Intervalo, nil)
  else
    KillTimer(Handle, TimerID);
end;

procedure TForm1.TimerMensagem(var Msg: TWMTimer);
begin
  Atualizarhorario
end;

procedure TForm1.UpdateButtonCaption;
begin
  btStartStop.Caption := CAPTIONS[FActive]
end;

end.
