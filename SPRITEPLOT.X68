*===============================================================================
* TITLE       : SPRITEPLOT
* WRITTEN BY  : Eduardo Bonn�n Narv�ez y Vicen� Servera Ferrer
* DATE        : 16.01.2023
* DESCRIPTION : C�digo relacionado con la inicializaci�n e impresi�n del score-
*               board en pantalla.
*===============================================================================

; ------------------------------------------------------------------------------
SPRITEPLOT
            MOVEM.W D0-D7/A1,-(A7)
            MOVEA.L A6, A1                  ; OBTENEMOS LA POSICI�N DEL VECTOR DE DATOS
            MOVE.L  (A1)+,D6                ; MOVEMOS LA ALTURA (PRIMER VALOR QUE APARECE) A UN REGISTRO DE DATOS
            MOVE.L  (A1)+,D7                ; MOVEMOS LA ANCHURA (SEGUNDO VALOR QUE APARECE) A UN REGISTRO DE DATOS
            
            MOVE.W  (A4),D4                 ; OBTENEMOS LA POSICI�N DE X DEL OBJETO
            MOVE.W  D7,D0
            LSR.W   #1,D0                   ; DIVISI�N ENTRE 2
            SUB.W   D0,D4
            MOVE.W  D4,D3
            MOVE.W  (A5),D5                 ; OBTENEMOS LA POSICI�N DE Y DEL OBJETO
            MOVE.W  D6,D0
            LSR.W   #1,D0
            SUB.W   D0,D5
            MULS.W  D7,D6                   ; OBTENEMOS EL N�MERO DE ITERACIONES
            SUB.L   #1,D6
            SUB.L   #1,D7
                                            
LOOP        MOVE.L  (A1)+,D1
            CMP.L   #$00000000,D1
            BEQ     .SKIP                 
            MOVE.W  #80,D0                  ; HACIENDO USO DEL TRAP SETEAMOS EL COLOR CORRESPONDIENTE AL PINCEL
            TRAP    #15
            
            MOVE.W  #82,D0                  ; CON EL USO DEL TRAP PINTAMOS EL PIXEL CORRESPONDIENTE
            MOVE.W  D4,D1                   ; D4 SERA LA LOCALIZACI�N DE X
            MOVE.W  D5,D2                   ; D5 SERA LA LOCALOZACI�N DE Y
            TRAP    #15
    
.SKIP       SUB.W   D3,D4            
            CMP.W   D7,D4                   ; COMPARAMOS SI EL VALOR DE PIXEL EN X ES IGUAL A EL VALOR DE LA ANCHURA
            BNE     NOMAX                   ; EN ESE CASO SALTAREMOS
            CLR.W   D4                      ; EN EL CASO CONTRARIO VOLVEMOS AL INICIO EN LAS COLUMNAS
            SUBQ.W  #1,D4
            ADDQ.W  #1,D5                   ; AUMENTAMOS ES 1 LA Y (FILA)
NOMAX       ADDQ.W  #1,D4
            ADD.W   D3,D4
            DBRA    D6,LOOP
            
            MOVEM.W (A7)+,D0-D7/A1
            RTS



            













*~Font name~Fixedsys~
*~Font size~18~
*~Tab type~0~
*~Tab size~4~
