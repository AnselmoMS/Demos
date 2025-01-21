unit View.Interfaces;

interface

uses
  System.UITypes,
  Comum.Constants;

type
  IView = interface
    ['{5F44DA6A-8C3F-4CD7-B836-DDD44B5CEB26}']
    function Perguntar(AMensagem: String): TModalResult;
    procedure ExibirMensagem(const Mensagem: string; AMenssageSeverity: TMessageSeverity = msInformation);
    procedure Exibir;
    function ExibirExclusivo: TModalResult;
  end;

implementation

end.
