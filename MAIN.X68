*===============================================================================
* TITLE       : MAIN
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Programa principal del videojuego.
*===============================================================================
            
            ORG    	$1000
            
            INCLUDE "CONST.X68"
            INCLUDE "SYSCONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "SCOREBOARD.X68"
            INCLUDE "ASTEROIDE.X68"
            INCLUDE "ENEMIGO.X68"
            INCLUDE "DISPARO.X68"
            INCLUDE "NAVE.X68"
            INCLUDE "GAME.X68"
            INCLUDE "INTRO.X68"
            INCLUDE "INSTRUCTIONS.X68"
            INCLUDE "WIN.X68"
            INCLUDE "GOVER.X68"
            INCLUDE "SPRITEPLOT.X68"
            INCLUDE "SPRITENAVE.X68"
            INCLUDE "SPRITEASTEROIDE.X68"
            INCLUDE "SPRITEENEMIGO.X68"
            INCLUDE "SPRITEDISPARO.X68"
            INCLUDE "STATES.X68"
            INCLUDE "TITLEINTRO.X68"
            INCLUDE "GMOSPRITE.X68"
            INCLUDE "WINSPRITE.X68"
            
START

; --- INICIALIZACIÓN -----------------------------------------------------------
            
            ; DESHABILITAR INTERRUPCIONES
            ORI.W   #$0700,SR
            
            JSR     SYSINIT
            JSR     UTLINIT
            JSR     STAINIT

.LOOP
; --- UPDATE -------------------------------------------------------------------
            
; READ INPUT DEVICES (lectura de teclado y guardado en RAM)

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC (acceso a RAM)

            JSR     STAUPD
            
; --- SYNC ------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT INTERRUPT
            BEQ     .WINT                   ; Si el contador es 0 vuelve a WINT
            CLR.B   (SCRINTCT)
            
; --- PLOT ---------------------------------------------------------------------

            JSR     STAPLOT
            ADDQ.B  #1,(AUXCT)              ; Cada vez que pinta, suma 1 a AUXCT
            TRAP    #SCRPLTN                ; UPDATE DOUBLE BUFFER
            BRA     .LOOP

	SIMHALT
		
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "SYSVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"

	END    	START





























*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
