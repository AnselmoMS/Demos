unit ShortcutManager;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Controls,
  VCL.Forms,
  ShortcutManager.Types;

type
  TCustomFormHook = class(TCustomForm); //It can be TWincontrol, but it not contains .ActiveControl

  TShortcutManager = class;

  TShortcutManagerKey = class
  private
    FManager: TShortcutManager;
    FAllowControls: TObjectList<TWinControl>;
    FDenyControls: TObjectList<TWinControl>;
    FAllowClasses: TList<TWinControlClass>;
    FDenyClasses: TList<TWinControlClass>;
    FValidator: TFunc<Boolean>;
    FShifts: TList<TShiftState>;
  protected
    function MatchesControl(AControl: TWinControl): Boolean;
    function ApprovedByValidator: Boolean;
    function GetManager: TShortcutManager;
  public
    constructor Create(AManager: TShortcutManager); reintroduce; virtual;
    destructor Destroy; override;

    property Shifts: TList<TShiftState> read FShifts write FShifts;
    property Validator: TFunc<Boolean> read FValidator write FValidator;
    property AllowControls: TObjectList<TWinControl> read FAllowControls;
    property DenyControls: TObjectList<TWinControl> read FDenyControls;
    property AllowClasses: TList<TWinControlClass> read FAllowClasses;
    property DenyClasses: TList<TWinControlClass> read FDenyClasses;
  end;

  TShortcutManagerKeyDown = class(TShortcutManagerKey)
  private
    FKey: Word;
    FAction: TVarProc<Word>;
    FActionKind: TShortcutManagerKeyDownAction;
    procedure ActionKindChanged;
    procedure SetActionKind(const Value: TShortcutManagerKeyDownAction);
    procedure SetAction(const Value: TVarProc<Word>);
  public
    constructor Create(AManager: TShortcutManager); override;
    //
    function Matches(AControl: TWinControl; AKey: Word; AShift: TShiftState): Boolean;
    //
    property Key: Word read FKey write FKey;
    property Action: TVarProc<Word> read FAction write SetAction;
    property ActionKind: TShortcutManagerKeyDownAction read FActionKind write SetActionKind;
  end;

  TShortcutManagerKeyPress = class(TShortcutManagerKey)
  private
    FActionKind: TShortcutManagerKeyPressAction;
    FAction: TVarProc<Char>;
    FKeys: TList<Char>;
    procedure ActionKindChanged;
    procedure SetAction(const Value: TVarProc<Char>);
    procedure SetActionKind(const Value: TShortcutManagerKeyPressAction);
  public
    constructor Create(AManager: TShortcutManager); override;
    destructor Destroy; override;
    //
    function Matches(AControl: TWinControl; var AKey: Char; AShiftState: TShiftState): Boolean;
    //
    property Keys: TList<Char> read FKeys;
    property Action: TVarProc<Char> read FAction write SetAction;
    property ActionKind: TShortcutManagerKeyPressAction read FActionKind write SetActionKind;
  end;

  TShortcutManager = class
  private
    FParent: TCustomForm;
    FKeyDownList: TObjectList<TShortcutManagerKeyDown>;
    FKeyPressList: TObjectList<TShortcutManagerKeyPress>;
    FParentKeyDown: TKeyEvent;
    FParentKeyPress: TKeyPressEvent;
    function GetShiftState: TShiftState;
    procedure ExecuteKeyDown(ASender: TObject; var AKey: Word; AShift: TShiftState);
    procedure ExecuteKeyPress(ASender: TObject; var AKey: Char);
    function GetParent: TCustomForm;
  public
    constructor Create(AParent: TCustomForm);
    destructor Destroy; override;
    //
    function AddKeyDown: TShortcutManagerKeyDown;
    function AddKeyPress: TShortcutManagerKeyPress;
    //
    procedure RemoveParent;
    //
    property Parent: TCustomForm read GetParent;
  end;


implementation

uses
  ShortcutManager.TemplateFactory;

{ TShortcutManagerKey }

function TShortcutManagerKey.ApprovedByValidator: Boolean;
begin
  Result := True;

  if Assigned(FValidator) then
    Result := FValidator();
end;

constructor TShortcutManagerKey.Create(AManager: TShortcutManager);
begin
  FShifts := TList<TShiftState>.Create;
  FManager := AManager;
  FValidator := nil;
  FAllowControls := TObjectList<TWinControl>.Create(False);
  FDenyControls := TObjectList<TWinControl>.Create(False);
  FAllowClasses := TList<TWinControlClass>.Create;
  FDenyClasses := TList<TWinControlClass>.Create;
end;

destructor TShortcutManagerKey.Destroy;
begin
  FShifts.Free;
  FAllowControls.Free;
  FDenyControls.Free;
  FAllowClasses.Free;
  FDenyClasses.Free;
  inherited;
end;

function TShortcutManagerKey.GetManager: TShortcutManager;
begin
  Result:= FManager;
end;

function TShortcutManagerKey.MatchesControl(AControl: TWinControl): Boolean;
var
  LClass: TWinControlClass;
begin
  // Primeiro verifica as classes negadas
  for LClass in FDenyClasses do
    if (LClass <> nil) and AControl.InheritsFrom(LClass) then
      Exit(False);

  // Verifica lista de classes permitidas (se existir)
  if FAllowClasses.Count > 0 then
  begin
    for LClass in FAllowClasses do
      if (LClass <> nil) and AControl.InheritsFrom(LClass) then
        Exit(True);

    // Se chegou aqui, não está na lista de permitidos
    Exit(False);
  end;

  // Verifica controles negados
  if (FDenyControls.Count > 0) and FDenyControls.Contains(AControl) then
    Exit(False);

  // Verifica lista de controles permitidos (se existir)
  if (FAllowControls.Count > 0) and not FAllowControls.Contains(AControl) then
    Exit(False);

  // Passou por todas as verificações
  Result := True;
