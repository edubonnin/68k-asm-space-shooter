*===============================================================================
* TITLE       : SCOREBOARD
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Código relacionado con la inicialización e impresión del score-
*               board en pantalla.
*===============================================================================

; ------------------------------------------------------------------------------
SCOINIT
; Inicializa el scoreboard.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (SCORE)
            MOVE.W  #VIDINIC,(VIDAS)
            RTS
            
; ------------------------------------------------------------------------------
SCOUPD
; Actualiza el scoreboard.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS
            
; ------------------------------------------------------------------------------
SCOPLOT
; Pinta el scoreboard.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)

            ; SET TEXT BACKGORUND COLOR
            MOVE.B  #81,D0
            MOVE.L  #SCORECOLF,D1
            TRAP    #15
            
            ; SET FIRST LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #SCORECORDS,D1
            TRAP    #15

            ; PRINT FIRST LINE
            LEA     .TXT1,A1
            CLR.L   D1
            MOVE.W  (SCORE),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET SECOND LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #VIDASCORDS,D1
            TRAP    #15
            
            ; PRINT SECOND LINE
            LEA     .TXT2,A1
            CLR.L   D1
            MOVE.W  (VIDAS),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET THIRD LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #FPSCORDS,D1
            TRAP    #15
            
            ; PRINT THIRD LINE
            LEA     .TXT3,A1
            MOVE.L  #SCRFPS,D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET FOURTH LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #FPSCORDS+$0900,D1
            TRAP    #15
            
            ; PRINT FOURTH LINE
            LEA     .TXT4,A1
            CLR.L   D1
            MOVE.B  (FPSCT),D1
            MOVE.B  #17,D0
            TRAP    #15
            
            ; SET FIFTH LINE POSITION
            MOVE.B  #11,D0
            MOVE.W  #FPSCORDS+$1A00,D1
            TRAP    #15
            
            ; PRINT FIFTH LINE
            LEA     .TXT5,A1
            MOVE.B  #14,D0
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1/A1
            
            RTS
            
.TXT1       DC.B    'SCORE: ',0
.TXT2       DC.B    'VIDAS: ',0
.TXT3       DC.B    'GOAL: ',0
.TXT4       DC.B    'FPS - ACTUAL: ',0
.TXT5       DC.B    'FPS',0
            DS.W    0

            
            
            













*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
