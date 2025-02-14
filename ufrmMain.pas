unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TTAppPDF2TXT = class(TForm)
    edUrl: TEdit;
    btProcessar: TButton;
    lbUrlBase: TLabel;
    dtCotacao: TDateTimePicker;
    edCotacao: TEdit;
    lbDataCotacao: TLabel;
    lbCotacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btProcessarClick(Sender: TObject);
  private
    { Private declarations }
    FNomeArquivoPDF: String;
    procedure plCalculaUltimaQuartaFeira;
    procedure plConvertePDF2TXT;
    procedure plBuscaCotacao;
  public
    { Public declarations }
  end;

implementation

uses
   URLMon
  ,DateUtils
  ;

const
  CNT_URL_BASE = 'https://camaraalgodonera.com.ar/wp-content/uploads/%s/%s/Precios-de-Referencia-%s-%s-%s.pdf';
  CNT_PDFTOTEXT = 'pdftotext.exe';

{$R *.dfm}


procedure TTAppPDF2TXT.FormCreate(Sender: TObject);
begin
  edUrl.Text := CNT_URL_BASE;
  plCalculaUltimaQuartaFeira;


end;

procedure TTAppPDF2TXT.plCalculaUltimaQuartaFeira;
var
  liDiaSemana, liDiasASubtrair: Integer;
  ldDataCotacao: TDate;
begin
  //o site divulga o pdf em algum momento toda quarta-feira

  ldDataCotacao := Date;
  liDiaSemana := DayOfWeek(ldDataCotacao);
  liDiasASubtrair := liDiaSemana - 4;

  if liDiasASubtrair <= 0 then
     liDiasASubtrair := liDiasASubtrair + 7;

  ldDataCotacao := IncDay(ldDataCotacao, -liDiasASubtrair);
  dtCotacao.Date := ldDataCotacao;
end;

procedure TTAppPDF2TXT.btProcessarClick(Sender: TObject);
var
 lsUrlBase: String;
  lsAno, lsMes, lsDia: String;
  lsNomeArquivo: String;
begin
  lsAno := FormatDateTime('yyyy',dtCotacao.Date);
  lsMes := FormatDateTime('mm',dtCotacao.Date);
  lsDia := FormatDateTime('dd',dtCotacao.Date);
  lsUrlBase := Format(edUrl.Text,[lsAno,lsMes,lsDia,lsMes,lsAno]);
  FNomeArquivoPDF := Format('precio-%s-%s-%s.pdf',[lsAno,lsMes,lsDia]);

  if URLDownloadToFile(nil, PChar(lsUrlBase), PChar(FNomeArquivoPDF), 0, nil) = 0 then
     begin
       plConvertePDF2TXT;
       plBuscaCotacao;
       ShowMessage('Download/Conversion OK');
     end
  else
     begin
       edCotacao.Clear;
       ShowMessage('Download failed');
     end;
end;

procedure TTAppPDF2TXT.plConvertePDF2TXT;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  lsComando: string;
begin

  if not FileExists(CNT_PDFTOTEXT) then
     raise Exception.Create('Download the App '+CNT_PDFTOTEXT+#13#10+'www.xpdfreader.com/download.html');

  lsComando := Format(CNT_PDFTOTEXT+' -layout "%s" "%s"', [FNomeArquivoPDF, FNomeArquivoPDF+'.txt']);

  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := SW_HIDE;

  if CreateProcess(nil, PChar(lsComando), nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    raise Exception.Create('Error starting the conversion process');
end;

procedure TTAppPDF2TXT.plBuscaCotacao;
var lsArquivoTxt: TStringList;
begin
  lsArquivoTxt := TStringList.Create;
  try
    lsArquivoTxt.LoadFromFile(FNomeArquivoPDF+'.txt');
    edCotacao.Text := '$'+Trim(lsArquivoTxt.Strings[24]);
  finally
    FreeAndNil(lsArquivoTxt);
  end;
end;

end.
