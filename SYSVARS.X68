*===============================================================================
* TITLE       : SYSVARS
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Variables del sistema.
*===============================================================================

; --- VARIABLES DEL TECLADO ----------------------------------------------------
; Para poner el estado del teclado
KBDVAL      DS.B    1                       ; Movimiento continuo
KBDEDGE     DS.B    1                       ; Disparo aislado

; --- TIMER INTERRUPT VARIABLES ------------------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
SCRCYCCT    DS.B    1                       ; CYCLE COUNTER
AUXCT       DS.B    1                       ; CONTADOR AUXILIAR
FPSCT       DS.B    1                       ; ALMACENA FPS ACTUALES
            






*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
