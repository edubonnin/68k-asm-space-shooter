*===============================================================================
* TITLE       : GAME MANAGEMENT
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Gestión del juego.
*===============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; Inicializa el juego.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     DMMINIT
            JSR     SCOINIT
            CLR.W   (ENNUM)
            BRA     NAVINIT                 

; ------------------------------------------------------------------------------
GAMUPD
; Actualiza el juego.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            
; --- ENEMIGO
            MOVE.B  (SCRCYCCT),D0
            AND.B   #%11111111,D0           ; Cada X ciclos se genera una nave
            BNE     .SKIP
            
            CMP.W   #3,(ENNUM)
            BGE     .SKIP
            
            ; CREACIÓN AGENTE TIPO ENEMIGO
            LEA.L   ENINIT,A1
            LEA.L   ENUPD,A2
            LEA.L   ENPLOT,A3
            MOVE.W  #2,D0
            JSR     AGLADD
            ADDQ.W  #1,(ENNUM)
 
; --- ASTEROIDE
.SKIP       MOVE.B  (SCRCYCCT),D0
            AND.B   #%00011111,D0           ; Cada X ciclos se genera un ast.
            BNE     .GOUPD

            ; CREACIÓN AGENTE TIPO ASTEROIDE
            LEA.L   ASTINIT,A1              ; Puntero a función inicialización
            LEA.L   ASTUPD,A2
            LEA.L   ASTPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD
            
; --- UPDATE
.GOUPD      JSR     SCOUPD
            JSR     AGLUPD
            JSR     NAVUPD
            
            CMP.W   #SCOWIN,(SCORE)
            BLT     .CHKLOSS
            MOVE.W  #3,(STANEXT)
            BRA     .DONE
            
.CHKLOSS    CMP.W   #NOLIVES,(VIDAS)
            BGT     .DONE
            MOVE.W  #4,(STANEXT)
            
.DONE       MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; Pinta el juego.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     SCOPLOT
            JSR     AGLPLOT
            BRA     NAVPLOT























*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
