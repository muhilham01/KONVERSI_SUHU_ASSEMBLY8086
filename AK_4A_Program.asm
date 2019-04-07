; ---------------------------------------------------------------------------------------------------------------------------------
;| @2019                                                                                                                          |
;| AUTHORS: 1. GERALDY CHRISTANTO                     ( TEKNIK KOMPUTER - 1706043001 - 8A )       			                      |
;|          2. MUHAMAD FAHRIZA NOVRIANSYAH            ( TEKNIK KOMPUTER - 1706042951 - 7A )       	 	  	                      |
;|          3. MUHAMMAD FAJAR MILLEANO                ( TEKNIK KOMPUTER - 1706043014 - 8A )       			                      |
;|          4. MUHAMMAD ILHAM AKBAR                   ( TEKNIK KOMPUTER - 1706042970 - 7A )         	  	                      |
;| KELOMPOK: 4A                                                                                      		                      |
;| TEMA    : KONVERSI SATUAN SUHU                                                                  			                      |
; ---------------------------------------------------------------------------------------------------------------------------------
; SKENARIO: 1. PROGRAM MEMINTA USER UNTUK MEMILIH SATUAN KONVERSI SUHU YANG AKAN DILAKUKAN
;           2. USER MEMASUKKAN SUHU YANG INGIN DIKONVERSI
;           3. HASIL KONVERSI AKAN DITAMPILKAN DILAYAR, BILA TERDAPAT SUARA_ON
;           4. APABILA INPUT ERROR, AKAN ADA NOTIFIKASI SUARA DAN PESAN ERROR
;           5. USER DAPAT MEMILIH UNTUK MELAKUKAN KONVERSI LAGI ATAU KELUAR DARI PROGRAM
;----------------------------------------------------------------------------------------------------------------------------------
;   Temperature Convertion is a program that convert temperature Celcius, Fahrenheit, Kelvin that input by user
;  
;   Copyright <C> 2019 GERALDY CHRISTANTO, MUHAMAD FAHRIZA NOVRIANSYAH, MUHAMMAD FAJAR MILLEANO, MUHAMMAD ILHAM AKBAR
;   this program is free software; you can redistibute it and/or modify it under the terms of the GNU General Public License as published by
;   the free Software Foundation; either version 3 of the License, or <at your option> any later version.
;   This program is ditributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of 
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
;
;----------------------------------------------------------------------------------------------------------------------------------
;Reference  : https://www.youtube.com/watch?v=pVXikCidM6s&t=13s & https://stackoverflow.com/questions/39427980/relative-jump-out-of-range-by
;----------------------------------------------------------------------------------------------------------------------------------   
 

.MODEL SMALL
ORG 100H    
.STACK 100H
.DATA       

;----------------------------------------------
;;              VARIABLE OF DATA              ;
;----------------------------------------------
MSG1        DB 'TEMPERATURE CONVERTER', 13, 10, '$'
MSG_IN      DB 'CHOOSE AN OPTION: $'
MSG_OPT1    DB '[1] CELCIUS -> KELVIN', 13, 10, '$'
MSG_OPT2    DB '[2] CELCIUS -> FAHRENHEIT', 13, 10, '$'  
MSG_OPT3    DB '[3] FAHRENHEIT -> KELVIN', 13, 10, '$'
MSG_OPT4    DB '[4] FAHRENHEIT -> CELCIUS', 13, 10, '$'
MSG_OPT5    DB '[5] KELVIN -> FAHRENHEIT', 13, 10, '$'
MSG_OPT6    DB '[6] KELVIN -> CELCIUS', 13, 10, '$'
MSG_IN2		DB 13, 10, 'INPUT TEMPERATURE: $'
DEGREE      DB 248, '$'
MSG_ERROR   DB 13, 10, 'INPUT ERROR!',13,10,'$'  
MSG_OUT     DB 13, 10, 'RESULT = $'   
STOR        DW 0        ;MEMORY
MSG_EXIT    DB 13,10,'PRESS',13,10,' [1] EXIT',13, 10 
            DB ' [0] RETURN', 13, 10, '$'
MSG_EXIT2   DB 13,10,13,10, 'PRESS ANY KEY TO EXIT THE PROGRAM . . .$'             
OPSI        DB 1 DUP (?)

;----------------------------------------------
;;               CODE SEGMENT                 |
;----------------------------------------------
.CODE   

PUTC MACRO  CHAR
     PUSH   AX
     MOV    AL, CHAR
     MOV    AH, 0EH
     INT    10H
     POP    AX
