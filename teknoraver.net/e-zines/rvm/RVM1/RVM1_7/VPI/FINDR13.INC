
                ; ���� INT 13 � BIOS�
                ;
                ; output:
                ;         ZF = 1  - OK
                ;           real_13 initialized
                ;         ZF = 0  - error

                ; *** ��� ������ ��� ���� ����஢��, � �� INT 2F ***
                
find_real_13:   mov     ah, 13h
                int     2Fh
                mov     cx, es
                mov     cs:real_13.offs, bx
                mov     cs:real_13.segm, es
                int     2Fh
                cmp     cx, 0F000h
                ret

