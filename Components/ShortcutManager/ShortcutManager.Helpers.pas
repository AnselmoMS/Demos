unit ShortcutManager.Helpers;

interface

uses
  ShortcutManager,
  ShortcutManager.Types,
  System.Classes,
  System.SysUtils,
  Vcl.Controls;

type
  TShortcutManagerKeyDownHelper = class helper for TShortcutManagerKeyDown
    function Apply: TShortcutManager;
    function SetKey(AKey: Word): TShortcutManagerKeyDown;
    function SetShifts(const AShifts: array of TShiftState): TShortcutManagerKeyDown;
    function SetAction(AProc: TVarProc<Word>): TShortcutManagerKeyDown;
    function SetActionKind(AKind: TShortcutManagerKeyDownAction): TShortcutManagerKeyDown;
    function SetValidator(AValidator: TFunc<Boolean>): TShortcutManagerKeyDown;
    function SetAllowControls(const AControls: array of TWinControl): TShortcutManagerKeyDown;
    function SetDenyControls(const AControls: array of TWinControl): TShortcutManagerKeyDown;
    function SetAllowClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyDown;
    function SetDenyClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyDown;
  end;

  TShortcutManagerKeyPressHelper = class helper for TShortcutManagerKeyPress
    function Apply: TShortcutManager;
    function SetKeys(AKeys: array of Char): TShortcutManagerKeyPress;
    function SetShifts(const AShifts: array of TShiftState): TShortcutManagerKeyPress;
    function SetAction(AProc: TVarProc<Char>): TShortcutManagerKeyPress;
    function SetActionKind(AKind: TShortcutManagerKeyPressAction): TShortcutManagerKeyPress;
    function SetValidator(AValidator: TFunc<Boolean>): TShortcutManagerKeyPress;
    function SetAllowControls(const AControls: array of TWinControl): TShortcutManagerKeyPress;
    function SetDenyControls(const AControls: array of TWinControl): TShortcutManagerKeyPress;
    function SetAllowClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyPress;
    function SetDenyClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyPress;
  end;


implementation

{ TShortcutManagerKeyDownHelper }

function TShortcutManagerKeyDownHelper.Apply: TShortcutManager;
begin
  Result := GetManager;
end;

function TShortcutManagerKeyDownHelper.SetAction(AProc: TVarProc<Word>): TShortcutManagerKeyDown;
begin
  Action := AProc;
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetAllowClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyDown;
begin
  AllowClasses.AddRange(AClasses);
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetAllowControls(const AControls: array of TWinControl): TShortcutManagerKeyDown;
begin
  AllowControls.AddRange(AControls);
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetDenyClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyDown;
begin
  DenyClasses.AddRange(AClasses);
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetDenyControls(const AControls: array of TWinControl): TShortcutManagerKeyDown;
begin
  DenyControls.AddRange(AControls);
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetKey(AKey: Word): TShortcutManagerKeyDown;
begin
  Key := AKey;
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetActionKind(AKind: TShortcutManagerKeyDownAction): TShortcutManagerKeyDown;
begin
  ActionKind := AKind;
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetShifts(const AShifts: array of TShiftState): TShortcutManagerKeyDown;
begin
  if Length(AShifts) = 0 then
    raise Exception.Create('Empty array of Shift state is not allowed');

  Shifts.AddRange(AShifts);
  Result := Self;
end;

function TShortcutManagerKeyDownHelper.SetValidator(AValidator: TFunc<Boolean>): TShortcutManagerKeyDown;
begin
  Validator:= AValidator;
  Result := Self;
end;

{ TShortcutManagerKeyPressHelper }

function TShortcutManagerKeyPressHelper.Apply: TShortcutManager;
begin
  Result := GetManager
end;

function TShortcutManagerKeyPressHelper.SetAction(AProc: TVarProc<Char>): TShortcutManagerKeyPress;
begin
  Action := AProc;
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetAllowClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyPress;
begin
  AllowClasses.AddRange(AClasses);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetAllowControls(const AControls: array of TWinControl): TShortcutManagerKeyPress;
begin
  AllowControls.AddRange(AControls);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetDenyClasses(const AClasses: array of TWinControlClass): TShortcutManagerKeyPress;
begin
  DenyClasses.AddRange(AClasses);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetDenyControls(const AControls: array of TWinControl): TShortcutManagerKeyPress;
begin
  DenyControls.AddRange(AControls);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetKeys(AKeys: array of Char): TShortcutManagerKeyPress;
begin
  Keys.AddRange(AKeys);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetActionKind(AKind: TShortcutManagerKeyPressAction): TShortcutManagerKeyPress;
begin
  ActionKind := AKind;
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetShifts(const AShifts: array of TShiftState): TShortcutManagerKeyPress;
begin
  if Length(AShifts) = 0 then
    raise Exception.Create('Empty array of Shift state is not allowed');

  Shifts.AddRange(AShifts);
  Result := Self;
end;

function TShortcutManagerKeyPressHelper.SetValidator(AValidator: TFunc<Boolean>): TShortcutManagerKeyPress;
begin
  Validator := AValidator;
  Result := Self;
end;


end.
