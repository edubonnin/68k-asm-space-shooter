*===============================================================================
* TITLE       : DISPARO (AGENT)
;             OFFSETS RESPECTO DIRECCIÓN BASE
; DISPPOSX (W)  (A0)
; DISPOSY  (W) 2(A0)

* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.23
* DESCRIPTION : Código relacionado con el disparo generado por el enemigo. Es
*               un agente que a su vez está generado por otro agente ENEMIGO.
*===============================================================================

; ------------------------------------------------------------------------------
DISPINIT
; Inicializa el disparo.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
;            D1: COORDENADA Y DEL DISPARO
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; INICIALIZACIÓN POSICIONES
            MOVE.W  #SCRWIDTH-4*ENWIDTH,(A0)
            MOVE.W  D1,2(A0)
            RTS
                        
; ------------------------------------------------------------------------------
DISPUPD
; Actualiza el disparo.
; INPUT    : AO POINTER TO THE INSTANCE VARIABLES
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D2,-(A7)
            
            ; ACTUALIZACIÓN DE COORDENADAS
            MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            
            ; SUMA VELOCIDAD
            SUB.W   #DISPSPEED,D0
            
            ; CHECK SALIDA POR LA IZQUIERDA
            CMP.W   #DISPWIDTH/2,D0
            BGT     .COLNAV
            JSR     AGLKILL
            
.COLNAV     JSR     UTLCOLNAV               ; CHECK COLISIÓN CON NAVE
            
            ; ALMACENAR POSICIÓN
            MOVE.W  D0,(A0)
            MOVE.W  D1,2(A0)
            
            MOVEM.W (A7)+,D0-D2
            RTS
            
; ------------------------------------------------------------------------------
DISPPLOT
; Pinta el disparo.
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
            MOVE.L  #$00BB0000,D1
            TRAP    #15

            ; DEFINICIÓN DE COORDENADAS
            MOVE.W  (A0),D1
            SUB.W   #DISPWIDTH/2,D1          ; X IZQUIERDA
            MOVE.W  D1,D3
            ADD.W   #DISPWIDTH,D3            ; X DERECHA
            MOVE.W  2(A0),D2
            SUB.W   #DISPHEIGH/2,D2          ; Y ARRIBA
            MOVE.W  D2,D4
            ADD.W   #DISPHEIGH,D4            ; Y ABAJO
            
            ; DIBUJADO DEL RECTÁNGULO
            MOVE.B  #87,D0
            TRAP    #15
            BRA     .END
            
.SPRITE     ; DIBUJADO SPRITE
            MOVE.L  A0,A4
            LEA.L   2(A0),A5
            LEA.L   DISPIMG,A6
            JSR     SPRITEPLOT

.END        MOVEM.L (A7)+,D0-D5
            RTS


























*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
