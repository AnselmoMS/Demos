unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  {Vcl.Controls,} Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Controls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function CustomMessage(const AMessageText: string; ADialogType: TMsgDlgType; AButtons: TMsgDlgButtons; ACaption: array of string; ATitle: string): Integer;
var
  Dialog: TForm;
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  Dialog := CreateMessageDialog(AMessageText, ADialogType, AButtons);
  Dialog.Caption := ATitle;
  Dialog.BiDiMode := bdRightToLeft;
  Captionindex := 0;
  for i := 0 to Dialog.componentcount - 1 Do
  begin
    if (Dialog.components[i] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(Dialog.components[i]);
      if Captionindex <= High(ACaption) then
        Dlgbutton.Caption := ACaption[Captionindex];
      inc(Captionindex);
    end;
  end;
  Result := Dialog.Showmodal;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //MessageDlg('Mensagem simples usando "MessageDlg".', mtInformation, [mbCancel, mbOK], 0);

  //MessageBox(Handle, PChar('Mensagem simples usando "MessageDlg".'), 'Título', MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2);

  CustomMessage('Mensagem personalizada', mtCustom, [mbYes, mbNo], ['É claro','Deuzulive'], 'New MessageDlg Box');
end;

end.
