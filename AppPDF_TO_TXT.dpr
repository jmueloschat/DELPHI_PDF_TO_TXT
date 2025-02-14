program AppPDF_TO_TXT;

uses
  Forms,
  ufrmMain in 'ufrmMain.pas' {TAppPDF2TXT};

{$R *.res}

var
  AppPDF2TXT: TTAppPDF2TXT;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTAppPDF2TXT, AppPDF2TXT);
  Application.Run;
end.
