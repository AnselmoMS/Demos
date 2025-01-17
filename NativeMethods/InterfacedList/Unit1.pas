unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Generics.Collections;

type
  IMinhaInterface = interface
  end;

  TMinhaClasse = class(TInterfacedObject, IMinhaInterface)
  end;


  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FLista: TList<IMinhaInterface>;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Mi: IMinhaInterface;
begin
  mi := TMinhaClasse.Create;
  FLista.Add(mi);

  mi := TMinhaClasse.Create;
  FLista.Add(mi);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FLista := TList<IMinhaInterface>.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FLista.Free;
end;

end.