ENDM PUTC

;;MENU INTERFACE              
MENU PROC                  
        MOV DX, OFFSET MSG1
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_OPT1
        MOV AH, 09H
        INT 21H
                                        
        MOV DX, OFFSET MSG_OPT2
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_OPT3
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_OPT4
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_OPT5
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_OPT6
        MOV AH, 09H
        INT 21H

        MOV DX, OFFSET MSG_IN
        MOV AH, 09H
        INT 21H

        MOV AH, 01H
        INT 21H  
        CMP AL, '1' 
        
        JL ERRORBANTU
        CMP AL, '6'
        JG ERRORBANTU  
        MOV OPSI, AL 
        
        JMP MENU2
        
ERRORBANTU:
        JMP ERROR1
               
ENDP MENU 

;MACRO UNTUK ERROR
ERROR   MACRO
        MOV DX, OFFSET MSG_ERROR
        MOV AH, 09H
        INT 21H 
        
        JMP MENU2
ENDM    ERROR  

.STARTUP

NUM1    DW ?
NUM2    DW ?
NUM3    DW ?
NUM4    DW ?
NUM5    DW ?

START:  
        MOV AX, @DATA
        MOV DS, AX
        PUTC 0DH
        PUTC 0AH    
        
        MOV AX, 600H         ;CLEAR SCREEN
        MOV BH, 07H         
        MOV DX, 7924
        INT 10H
         
        MOV AL, 03H 
        MOV AH, 0H
        INT 10H

        CALL MENU

;;COMPARE MENU DAN SELECT KONVERSI YANG DIINGINKAN
MENU2:
        CMP OPSI, 31H
        JNE PILIH2
        JMP CONV1               ;CELCIUS -> KELVIN

        PILIH2:
        CMP OPSI, 32H
        JNE PILIH3
        JMP CONV2               ;CELCIUS -> FAHRENHEIT

        PILIH3:
        CMP OPSI, 33H
        JNE PILIH4
        JMP CONV3               ;FAHRENHEIT -> KELVIN

        PILIH4:
        CMP OPSI, 34H
        JNE PILIH5
        JMP CONV4               ;FAHRENHEIT -> CELCIUS

        PILIH5:
        CMP OPSI, 35H
        JNE PILIH6
        JMP CONV5               ;KELVIN -> FAHRENHEIT

        PILIH6:
        CMP OPSI, 36H
        JNE PILIH7
        JMP CONV6               ;KELVIN -> CELCIUS

        PILIH7:
        JMP ERROR1  
        
;CELCIUS TO KELVIN
CONV1:  
        MOV  AX, 4560        ;NILAI DO
        MOV  STOR, AX
        CALL SOUNDER         ;PUTAR NADA   
        MOV  AX,0H
        CALL READ
        MOV NUM1, CX
        PUTC 0DH
        PUTC 0AH 
        MOV CX, 1
        MOV NUM2, CX

        MOV DX, 0
        MOV AX, NUM1
        IDIV NUM2
        MOV NUM2, AX
        MOV NUM5, 1 

        MOV DX, OFFSET MSG_OUT
        MOV AH, 09H
        INT 21H

        MOV AX, NUM2
        IMUL NUM5
        MOV NUM5, AX
        ADD AX, 273

        CALL DISPLAY1
        RET
;CELCIUS TO FAHRENHEIT
CONV2:
        MOV     AX, 4063        ;NADA RE
        MOV     STOR, AX
        CALL    SOUNDER         ;PUTAR NADA   
        MOV     AX,0H
        
        CALL READ
        
        ; INPUT MASUKKAN
        MOV NUM1, CX
        
        PUTC 0DH
        PUTC 0AH
        MOV CX,5
        MOV NUM2, CX

        MOV DX, 0
        MOV AX, NUM1
        IDIV NUM2               
        MOV NUM2, AX 
        MOV NUM3, 9
       
        MOV DX, OFFSET MSG_OUT
        MOV AH, 9H
        INT 21H

        MOV AX, NUM2
        IMUL NUM3
        MOV NUM3, AX
        ADD AX, 32

        CALL DISPLAY1
        RET
 ;FAHRENHEIT TO KELVIN      
