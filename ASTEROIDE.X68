*===============================================================================
* TITLE       : ASTEROIDE (AGENT)
;             OFFSETS RESPECTO DIRECCIÓN BASE
; ASTPOSX (W)  (A0)
; ASTPOSY (W) 2(A0)
; ASTVELX (W) 4(A0)
; ASTVELY (W) 6(A0)

* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Código relacionado con el tipo de agente asteroide.
*===============================================================================

; ------------------------------------------------------------------------------
ASTINIT
; Inicializa el asteroide.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1,-(A7)

            ; INICIALIZACIÓN POSICIONES
            MOVE.W  #SCRWIDTH+ASTRAD,(A0)
            
            JSR     UTLRAND
            AND.L   #$0000000E,D0
            LEA.L   .SPAWNVEC,A1
            MOVE.W  (A1,D0),2(A0)
            
            JSR     UTLRAND                 ; RANDOM NUMBER GENERATION (en D0.L)
            AND.L   #$0000000C,D0           ; Máscara para que sean entre 0 y 12
            LEA.L   .VELVEC,A1
            MOVE.W  (A1,D0),4(A0)           ; A1+D0
            MOVE.W  2(A1,D0),6(A0)          ; Coge 2o WORD (o MOVE.L anterior)
            
            MOVEM.L (A7)+,D0/A1
            RTS
                                                ; OFFSETS
.SPAWNVEC   DC.W    ASTRAD                      ;0
            DC.W    SCRHEIGH/4                  ;2
            DC.W    SCRHEIGH/2                  ;4
            DC.W    (SCRHEIGH*3)/4              ;6
            DC.W    SCRHEIGH-ASTRAD             ;8
            
                                                ;OFFSETS:   
.VELVEC     DC.W    -ASTSPEED,ASTSPEED          ;0
            DC.W    -(ASTSPEED+3),ASTSPEED+4    ;4
            DC.W    -ASTSPEED,-ASTSPEED         ;8
            DC.W    -(ASTSPEED+5),-(ASTSPEED+2) ;12
            
; ------------------------------------------------------------------------------
ASTUPD
; Actualiza el asteroide.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D2,-(A7)
            
            ; ACTUALIZACIÓN DE COORDENADAS
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            ADD.W   4(A0),D0
            ADD.W   6(A0),D1
            
            ; CHECK SALIDA POR LA IZQUIERDA
            CMP.W   #-ASTRAD,D0
            BGT     .SKIP
            ADDQ.W  #1,(SCORE)
            JSR     AGLKILL
            
.SKIP       ; CHECK COLISIONES VERTICALES
            CMP.W   #SCRHEIGH-ASTRAD,D1
            BGT     .COLBOT                 ; si la coord. Y es >= que el valor
            CMP.W   #ASTRAD,D1
            BLT     .COLTOP                 ; si la coord. Y es <= que el radio
            BRA     .COLNAV
            
            ; COLISIÓN ABAJO
.COLBOT     NEG.W   6(A0)
            MOVE.W  #SCRHEIGH-ASTRAD,D1     ; ajuste coordenada Y
            BRA     .COLNAV
            
            ; COLISIÓN ARRIBA
.COLTOP     NEG.W   6(A0)
            MOVE.W  #ASTRAD,D1              ; ajuste coordenada Y
            
.COLNAV     JSR     UTLCOLNAV               ; CHECK COLISIÓN CON NAVE
            
            ; ALMACENAR POSICIÓN
            MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
            MOVEM.W (A7)+,D0-D2
            RTS
            
; ------------------------------------------------------------------------------
ASTPLOT
; Pinta el asteroide.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)
            
            ; Dibuja o no el sprite en función del valor de GRAPHICS
            MOVE.L  #GRAPHICS,D5
            CMP.L   #1,D5
            BEQ     .SPRITE

            ; SET PEN (CONTOUR) COLOR
            MOVE.B  #80,D0
            MOVE.L  #ASTCOLP,D1
            TRAP    #15

            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #ASTCOLF,D1
            TRAP    #15

            ; DEFINICIÓN DE COORDENADAS
            MOVE.W  (A0),D1
            SUB.W   #ASTRAD,D1              ; X IZQUIERDA
            MOVE.W  2(A0),D2
            SUB.W   #ASTRAD,D2              ; Y ARRIBA
            MOVE.W  D1,D3
            ADD.W   #2*ASTRAD,D3            ; X DERECHA
            MOVE.W  D2,D4
            ADD.W   #2*ASTRAD,D4            ; Y ABAJO

            ; DIBUJADO DEL CÍRCULO
            MOVE.B  #88,D0
            TRAP    #15
            BRA     .END
            
.SPRITE     ; DIBUJADO SPRITE
            MOVE.L  A0,A4
            LEA.L   2(A0),A5
            LEA.L   ASTIMG,A6
            JSR     SPRITEPLOT
            
.END        MOVEM.L (A7)+,D0-D5
            RTS

























*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