end;

{ TShortcutManagerKeyDown }

procedure TShortcutManagerKeyDown.ActionKindChanged;
begin
  FAction := TShortcutManagerKeyTemplateFactory.GetKeyDownTemplateMethod(FActionKind, FManager.GetParent);
end;

constructor TShortcutManagerKeyDown.Create(AManager: TShortcutManager);
begin
  inherited;
  FKey := 0;
  FActionKind := kdaCustom;
end;

function TShortcutManagerKeyDown.Matches(AControl: TWinControl; AKey: Word; AShift: TShiftState): Boolean;
var
  LShiftState: TShiftState;
begin
  Result := False;
  if Key <> AKey then
    Exit;

  for LShiftState in Shifts do
    if LShiftState = AShift then
    begin
      Result := MatchesControl(AControl);
      Exit;
    end;
end;

procedure TShortcutManagerKeyDown.SetActionKind(const Value: TShortcutManagerKeyDownAction);
begin
  FActionKind := Value;
  ActionKindChanged;
end;

procedure TShortcutManagerKeyDown.SetAction(const Value: TVarProc<Word>);
begin
  FAction := Value;
  FActionKind := kdaCustom;
end;

{ TShortcutManagerKeyPress }

procedure TShortcutManagerKeyPress.ActionKindChanged;
begin
  FAction := TShortcutManagerKeyTemplateFactory.GetKeyPressTemplateMethod(FActionKind, FManager.GetParent);
end;

constructor TShortcutManagerKeyPress.Create(AManager: TShortcutManager);
begin
  inherited;
  FKeys := TList<Char>.Create;
end;

destructor TShortcutManagerKeyPress.Destroy;
begin
  FKeys.Free;
  inherited;
end;

function TShortcutManagerKeyPress.Matches(AControl: TWinControl; var AKey: Char; AShiftState: TShiftState): Boolean;
var
  LKey: Char;
  LShiftState: TShiftState;
begin
  Result := False;
  for LKey in Keys do
    if AKey = LKey then
    begin
      for LShiftState in Shifts do
        if LShiftState = AShiftState then
        begin
          Result := MatchesControl(AControl);
          Exit;
        end;
    end;
end;

procedure TShortcutManagerKeyPress.SetAction(const Value: TVarProc<Char>);
begin
  FAction := Value;
  FActionKind := kpaCustom;
end;

procedure TShortcutManagerKeyPress.SetActionKind(const Value: TShortcutManagerKeyPressAction);
begin
  FActionKind := Value;
  ActionKindChanged;
end;

{ TShortcutManager }

constructor TShortcutManager.Create(AParent: TCustomForm);
begin
  FParent := AParent;
  FKeyDownList := TObjectList<TShortcutManagerKeyDown>.Create;
  FKeyPressList := TObjectList<TShortcutManagerKeyPress>.Create;

  if Assigned(FParent) then
  begin
    FParentKeyDown := TCustomFormHook(FParent).OnKeyDown;
    TCustomFormHook(FParent).OnKeyDown := ExecuteKeyDown;

    FParentKeyPress := TCustomFormHook(FParent).OnKeyPress;
    TCustomFormHook(FParent).OnKeyPress := ExecuteKeyPress;
  end;
end;

destructor TShortcutManager.Destroy;
begin
  FKeyDownList.Free;
  FKeyPressList.Free;
  inherited;
end;

procedure TShortcutManager.RemoveParent;
begin
  FParent := nil;
end;

function TShortcutManager.GetParent: TCustomForm;
begin
  Result := FParent
end;

function TShortcutManager.GetShiftState: TShiftState;
begin
  Result := [];

  if GetKeyState(VK_SHIFT) < 0 then
    Include(Result, ssShift);

  if GetKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
end;

function TShortcutManager.AddKeyDown: TShortcutManagerKeyDown;
begin
  Result := TShortcutManagerKeyDown.Create(Self);
  FKeyDownList.Add(Result);
end;

function TShortcutManager.AddKeyPress: TShortcutManagerKeyPress;
begin
  Result := TShortcutManagerKeyPress.Create(Self);
  FKeyPressList.Add(Result);
end;

procedure TShortcutManager.ExecuteKeyDown(ASender: TObject; var AKey: Word; AShift: TShiftState);
var
  LShortcut: TShortcutManagerKeyDown;
begin
  for LShortcut in FKeyDownList do
    if LShortcut.Matches(FParent.ActiveControl, AKey, AShift) and LShortcut.ApprovedByValidator then
    begin
      if Assigned(LShortcut.Action) then
        LShortcut.Action(AKey);
    end;

  if Assigned(FParentKeyDown) then
    FParentKeyDown(ASender, AKey, AShift)
end;

procedure TShortcutManager.ExecuteKeyPress(ASender: TObject; var AKey: Char);
var
  LShortcut: TShortcutManagerKeyPress;
  LInitialKey: Char;
begin
  LInitialKey := AKey; //AKey can be changed by action (kpaSupressKey)
  for LShortcut in FKeyPressList do
    if LShortcut.Matches(FParent.ActiveControl, LInitialKey, GetShiftState) and LShortcut.ApprovedByValidator then
    begin
      if Assigned(LShortcut.Action) then
        LShortcut.Action(AKey);
    end;

  if Assigned(FParentKeyPress) then
    FParentKeyPress(ASender, AKey);
end;

end.

