*===============================================================================
* TITLE       : CONST
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Definición de constantes.
*===============================================================================

; --- CONSTANTES ASTEROIDES ----------------------------------------------------

ASTRAD      EQU     16                      ; RADIO ASTEROIDE
ASTSPEED    EQU     3                       ; MAGNITUD VELOCIAD ASTEROIDE
ASTCOLP     EQU     $00000000               ; ASTEROIDE PEN COLOR
ASTCOLF     EQU     $0000AA00               ; ASTEROIDE FILL COLOR

; --- CONSTANTES NAVE ----------------------------------------------------------

NAVWIDTH    EQU     64                      ; ANCHURA NAVE
NAVHEIGH    EQU     32                      ; ALTURA NAVE   
NAVSPEED    EQU     11                      ; MAGNITUD VELOCIDAD NAVE
NAVCOLP     EQU     $00000000               ; NAVE PEN COLOR
NAVCOLF     EQU     $00DD0000               ; NAVE FILL COLOR
VIDINIC     EQU     3                       ; VIDAS INICIALES

; --- CONSTANTES SCOREBOARD ----------------------------------------------------

SCORECOLF   EQU     $00000000               ; TEXTO FILL COLOR
SCORECORDS  EQU     $0101                   ; COORDENADAS TEXTO 'SCORE'
VIDASCORDS  EQU     $0102                   ; COORDENADAS TEXTO 'VIDAS'
FPSCORDS    EQU     $2A01                   ; COORDENADAS TEXTO INFO FPS

; --- CONSTANTES ENEMIGO -------------------------------------------------------

ENWIDTH     EQU     32
ENHEIGH     EQU     32
ENSPEED     EQU     5

; --- CONSTANTES DISPARO -------------------------------------------------------

DISPWIDTH   EQU     16
DISPHEIGH   EQU     8
DISPSPEED   EQU     15

; --- STATE RELATED CONSTANTS --------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER
ISCMAXTM    EQU     100                     ; INTRO SCREEN WATING CYCLES
INSMAXTM    EQU     500                     ; INSTRUCTIONS SCREEN WAITING CYCLES

; --- VICTORY/DEFEAT CONSTANTS -------------------------------------------------

NOLIVES     EQU     0
SCOWIN      EQU     70


















*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
