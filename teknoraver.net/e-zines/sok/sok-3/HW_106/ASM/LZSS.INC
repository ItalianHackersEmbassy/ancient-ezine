;
;  � �⮬ ���㫥 ��室���� ��楤��� ��� ��娢�樨 �� ��⮤� �������-����.
;  �����-� �����騩 ������ �������� ��㣮�, �� �� �ॡ�� �����
;  ����� (��� ⠡���) � ᫮���� � ॠ����樨, ��� ᦨ���� ����. ��
;  �� ���� ࠧ ᮩ��� � ���. � ࠡ�⠥� �� ⠪: ��-����� �롨ࠥ���
;  ������ ���� - �� ⠪�� ����, ����� ����砥��� � 䠩�� ०� ���.
;  �� ��஬ �⠯� �நᮤ�� ��娢���: ��稭�� � ⥪�饩 ����樨
;  ����� ����� ⠪�� �� ��᫥����⥫쭮�� ���� �� ����ﭨ� �� 255 ����.
;  �᫨ ⠪���� �������, � �⠢���� ������ ����, ����� ����� �
;  ����ﭨ� �� ����୮�� �宦�����. ��� ��� ��� �ᯠ����� �㦭� �㤥�
;  ��室��� � ���⭮� ���浪�, � ��� � �⠢���� ����� ����।.
;  


;
;   ��娢��� ����� ������ ��稭�� � 100h � DI
;   ����� ����� - FileLen
;
;   ��室: DI - ����� ��娢�
;
ArjFile:
	mov bx,di
	mov ds,cs:FileSeg
	mov es,cs:FileSeg
	cld
	xor ax,ax
	mov di,65270
	push di
	mov cx,128
	rep stosw
	pop di
byte 0B9h	;mov cx,
FileLen word 0
	inc ch
	mov cs:FileLen_x,cx
	dec ch
	mov si,256
	
Start_Of_Code_0:
	byte 0,0,0,0,0

lz10:	lodsb	
	push di
	add di,ax
	cmp byte ptr ds:[di],255
	adc byte ptr ds:[di],0
	pop di
	loop lz10
	mov al,255
	inc ch
lz13:	cmp al,ds:[di]
	jc lz14
	mov al,ds:[di]
	mov dl,ah
lz14:	inc ah
	inc di
	loop lz13
	mov di,bx
	mov si,100h
	mov cs:CodeByte,dl
		
lz20:	call SelectMaxCount
	cmp bh,4
	jc lz21
	  mov ds:[di],bx
	  mov ds:[di+2],dl
	  add di,3
	  mov al,bh
	  xor ah,ah
	  add si,ax
	  jmp short lz25
lz21:	lodsb
	cmp al,dl
	jnz lz24
	mov Byte ptr ds:[di],0
	inc di
lz24:   stosb
lz25:	
	cmp si,10*1024+256	; �᫨ ��諨 ����� 10K
	jnc lz40
	cmp di,10*1024-512	; � 㦠���� ����� 祬 �� 512 ����
	jnc lz41
lz40:
	cmp si,cs:FileLen_x
	jc lz20
	mov cs:PackedLen,di
	retn
lz41:
	mov di,-1
	retn
	
SelectMaxCount:
	push si
	push di
	xor bx,bx
	lodsb
	mov di,si
	mov cx,cs:FileLen_x
	sub cx,si
	cmp cx,255
	jc lz30
	mov cx,255
lz30:	repne scasb
	jnz lz34
	push cx
	push di
	push si
	mov cx,cs:FileLen_x
	sub cx,di
	cmp cx,4
	jc lz32
	cmp cx,255
	jc lz31
	mov cx,255
lz31:	mov dh,cl
	repe cmpsb
	sub dh,cl
	cmp bh,dh
	jnc lz32
	  sub di,si
	  mov bx,di
	  mov bh,dh
lz32:	pop si
	pop di
	pop cx
	cmp bh,200
	jnc lz34
	or cx,cx
	jnz lz30
lz34:
	pop di
	pop si
	retn
	nop
End_Of_Code_0:
