
                ; dta

dta_struc       struc
dta_drive       db      ?               ; 0=a,1=b,2=c
dta_name8       db      8 dup (?)
dta_ext3        db      3 dup (?)
dta_searchattr  db      ?
dta_num         dw      ?               ; 0=. 1=..
dta_dircluster  dw      ?
                dd      ?               ; unused
dta_attr        db      ?               ; 1=r 32=a 16=d 2=h 4=s 8=v
dta_time        dw      ?               ; ����第� ��������
dta_date        dw      ?               ; �������� ��������
dta_size        dd      ?
dta_name        db      13 dup (?)
                ends

                ; exe header

exe_struc       struc
exe_mz          dw      ?
exe_last512     dw      ?
exe_num512      dw      ?
exe_relnum      dw      ?
exe_headersize  dw      ?
exe_minmem      dw      ?
exe_maxmem      dw      ?
exe_ss          dw      ?
exe_sp          dw      ?
exe_checksum    dw      ?
exe_ip          dw      ?
exe_cs          dw      ?
exe_relofs      dw      ?
exe_ovrnum      dw      ?
                db      32 dup (?)
exe_neptr       dd      ?
                ends

                ; sys header

sys_header      struc
sys_nextdriver  dd      ?               ; last driver: offset = FFFF
sys_attr        dw      ?
sys_strategy    dw      ?
sys_interrupt   dw      ?
sys_name        db      8 dup (?)
                ends

                ; sft

sft_struc       struc
sft_handles     dw      ?               ; ᪮�쪮 � 䠩�� ���ਯ�஢
sft_openmode    dw      ?
sft_attr        db      ?               ; ��ਡ��� 䠩��
sft_flags       dw      ?               ; ��� 14 - ��࠭��� ����/�६� �� �����⨨
sft_deviceptr   dd      ?               ; �᫨ ᨬ���쭮� ����-�� - header �ࠩ���
sft_filecluster dw      ?               ; ��砫�� ������ 䠩��
sft_date        dw      ?
sft_time        dw      ?
sft_size        dd      ?
sft_pos         dd      ?
sft_lastFclustr dw      ?               ; �⭮�⥫�� ����� ������ � 䠩��
                                        ; � ������ �뫮 ��᫥���� ���饭��
sft_dirsect     dd      ?               ; ᥪ�� ᮤ�ঠ騩 ������� ��⠫���
sft_dirpos      db      ?               ; ����� ������� ��⠫��� � ᥪ��
sft_name        db      11 dup (?)
sft_chain       dd      ?               ; share.exe
sft_uid         dw      ?               ; share.exe
sft_psp         dw      ?
sft_mft         dw      ?               ; share.exe
sft_lastclust   dw      ?               ; ����� ������ � ���஬� �뫮 ���. ����.
sft_ptr         dd      ?               ; 㪠��⥫� �� �ࠩ��� ifs 䠩��/0 �᫨ ���.
                ends
