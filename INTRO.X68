; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.W   (ISCTIMER)
            RTS

; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            BTST.B  #3,(KBDEDGE)
            BEQ     .CONT
            MOVE.W  #2,(STANEXT)
.CONT       ADDQ.W  #1,(ISCTIMER)
            CMP.W   #ISCMAXTM,(ISCTIMER)
            BLT     .DONE
            MOVE.W  #1,(STANEXT)
.DONE       RTS

; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A6,-(A7)
                        
            LEA.L   MENPLOTX,A4
            LEA.L   MENPLOTY,A5
            LEA.L   TITIMG,A6
            JSR     SPRITEPLOT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0-A6

            RTS
.TXT2       DC.B    'PRESS DISP (SPACE BAR) TO START',0
            DS.W    0









*~Font name~Fixedsys~
*~Font size~24~
*~Tab type~0~
*~Tab size~4~
