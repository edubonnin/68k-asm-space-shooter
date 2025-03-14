; ==============================================================================
; GAME OVER SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
GOVUPD
; GAME OVER SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #3,(KBDEDGE)
            BEQ     .CONT
            CLR.W   (STANEXT)
.CONT       RTS

; ------------------------------------------------------------------------------
GOVPLOT
; GAME OVER SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A6,-(A7)

            LEA.L   MENPLOTX,A4
            LEA.L   MENPLOTY,A5
            LEA.L   GMOIMG,A6
            JSR     SPRITEPLOT

            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0-A6

            RTS
.TXT        DC.B    'PRESS DISP (SPACE BAR) TO CONTINUE',0
            DS.W    0








*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
