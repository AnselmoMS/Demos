unit ShortcutManager.Types;

interface

type
  TShortcutManagerKeyDownAction = (kdaCustom, kdaFocusNextControl, kdaFocusPreviousControl);
  TShortcutManagerKeyPressAction = (kpaCustom, kpaSupressKey, kpaFocusNextControl, kpaFocusPreviousControl);
  TVarProc<T> = reference to procedure(var Value: T);

implementation

end.
