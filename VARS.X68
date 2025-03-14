*===============================================================================
* TITLE       : VARS
* WRITTEN BY  : Eduardo Bonnín Narváez y Vicenç Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : Declaración de variables.
*===============================================================================

; --- VARIABLES NAVE -----------------------------------------------------------

NAVPOSX     DS.W    1                       ; POSICIÓN DE LA NAVE EN X
NAVPOSY     DS.W    1                       ; POSICIÓN DE LA NAVE EN Y

; --- SCOREBOARD ---------------------------------------------------------------

SCORE       DS.W    1                       ; PUNTUACIÓN
VIDAS       DS.W    1                       ; VIDAS RESTANTES

; --- VARIABLES ENEMIGO --------------------------------------------------------

ENNUM       DS.W    1                       ; NÚMERO DE ENEMIGOS ACTUAL

; --- INTRO STATE RELATED VARIABLES --------------------------------------------

ISCTIMER    DS.W    1                       ; INTRO TIMER

; --- INSTRUCTIONS STATE RELATED VARIABLES -------------------------------------

INSTIMER    DS.W    1                       ; INSTRUCTIONS TIMER

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- PLOT MENUS VARIABLES -----------------------------------------------------

MENPLOTX    DS.W    1
MENPLOTY    DS.W    1











*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