CONV3:  
        MOV     AX, 3619        ;NADA MI
        MOV     STOR, AX
        CALL    SOUNDER         ;PUTAR NADA   
        MOV     AX,0H
        
        CALL READ 
        MOV NUM1, CX
        PUTC 0DH
        PUTC 0AH
        SUB NUM1, 32
        MOV CX,9
        MOV NUM2, CX

        MOV DX,0
        MOV AX, NUM1
        IDIV NUM2; AX = (DX AX) / NUM2
        MOV NUM2, AX 
        MOV NUM3, 5

        MOV DX, OFFSET MSG_OUT
        MOV AH, 9
        INT 21H

        MOV AX, NUM2
        IMUL NUM3
        ADD AX, 273
        
        CALL DISPLAY1
        RET

;FAHRENHEIT TO CELCIUS    
;(TC - 32) * 5/9
CONV4:  
        MOV     AX, 3416        ;NADA FA
        MOV     STOR, AX
        CALL    SOUNDER         ;PUTAR NADA   
        MOV     AX,0H
         
        CALL READ               ;PROC MEMINTA INPUT USER
        MOV NUM1, CX
        PUTC 0DH
        PUTC 0AH
        SUB NUM1, 32
        MOV CX,9
        MOV NUM2, CX

        MOV DX, 0
        MOV AX, NUM1
        IDIV NUM2
        MOV NUM2, AX 
        MOV NUM3, 5

        MOV DX, OFFSET MSG_OUT
        MOV AH, 9
        INT 21H

        MOV AX, NUM2
        IMUL NUM3
        
        CALL DISPLAY1
        RET      
        
;KELVIN TO FAHRENHEIT
;TK - 273 * 9/5 + 32
CONV5:  
        MOV     AX, 3043        ;NADA SOL
        MOV     STOR, AX
        CALL    SOUNDER         ;PUTAR NADA   
        MOV     AX,0H
          
        CALL READ 
        MOV NUM1, CX
        PUTC 0DH
        PUTC 0AH
        SUB NUM1, 273
        MOV CX,5
        MOV NUM2, CX

        MOV DX,0
        MOV AX, NUM1
        IDIV NUM2
        MOV NUM2, AX 
        MOV NUM3, 9

        MOV DX, OFFSET MSG_OUT
        MOV AH, 9
        INT 21H

        MOV AX, NUM2
        IMUL NUM3
        ADD AX, 32
        CALL DISPLAY1
        RET      
        
; KELVIN TO CELCIUS 
; TK - 273
CONV6:  
        MOV     AX, 2711        ;NADA    LA
        MOV     STOR, AX
        CALL    SOUNDER         ;PUTAR NADA   
        MOV     AX,0H
        
        CALL READ 
        MOV NUM1, CX 
        PUTC 0DH
        PUTC 0AH
        
        SUB NUM1, 273
        MOV CX,1
        MOV NUM2, CX

        MOV DX,0
        MOV AX, NUM1
        MOV NUM2, AX 
        MOV NUM3, 1

        MOV DX, OFFSET MSG_OUT
        MOV AH, 9
        INT 21H

        MOV AX, NUM2
        IMUL NUM3
        
        CALL DISPLAY1 
        
        RET

;GENERATE SOUND
        SOUNDER:
            MOV     AL, 0B6H        ;LOAD CONTROL
            OUT     43H, AL         ;SEND
            MOV     AX, STOR        ;MASUKAN FREKUENSI KE AX
            OUT     42H, AL         ;SEND LSB
            MOV     AL, AH          ;MOVE MSB KE AL
            OUT     42H, AL         ;SEND MSB
            IN      AL, 061H        ;DAPATKAN STATE PORT 61H
            OR      AL, 03H         ;NYALAKAN SPEAKER
            OUT     61H, AL         ;SPEAKER MENYALA
            CALL    DELAY           ;DELAY
            OUT     61H, AL         ;SPEAKER MATI
        RET
        
;DELAY NADA
        DELAY:
            MOV     AH, 00H         ;FUNGSI 0H - DAPATKAN SYSTEM TIMER
            INT     01AH            ;PANGIL ROM BIOS TIME-OF-DAY SERVICES
            ADD     DX, 12           ;MASUKAN NILAI DELAY
            MOV     BX, DX          ;STORE HASILNYA KE BX

        PZ:
            INT     01AH            ;PANGGIL ROM BIOS TIME-OF-DAY SERVICES
            CMP     DX, BX          ;COMPARE DENGAN BX, APAKAH SUDAH SELESAI DELAY ?
            JL      PZ              ;JIKA BELUM LOOPING
        RET
        
AKHIR:
        MOV AH, 4CH
        INT 21H
    
