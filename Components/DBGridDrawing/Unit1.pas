unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uADStanIntf, uADStanOption, uADStanParam, uADStanError, uADDatSManager, uADPhysIntf, uADDAptIntf,
  Datasnap.DBClient, Data.DB, uADCompDataSet, uADCompClient, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask;

type
  TForm1 = class(TForm)
    grdECF: TDBGrid;
    DataSource1: TDataSource;
    ADMemTable1: TADMemTable;
    ADMemTable1conta: TStringField;
    ADMemTable1codauxiliar: TIntegerField;
    ADMemTable1descricao: TStringField;
    ADMemTable1tipo: TBooleanField;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1conta: TStringField;
    ClientDataSet1codauxiliar: TIntegerField;
    ClientDataSet1descricao: TStringField;
    ClientDataSet1tipo: TBooleanField;
    DBNavigator1: TDBNavigator;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    gdMeses: TDBGrid;
    procedure grdECFDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClientDataSet1.SaveToFile('dados_teste');
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if FileExists('dados_teste') then
    ClientDataSet1.LoadFromFile('dados_teste');
end;

procedure TForm1.grdECFDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  {
  if true then //PJ em Geral
  begin
    if (Copy(grdECF.datasource.dataset.fieldbyname('CONTA').AsString, 1,4) >= '3.11')  then
      grdECF.Canvas.Brush.Color := $00C1C1FF;
  end;
  //grdECF.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  //grdECF.DefaultDrawDataCell(Rect, Column.Field, State);
  Exit;
  }

  if Odd(ClientDataSet1.RecNo) then
  begin
    //Fundo
    grdECF.Canvas.Brush.Color := $00C1C1FF;
    grdECF.Canvas.FillRect(Rect);

    {if gdSelected in State then
    begin
      grdECF.Canvas.Brush.Color := $006367F8;
//      grdECF.Canvas.Pen.Width := 1;
//      grdECF.Canvas.Pen.Style := psDot;
//      grdECF.Canvas.Pen.Color := clRed;
      //grdECF.Canvas.Rectangle(Rect);
    end;}

    grdECF.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

end;

end.
