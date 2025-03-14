; ==============================================================================
; VICTORY SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
WINUPD
; VICTORY SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #3,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       RTS

; ------------------------------------------------------------------------------
WINPLOT
; VICTORY SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            LEA.L   MENPLOTX,A4
            LEA.L   MENPLOTY,A5
            LEA.L   WINIMG,A6
            JSR     SPRITEPLOT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
            
.TXT1       DC.B    'YOU WON!',0
.TXT2       DC.B    'PRESS DISP (SPACE BAR) TO CONTINUE',0
            DS.W    0









*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
