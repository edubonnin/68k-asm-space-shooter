*===============================================================================
* TITLE       : NAVE
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Código relacionado con el tipo de agente nave (jugador).
*===============================================================================

; ------------------------------------------------------------------------------
NAVINIT
; Inicializa la nave.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; POSICIÓN INICIAL
            MOVE.W  #NAVWIDTH*2,(NAVPOSX)
            MOVE.W  #SCRHEIGH/2,(NAVPOSY)
            RTS
            
; ------------------------------------------------------------------------------
NAVUPD
; Actualiza la nave.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)

; UPDATE COORDINATE X
            MOVE.W  (NAVPOSX),D0
            BTST.B  #6,(KBDVAL)             ; CHECK LEFT
            BEQ     .CHKRGT                 ; si NO está activo el bit, salta
            SUB.W   #NAVSPEED,D0
.CHKRGT     BTST.B  #4,(KBDVAL)             ; CHECK RIGHT
            BEQ     .CHKCOLX                ; si NO está activo el bit, salta
            ADD.W   #NAVSPEED,D0
            
.CHKCOLX    ; CHECK COLLISIONS
            CMP.W   #NAVWIDTH/2,D0          ; CHECK UP COLLISION
            BGE     .CHKCOL2                ; si >= no hay colisión derecha
            MOVE.W  #NAVWIDTH/2,D0          ; AJUSTE
            BRA     .UPDCOORDY
.CHKCOL2    CMP.W   #SCRWIDTH-NAVWIDTH/2,D0
            BLE     .UPDCOORDY              ; si <= no hay colisión izquierda
            MOVE.W  #SCRWIDTH-NAVWIDTH/2,D0 ; AJUSTE

; UPDATE COORDINATE Y
.UPDCOORDY  MOVE.W  (NAVPOSY),D1
            BTST.B  #7,(KBDVAL)             ; CHECK UP
            BEQ     .CHKDWN                 ; si NO está activo el bit, salta
            SUB.W   #NAVSPEED,D1
.CHKDWN     BTST.B  #5,(KBDVAL)             ; CHECK DOWN
            BEQ     .CHKCOLY                ; si NO está activo el bit, salta
            ADD.W   #NAVSPEED,D1
            
.CHKCOLY    ; CHECK COLLISIONS
            CMP.W   #NAVHEIGH/2,D1          ; CHECK UP COLLISION
            BGE     .CHKCOLY2               ; si >= no hay colisión arriba
            MOVE.W  #NAVHEIGH/2,D1          ; AJUSTE
            BRA     .DONE
.CHKCOLY2   CMP.W   #SCRHEIGH-NAVHEIGH/2,D1
            BLE     .DONE                   ; si <= no hay colisión abajo
            MOVE.W  #SCRHEIGH-NAVHEIGH/2,D1 ; AJUSTE
            
.DONE       ; UPDATE VARS
            MOVE.W  D0,(NAVPOSX)
            MOVE.W  D1,(NAVPOSY)
            
            MOVEM.W (A7)+,D0-D1
            RTS
            
; ------------------------------------------------------------------------------
NAVPLOT
; Pinta la nave.
; INPUT    : NONE
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
            MOVE.L  #NAVCOLP,D1
            TRAP    #15

            ; SET FILL COLOR
            MOVE.B  #81,D0
            MOVE.L  #NAVCOLF,D1
            TRAP    #15

            ; DEFINICIÓN DE COORDENADAS
            MOVE.W  (NAVPOSX),D1
            SUB.W   #NAVWIDTH/2,D1          ; X IZQUIERDA
            MOVE.W  D1,D3
            ADD.W   #NAVWIDTH,D3            ; X DERECHA
            MOVE.W  (NAVPOSY),D2
            SUB.W   #NAVHEIGH/2,D2          ; Y ARRIBA
            MOVE.W  D2,D4
            ADD.W   #NAVHEIGH,D4            ; Y ABAJO
            
            ; DIBUJADO DEL RECTÁNGULO
            MOVE.B  #87,D0
            TRAP    #15
            BRA     .END
            
.SPRITE     ; DIBUJADO SPRITE
            LEA.L   NAVPOSX,A4
            LEA.L   NAVPOSY,A5
            LEA.L   NAVIMG,A6
            JSR     SPRITEPLOT
            
.END        MOVEM.L (A7)+,D0-D5
            RTS





















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
