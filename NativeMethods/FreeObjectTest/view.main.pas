unit view.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMinhaClasse = class
  public
  var
    Id: Integer;
  end;

  TForm1 = class(TForm)
    btnLocalNonNil: TButton;
    btnFreeAndNil: TButton;
    btnFreeAndNilAfterFree: TButton;
    btnLocalNil: TButton;
    btnLocalFree: TButton;
    btnSafeRecreate: TButton;
    procedure btnLocalNonNilClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFreeAndNilClick(Sender: TObject);
    procedure btnFreeAndNilAfterFreeClick(Sender: TObject);
    procedure btnLocalNilClick(Sender: TObject);
    procedure btnLocalFreeClick(Sender: TObject);
    procedure btnSafeRecreateClick(Sender: TObject);
  private
    { Private declarations }
    btPrivate,
    btPrivateNil,
    btPrivateNonInicialized: Tbutton;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnLocalNonNilClick(Sender: TObject);
var
  btLocal: TButton; //Inicializa <> nil
begin
  FreeAndNil(btLocal); //Error: Access Violation
end;

procedure TForm1.btnSafeRecreateClick(Sender: TObject);
var
  LLocal: TButton;
begin
  if btPrivateNonInicialized <> nil then
    FreeAndNil(btPrivateNonInicialized);
  btPrivateNonInicialized := TButton.Create(Self);

  LLocal := Nil;
  if LLocal <> nil then
    FreeAndNil(LLocal);
end;

procedure TForm1.btnFreeAndNilAfterFreeClick(Sender: TObject);
begin
  btPrivate.Free;
  FreeAndNil(btPrivate); //Invalid Pointer operation
end;

procedure TForm1.btnFreeAndNilClick(Sender: TObject);
begin
  FreeAndNil(btPrivateNil); // OK
end;

procedure TForm1.btnLocalFreeClick(Sender: TObject);
var
  LLocal: TMinhaClasse; //Inicializa <> nil
begin
  LLocal:= TMinhaClasse.Create();
  LLocal.Id := 1;
  LLocal.Free;

  if Assigned(LLocal) then //Eh Assigned [Not nil]
    FreeAndNil(LLocal);    //Invalid Pointer operation
end;

procedure TForm1.btnLocalNilClick(Sender: TObject);
var
  btLocal: TButton; //Inicializa <> nil
begin
  btLocal:= nil;
  FreeAndNil(btLocal); //Invalid Pointer operation
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  btPrivateNil := nil;
  btPrivate := TButton.Create(Self);
end;

end.