READ    PROC NEAR                   ;READ INPUT USER 
        PUSH DX
        PUSH AX
        PUSH SI
        
        MOV DX, OFFSET MSG_IN2
        MOV AH, 09H
        INT 21H
        
        MOV CX, 0 
        MOV CS:MAKE_MINUS, 0

NEXTDIGIT:
        MOV AH, 00H
        INT 16H
    
        MOV AH, 0EH
        INT 10H
        CMP AL, '-'
        JE SET_MINUS
    
        CMP AL, 0DH
        JNE NOTCRET
        JMP STOP

NOTCRET: CMP AL, 8
        JNE CHECK1
        
        MOV DX, 0
        MOV AX, CX
        DIV CS:TEN
        MOV CX, AX
        PUTC ' '
        PUTC 8
        JMP NEXTDIGIT

;CHECK BACKSPACE    
CHECK1:
        CMP AL,'0'
        JAE CHECK2
        JMP REMOVE
    
CHECK2:
        CMP AL, '9'
        JBE ACCEPT

REMOVE:
        PUTC    8
        PUTC    ' '
        PUTC    8
        JMP     NEXTDIGIT
    
ACCEPT:
        PUSH AX
        MOV AX, CX
        MUL CS:TEN
        MOV CX, AX
        POP AX 
    
        CMP DX, 0
        JNE BIG
    
        SUB AL, 30H
    
        MOV AH, 0
        MOV DX, CX
        ADD CX, AX
        JC BIG2
    
        JMP NEXTDIGIT

SET_MINUS:
        MOV CS:MAKE_MINUS, 1
        JMP NEXTDIGIT

BIG2:
        MOV CX, DX
        MOV DX, 0

BIG:
        MOV AX, CX
        DIV CS:TEN
        MOV CX, AX
        PUTC 8
        PUTC ' '
        PUTC 8
        JMP NEXTDIGIT
		
;;STOP INPUT
STOP:
        CMP CS:MAKE_MINUS, 0
        JE POSITIVE
        NEG CX

POSITIVE:
        POP SI
        POP AX
        POP DX
        RET
MAKE_MINUS DB ?        
ENDP   READ 

ERROR1:
        ERROR

;INPUT DISPLAY
DISPLAY1 PROC NEAR
         PUSH DX 
         PUSH AX 
    
         CMP AX,0
         JNZ NOTZERO
    
         PUTC '0'
         JMP PRINTED

NOTZERO:
         CMP AX, 0
         JNS POSITIVE2
         NEG AX
    
         PUTC '-'

POSITIVE2:
         CALL DISPLAY2

PRINTED:
         POP AX
         POP DX 
         
         RET
ENDP DISPLAY1


;POSITIVE DISPLAY
DISPLAY2 PROC NEAR
         PUSH AX
         PUSH BX
         PUSH CX
         PUSH DX
        
         MOV CX, 1
        
         MOV BX, 10000
         CMP AX,0
         JZ PRINT_ZERO

 
 STARTPRINT:
         CMP BX,0
         JZ ENDPRINT
      
         CMP CX,0
         JE CALC
        
         CMP AX, BX
         JB SKIP
 
       CALC:
         MOV CX, 0
         MOV DX, 0
         DIV BX
      
         ADD AL, 30H
         PUTC AL
         MOV AX, DX 
        
       SKIP:
         PUSH AX
         MOV DX, 0
         MOV AX, BX
         DIV CS:TEN
         MOV BX, AX
         POP AX
         JMP STARTPRINT
  
 PRINT_ZERO:
         PUTC '0'

  ENDPRINT:
         POP DX
         POP CX
         POP BX
         POP AX
EXIT1: 
        LEA DX, MSG_EXIT
        MOV AH, 09H
        INT 21H
                                        
        MOV AH, 08H
        INT 21H
        
        CMP AL, '0'
        JNE OPSIEXIT
        JMP START 
        OPSIEXIT:
        CMP AL, '1'
        JMP EXIT_PROGRAM  
        RET
ENDP  DISPLAY2

TEN  DW 10

EXIT_PROGRAM:  

         MOV AX, 600H         ;CLEAR SCREEN
         MOV BH, 07H         
         MOV DX, 7924
         INT 10H         
         
         MOV AL, 03H 
         MOV AH, 0H
         INT 10H
         
         MOV DX, OFFSET MSG_EXIT2  
         MOV AH, 09H
         INT 21H                

.EXIT
END START