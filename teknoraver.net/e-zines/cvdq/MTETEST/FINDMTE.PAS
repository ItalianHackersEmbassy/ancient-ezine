program findmte;    {Find the dark avenger mutation engine unencrypted versions}

uses Dos;

type
  scan_str         =array[0..7] of byte;
  word_str         =array[0..3] of word;

const
  scan             :scan_str=($1F,$53,$56,$E9,$27,1,$8C,$DB);

var
  tstfile          :file;
  fbuf             :array[0..32000] of byte;
  fbidx            :word;
  string_found     :boolean;
  SR               :SearchRec;
  files_searched,
  simple_inf       :word;
  i                :word;

procedure scan_buffer;
var
  i,j              :integer;
begin
  for j:=0 to fbidx-8 do
    begin
      string_found:=true;
      for i:=0 to 7 do if fbuf[j+i]<>scan[i] then string_found:=false;
      if string_found then exit;
    end;
end;

procedure scan_file(fname:string);
begin
  write('Checking ',fname,'           ');
  files_searched:=files_searched+1;
  assign(tstfile,fname);
  reset(tstfile,1);
  fillchar(fbuf,sizeof(fbuf),#0);
  string_found:=false;
  repeat
    blockread(tstfile,fbuf[8],sizeof(fbuf),fbidx);
    fbidx:=fbidx-1;
    scan_buffer;
  until eof(tstfile) or string_found;
  if string_found then
    begin
      writeln(' Simple MTE found.');
      simple_inf:=simple_inf+1;
    end
  else write(#13);
  close(tstfile);
end;

begin
  for i:=0 to 7 do scan[i]:=scan[i]-1;
  files_searched:=0;
  simple_inf:=0;
  FindFirst('*.COM',AnyFile,SR);
  while DosError=0 do
    begin
      scan_file(SR.Name);
      FindNext(SR);
    end;
  FindFirst('*.EXE',AnyFile,SR);
  while DosError=0 do
    begin
      scan_file(SR.Name);
      FindNext(SR);
    end;
  writeln('Files scanned              : ',files_searched);
  writeln('Infected, unencrypted files: ',simple_inf);
end.
