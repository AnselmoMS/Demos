unit View.Main;

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
  System.Generics.Collections,
  ShortcutManager;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Edit5: TEdit;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FKeyManager: TShortcutManager;
    procedure AtalhoAjuda(var AKey: Word);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ShortcutManager.Helpers,
  ShortcutManager.Types;

{$R *.dfm}

procedure TForm1.AtalhoAjuda(var AKey: Word);
begin
  Application.MessageBox(PChar('Essa é toda ajuda que posso dar agora!'), Pchar('Ajuda'), MB_ICONQUESTION + MB_OK)
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('botão acionado');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FKeyManager :=
    TShortcutManager.Create(Self)
      //F1 Globa no Form
      .AddKeyDown
        .SetKey(VK_F1)
        .SetShifts([[]])
        .SetAction(AtalhoAjuda)
        .Apply

      .AddKeyDown
        .SetKey(VK_UP)
        .SetShifts([[]])
        .SetActionKind(kdaFocusPreviousControl)
        .SetAllowClasses([TEdit])
        .Apply

      .AddKeyDown
        .SetKey(VK_DOWN)
        .SetShifts([[]])
        .SetActionKind(kdaFocusNextControl)
        .SetAllowClasses([TEdit])
        .Apply

      .AddKeyDown
        .SetKey(VK_RETURN)
        .SetShifts([[ssCtrl]])
        .SetAction(
          procedure (var AKey: Word)
          begin
            ShowMessage('Mensagem do Edit 5');
          end)
        .SetAllowControls([Edit1])
        .SetValidator(
          function: Boolean
          begin
            if Edit1.Text = EmptyStr then
              ShowMessage('Mensagem do Edit 1 Vazio');
          end)
        .Apply

      //CTRL + Enter - No Edit 5
      .AddKeyDown
        .SetKey(VK_RETURN)
        .SetShifts([[ssCtrl]])
        .SetAction(
          procedure (var AKey: Word)
          begin
            ShowMessage('Mensagem do Edit 5');
          end)
        .SetAllowControls([Edit5])
        .Apply

      //CTRL + Enter - Em TMemo
      .AddKeyDown
        .SetKey(VK_RETURN)
        .SetShifts([[ssCtrl]])
        .SetActionKind(kdaFocusNextControl)
        .SetAllowClasses([TMemo])
        .Apply


      //Suprimir beep do Enter em Edits (precisa ser antes de mudar o Active Control abaixo)
      .AddKeyPress
        .SetKeys([#13])
        .SetShifts([[]])  //Informe explicitamente [] = Sem taclas ctrl/Shift... presionadas
        .SetActionKind(kpaSupressKey)
        .SetAllowClasses([TEdit])
        .Apply
      //Mudar foco para próximo controle
      .AddKeyPress
        .SetKeys([#13])
        .SetShifts([[]]) //Informe explicitamente [] = Sem taclas ctrl/Shift... presionadas
        .SetActionKind(kpaFocusNextControl)
        .SetAllowClasses([TEdit])
        .Apply

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FKeyManager.Free;
end;

end.
