unit ShortcutManager.TemplateFactory;

interface

uses
  ShortcutManager.Types,
  Vcl.Controls,
  Winapi.Messages;

type
  TShortcutManagerKeyTemplateFactory = class
    class function GetKeyDownTemplateMethod(AActionKind: TShortcutManagerKeyDownAction; AParent: TControl): TVarProc<Word>;
    class function GetKeyPressTemplateMethod(AActionKind: TShortcutManagerKeyPressAction; AParent: TControl): TVarProc<Char>;
  end;

implementation

uses
  System.SysUtils;

{ TShortcutManagerKeyTemplateFactory }

class function TShortcutManagerKeyTemplateFactory.GetKeyDownTemplateMethod(AActionKind: TShortcutManagerKeyDownAction; AParent: TControl): TVarProc<Word>;
begin
  case AActionKind of
    kdaCustom:
      Result := nil;

    kdaFocusNextControl:
      Result :=
        procedure(var AKey: Word)
        begin
          if Assigned(AParent) then
            AParent.Perform(WM_NEXTDLGCTL, 0, 0);
        end;

    kdaFocusPreviousControl:
      Result :=
        procedure(var AKey: Word)
        begin
          if Assigned(AParent) then
            AParent.Perform(WM_NEXTDLGCTL, 1, 0);
        end;
  else
    raise ENotSupportedException.Create('Unsupported KeyDown Action');
  end;
end;

class function TShortcutManagerKeyTemplateFactory.GetKeyPressTemplateMethod(AActionKind: TShortcutManagerKeyPressAction; AParent: TControl): TVarProc<Char>;
begin
  case AActionKind of
    kpaCustom:
      Result:= nil;

    kpaSupressKey:
      Result :=
        procedure(var AChar: Char)
        begin
          AChar := #0;
        end;

    kpaFocusNextControl:
      Result :=
        procedure(var AChar: Char)
        begin
          if Assigned(AParent) then
            AParent.Perform(WM_NEXTDLGCTL, 0, 0);
        end;

    kpaFocusPreviousControl:
      Result :=
        procedure(var AChar: Char)
        begin
          if Assigned(AParent) then
            AParent.Perform(WM_NEXTDLGCTL, 1, 0);
        end;
  else
    raise ENotSupportedException.Create('Unsupported KeyPress Action');
  end;
end;

end.
