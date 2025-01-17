unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TObjeto = class
  private
  FCampo: string;
  public
  property Campo: String read FCampo write FCampo;
  end;

  TObjetoHelper = class helper for TObjeto
  function DefinirCampo(ACampo: string): TObjeto;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TObjetoHelper }

function TObjetoHelper.DefinirCampo(ACampo: string): TObjeto;
begin
  Self.Campo := ACampo;
  Result:= Self;
end;

end.
