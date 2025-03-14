*===============================================================================
* TITLE       : SYSCONST
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Constantes del sistema.
*===============================================================================

; --- CONSTANTES PANTALLA ------------------------------------------------------

SCRWIDTH    EQU     900                     ; ANCHURA PANTALLA
SCRHEIGH    EQU     550                     ; ALTURA PANTALLA
SCRFPS      EQU     60                      ; FPS

; --- KEYCODES -----------------------------------------------------------------

KBDUP       EQU     'W'
KBDLEFT     EQU     'A'
KBDDOWN     EQU     'S'
KBDRIGHT    EQU     'D'
KBDDISP     EQU     ' '
KBDPAUSE    EQU     'P'

; --- SOUND ID's ---------------------------------------------------------------

SNDHIT      EQU     0

; --- TRAP NUMBERS -------------------------------------------------------------

SCRPLTN     EQU     0                       ; SCREEN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRTIMIN    EQU     1                       ; TIMED INTERRUPT NUMBER
FPSUPDIN    EQU     2                       ; TIMED FPS UPDATE INTERRUPT NUMBER

; --- ENABLE SPRITES -----------------------------------------------------------

GRAPHICS    EQU     0                       ; ACTIVA LA VISUALIZACIÓN DE LOS
                                            ; SPRITES








































*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
