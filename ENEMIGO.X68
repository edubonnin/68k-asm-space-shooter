*===============================================================================
* TITLE       : ENEMIGO (AGENT)
;             OFFSETS RESPECTO DIRECCIÓN BASE
; ENPOSX (W)  (A0)
; ENPOSY (W) 2(A0)

* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.23
* DESCRIPTION : Código relacionado con el tipo de agente nave enemiga.
*===============================================================================

; ------------------------------------------------------------------------------
ENINIT
; Inicializa el enemigo.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-A1,-(A7)
            
            ; PEPARACIÓN Y CARGA DE VECTOR DE POSICIONES EN Y
            MOVE.W  (ENNUM),D0
            MULU.W  #2,D0
            LEA.L   .VECPOSY,A1

            ; INICIALIZACIÓN POSICIONES
            MOVE.W  #SCRWIDTH+ENWIDTH,(A0)
            MOVE.W  (A1,D0),2(A0)
            
            MOVEM.L (A7)+,D0-A1
            RTS
            
.VECPOSY    DC.W    ENHEIGH,SCRHEIGH-ENHEIGH,SCRHEIGH/2
            
; ------------------------------------------------------------------------------
ENUPD
; Actualiza el enemigo.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D2,-(A7)
            
            ; ATUALIZACIÓN DE COORDENADAS
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            
            ; CHECK POSICIÓN LÍMITE
            CMP.W   #SCRWIDTH-3*ENWIDTH,D0
            BLT     .COLNAV
            ; SUMA VELOCIDAD
            SUB.W   #ENSPEED,D0
            
.COLNAV     JSR     UTLCOLNAV               ; CHECK COLISIÓN CON NAVE

            ; ALMACENAR POSICIÓN
            MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
            ; ACTUALIZAR DISPARO
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%00111111,D0           ; Cada X ciclos
            BNE     .END
            ; CREACIÓN AGENTE TIPO DISPARO
            LEA.L   DISPINIT,A1
            LEA.L   DISPUPD,A2
            LEA.L   DISPPLOT,A3
            MOVE.W  #3,D0
            MOVE.W  2(A0),D1                ; PARÁMETRO COORD. Y DISPARO
            JSR     AGLADD
            
.END        MOVEM.W (A7)+,D0-D2
            RTS
            
; ------------------------------------------------------------------------------
ENPLOT
; Pinta el enemigo.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D5,-(A7)
            
            ; Dibuja o no el sprite en función del valor de GRAPHICS
            MOVE.L  #GRAPHICS,D5
            CMP.L   #1,D5
            BEQ     .SPRITE

            ; SET PEN (CONTORNO) COLOR
            MOVE.B  #80,D0
            MOVE.L  #$FFFFFFFF,D1
            TRAP    #15

            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #$000000FF,D1
            TRAP    #15

            ; DEFINICIÓN DE COORDENADAS
            MOVE.W  (A0),D1
            SUB.W   #ENWIDTH/2,D1          ; X IZQUIERDA
            MOVE.W  D1,D3
            ADD.W   #ENWIDTH,D3            ; X DERECHA
            MOVE.W  2(A0),D2
            SUB.W   #ENHEIGH/2,D2          ; Y ARRIBA
            MOVE.W  D2,D4
            ADD.W   #ENHEIGH,D4            ; Y ABAJO
            
            ; DIBUJADO DEL RECTÁNGULO
            MOVE.B  #87,D0
            TRAP    #15
            BRA     .END
            
.SPRITE     ; DIBUJADO SPRITE
            MOVE.L  A0,A4
            LEA.L   2(A0),A5
            LEA.L   ENIMG,A6
            JSR     SPRITEPLOT
            
.END        MOVEM.L (A7)+,D0-D5
            RTS


















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
