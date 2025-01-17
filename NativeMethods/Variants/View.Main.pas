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
  Vcl.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Generics.Collections;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Variante: Variant;
  ArrayInteger,
  ArrayIntegerOut: TArray<Integer>;
  I: Integer;
  StringList: TStringList;
begin
  Variante := TDate(Date);
  ShowMessage(VarTostr(Date));

  Exit;

  Variante := Null;
  ArrayInteger:= TArray<Integer>.Create(10,20,30);  //VarArrayOf([10, 20, 30, 40, 50]);
  Variante := ArrayInteger;

  if VarIsArray(Variante) then
  begin
//    if (VarType(Variante) = varInteger) then
    begin
      StringList := TStringList.Create;
      try
        for i := VarArrayLowBound(Variante, 1) to VarArrayHighBound(Variante, 1) do
          StringList.Add(VarToStr(Variante[I]));

        ShowMessage(StringList.Text);
      finally
        StringList.Free;
      end;
    end;
  end;
end;

end.
