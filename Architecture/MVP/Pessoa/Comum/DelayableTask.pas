unit DelayableTask;

interface

uses
  System.Classes,
  System.SysUtils,
  System.SyncObjs;

type
  TDelayableTask = class
  private
    class var FLock: TCriticalSection;
    class var FInstance: TDelayableTask; //Threadvar a partir do Delphi XE7
    FThread: TThread;
    FTimeout: Cardinal;
    FLastResetTime: TDateTime;
    FMethod: TThreadProcedure;
    FOnCheckTimeOut: TProc<Integer>;
    procedure StartThread;
    class procedure StopThread;
    procedure ExecuteMethod;
    procedure ExecuteAfterCheckTimeout;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class function GetInstance: TDelayableTask;
    procedure Start(Timeout: Cardinal; Method: TThreadProcedure);
    function OnCheckTimeOut(AProcedure: TProc<Integer>): TDelayableTask;
  end;

implementation

uses
  System.DateUtils;

{ TSingletonTimer }

constructor TDelayableTask.Create;
begin
  inherited Create;
  FThread := nil;
  FTimeout := 0;
  FLastResetTime := Now;
end;

destructor TDelayableTask.Destroy;
begin
  StopThread;
  inherited Destroy;
end;

class function TDelayableTask.GetInstance: TDelayableTask;
begin
  if not Assigned(FInstance) then
  begin
    FLock.Enter;
    try
      if not Assigned(FInstance) then
        FInstance := TDelayableTask.Create;
    finally
      FLock.Leave;
    end;
  end;
  Result := FInstance;
end;

function TDelayableTask.OnCheckTimeOut(AProcedure: TProc<Integer>): TDelayableTask;
begin
  FOnCheckTimeOut := AProcedure;
  Result := FInstance;
end;

procedure TDelayableTask.Start(Timeout: Cardinal; Method: TThreadProcedure);
begin
  StopThread;
  FTimeout := Timeout;
  FMethod := Method;
  FLastResetTime := Now;
  StartThread;
end;

procedure TDelayableTask.StartThread;
begin
  FThread := TThread.CreateAnonymousThread(
    procedure
    begin
      while not TThread.CheckTerminated do
      begin
        if MilliSecondsBetween(Now, FLastResetTime) >= FTimeout then
        begin
          ExecuteMethod;
          Break;
        end;

        Sleep(100); // Reduz a carga da CPU
        ExecuteAfterCheckTimeout;
      end;
    end
  );
  FThread.Start;
end;

class procedure TDelayableTask.StopThread;
begin
  if Assigned(FThread) then
  begin
    FThread.FreeOnTerminate := True;
    FThread.Terminate;
    FThread:= nil;
  end;
end;

procedure TDelayableTask.ExecuteAfterCheckTimeout;
begin
  if Assigned(FOnCheckTimeOut) then
    FOnCheckTimeOut(MilliSecondsBetween(Now, FLastResetTime));
end;

procedure TDelayableTask.ExecuteMethod;
begin
  if Assigned(FMethod) then
    TThread.Synchronize(nil, FMethod);
end;

initialization
  TDelayableTask.FLock := TCriticalSection.Create;

finalization
  FreeAndNil(TDelayableTask.FInstance);
  FreeAndNil(TDelayableTask.FLock);

end.

