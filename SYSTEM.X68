*===============================================================================
* TITLE       : SYSTEM
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.23
* DESCRIPTION : Inicialización y acceso a periféricos
*===============================================================================

; ------------------------------------------------------------------------------
SYSINIT
; Inicializa el sistema.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  #SCRPLOT,($80+SCRPLTN*4) ; instalación en TRAP #0
            MOVE.L  #KBDUPD,($80+KBDUPTN*4)  ; instalación en TRAP #1
            MOVE.L  #SNDPLAY,($80+SNDPLTN*4) ; instalación en TRAP #2
            MOVE.L  #SCRTIM,($60+SCRTIMIN*4) ; instalación en IRQ  #1
            MOVE.L  #FPSUPD,($60+FPSUPDIN*4) ; instalación en IRQ  #2
            
            JSR     SCRINIT
            JSR     KBDINIT
            JSR     SNDINIT
            JSR     DMMINIT
            
            ; SWITCH TO USER MODE Y REHABILITAR INTERRUPCIONES
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)
            
            RTE
            
; ------------------------------------------------------------------------------
SNDINIT
; Inicializa el sistema de sonido.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0-A1,-(A7)

            CLR.B   D1
            LEA.L   .SNDLIST,A0
.LOOP       MOVE.L  (A0)+,D0
            BEQ     .DONE
            MOVE.L  D0,A1
            MOVE.B  #71,D0
            TRAP    #15
            ADDQ.B  #1,D1
            BRA     .LOOP
            
.DONE       MOVEM.L (A7)+,D0-D1/A0-A1
            RTS
            
.SNDHIT     DC.B    'SND/HIT.wav',0
.SNDLIST    DC.L    .SNDHIT,0
            
; ------------------------------------------------------------------------------
SNDPLAY
; Reproducir un sonido.
; INPUT    : D7 SOUND ID
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)

            MOVE.B  #72,D0
            MOVE.B  D7,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTE
            
; ------------------------------------------------------------------------------
SCRINIT
; Inicializa la pantalla con su respectiva resolución, establece el modo de ven-
; tana, activa el doble buffer y habilita las interrupciones temporizadas.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            ; ENABLE DOUBLE BUFFER: todas las comandas van al buffer oculto
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ; SET MENU COORDS
            MOVE.W  #SCRWIDTH/2,(MENPLOTX)
            MOVE.W  #SCRHEIGH/2,(MENPLOTY)
            
            ; ENABLE TIMED INTERRUPT  1
            MOVE.B  #32,D0
            MOVE.B  #6,D1                   
            MOVE.B  #%10000000|SCRTIMIN,D2  ; IRQ de nivel 1
            MOVE.L  #1000/SCRFPS,D3         ; Cada 1000/FPSms
            TRAP    #15
            
            ; ENABLE TIMED INTERRUPT  2
            MOVE.B  #32,D0
            MOVE.B  #6,D1                   
            MOVE.B  #%10000000|FPSUPDIN,D2  ; IRQ de nivel 2
            MOVE.L  #4000,D3                ; Cada 4s
            TRAP    #15
            
            ; CLEAR INTERRUPT COUNTERS
            CLR.L   (SCRINTCT)              ; CLEARS SCRINTCT, SCRCYCCT,
                                            ; AUXCT & FPSCT
                                            
            MOVEM.L (A7)+,D0-D3
            RTS
            
; ------------------------------------------------------------------------------
SCRPLOT
; Actualiza el doble buffer.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D1,-(A7)

            ; INTERCAMBIAR BUFFERS: hacer visible el buffer oculto
            MOVE.B  #94,D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER: borrado de pantalla dirigido al buffer oculto
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVEM.W (A7)+,D0-D1
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM
; TIMED INTERRUPT SERVICE ROUTINE.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)           ; Igual, pero no se le hace CLR
            RTE
            
; ------------------------------------------------------------------------------
FPSUPD
; Mostrar fps.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  D0,-(A7)

            CLR.L   D0
            MOVE.B  (AUXCT),D0
            LSR.B   #2,D0                   ; DIVISIÓN ENTRE 4, para hacer la
                                            ; media de FPS en 4 segundos

            ; GUARDADO DEL RESULTADO EN LA VARIABLE CORRESPONDIENTE                                
            MOVE.B  D0,(FPSCT)
            
            ; RESET DEL CONTADOR AUXILIAR
            CLR.B   (AUXCT)
            
            MOVE.L  (A7)+,D0
            RTE
            
; ------------------------------------------------------------------------------
KBDINIT
; Inicializa el teclado.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.B   (KBDVAL)
            CLR.B   (KBDEDGE)
            RTS
            
; ------------------------------------------------------------------------------
KBDUPD
; Actualiza el teclado.
; 7 -> UP
; 6 -> LEFT
; 5 -> DOWN
; 4 -> RIGHT
; 3 -> DISP
; 2 -> PAUSE (no implementado)
; 1 -> 00
; 0 -> 00
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3,-(A7)

            ; LEER PRIMERA PARTE
            MOVE.B  #19,D0
            MOVE.L  #KBDUP<<24|KBDLEFT<<16|KBDDOWN<<8|KBDRIGHT,D1
            TRAP    #15
            
            JSR     .CONVERT
            
            ; LEER SEGUNDA PARTE
            MOVE.B  #19,D0
            MOVE.L  #KBDDISP<<24|KBDPAUSE<<16|%00000000<<8|%00000000,D1
            TRAP    #15
            
            JSR     .CONVERT
            
            ; CALCULO KBDEDGE
            MOVE.B  (KBDVAL),D0             ; VALOR ANTERIOR DE KBDVAL
            NOT.B   D0                      ; KBDVAL ANTERIOR NEGADO
            AND.B   D2,D0                   ; KBDEDGE
            MOVE.B  D0,(KBDEDGE)
            
            ; GUARDAR KBDVAL
            MOVE.B  D2,(KBDVAL)
            
            MOVEM.L (A7)+,D0-D3
            
            RTE
            
.CONVERT    ; CONVERTIR AL FORMATO DESEADO
            MOVE.W  #3,D3
.LOOP       LSL.L   #8,D1
            ROXL    #1,D2
            DBRA.W  D3,.LOOP
            RTS
            
            
            
            
            
            
            
            








*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
