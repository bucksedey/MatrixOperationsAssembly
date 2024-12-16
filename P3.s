/*
 * File:   %<%NAME%>%.%<%EXTENSION%>%
 * Author: %<%USER%>%
 *
 * Created on %<%DATE%>%, %<%TIME%>%
 */

    .include "p33fj32mc202.inc"

    ; _____________________Configuration Bits_____________________________
    ;User program memory is not write-protected
    #pragma config __FGS, GWRP_OFF & GSS_OFF & GCP_OFF
    
    ;Internal Fast RC (FRC)
    ;Start-up device with user-selected oscillator source
    #pragma config __FOSCSEL, FNOSC_FRC & IESO_ON
    
    ;Both Clock Switching and Fail-Safe Clock Monitor are disabled
    ;XT mode is a medium-gain, medium-frequency mode that is used to work with crystal
    ;frequencies of 3.5-10 MHz
  ; #pragma config __FOSC, FCKSM_CSDCMD & POSCMD_XT
    
    ;Watchdog timer enabled/disabled by user software
    #pragma config __FWDT, FWDTEN_OFF
    
    ;POR Timer Value
    #pragma config __FPOR, FPWRT_PWR128
   
    ; Communicate on PGC1/EMUC1 and PGD1/EMUD1
    ; JTAG is Disabled
    #pragma config __FICD, ICS_PGD1 & JTAGEN_OFF

;..............................................................................
;Program Specific Constants (literals used in code)
;..............................................................................

    .equ SAMPLES, 64         ;Number of samples



;..............................................................................
;Global Declarations:
;..............................................................................

    .global _wreg_init       ;Provide global scope to _wreg_init routine
                                 ;In order to call this routine from a C file,
                                 ;place "wreg_init" in an "extern" declaration
                                 ;in the C file.

    .global __reset          ;The label for the first line of code.

;..............................................................................
;Constants stored in Program space
;..............................................................................

    .section .myconstbuffer, code
    .palign 2                ;Align next word stored in Program space to an
                                 ;address that is a multiple of 2
ps_coeff:
    .hword   0x0002, 0x0003, 0x0005, 0x000A




;..............................................................................
;Uninitialized variables in X-space in data memory
;..............................................................................

    .section .xbss, bss, xmemory
x_input: .space 2*SAMPLES        ;Allocating space (in bytes) to variable.



;..............................................................................
;Uninitialized variables in Y-space in data memory
;..............................................................................

    .section .ybss, bss, ymemory
y_input:  .space 2*SAMPLES




;..............................................................................
;Uninitialized variables in Near data memory (Lower 8Kb of RAM)
;..............................................................................

    .section .nbss, bss, near
var1:     .space 2               ;Example of allocating 1 word of space for
                                 ;variable "var1".




;..............................................................................
;Code Section in Program Memory
;..............................................................................

.text                             ;Start of Code section
__reset:
    MOV #__SP_init, W15       ;Initalize the Stack Pointer
    MOV #__SPLIM_init, W0     ;Initialize the Stack Pointer Limit Register
    MOV W0, SPLIM
    NOP                       ;Add NOP to follow SPLIM initialization

    CALL _wreg_init           ;Call _wreg_init subroutine
                                  ;Optionally use RCALL instead of CALL

SETM    AD1PCFGL		;PORTB AS DIGITAL
CLR	TRISB			;PORTB AS OUTPUTS
SETM	PORTB			;PORTB = 0XFFFF

;Case 0 MultiplicacionAB 
;Case 1 SumaAB
;Case 2 RestaAB 
;Case 3 RestaBA
;Case 4 DeterminanteA
;Case 5 DeterminanteB
;Case 6 TranspuestaA
;Case 7 TranspuestaB
;Case 8 NumeroMayorA
;Case 9 NumeroMenorB
;Case A AscenA
;Case B DescenB
MOV #0x0, W10	     ;Inicializamos el selector

; Inicializar matriz A en direcciones de 0x0800
MOV #0x0800, W1      ; W1 apunta a la dirección de la primera celda de A
MOV #1, W0	     ; Valor que se guardara
MOV W0,	[W1++]       ; Asigna Valor de A[0][0]
MOV #2, W0	     ; Valor que se guardara
MOV W0,	[W1++]       ; Asigna Valor de A[0][1]
MOV #3, W0	     ; Valor que se guardara
MOV W0,	[W1++]       ; Asigna Valor de A[0][2]
MOV #0x0800, W1      ; W1 apunta a la dirección de la primera celda de A

MOV #0x0810, W2      ; W2 apunta a la dirección de la cuarta celda de A
MOV #4, W0	     ; Valor que se guardara
MOV W0,	[W2++]       ; Asigna Valor de A[1][0]
MOV #5, W0	     ; Valor que se guardara
MOV W0,	[W2++]       ; Asigna Valor de A[1][1]
MOV #6, W0	     ; Valor que se guardara
MOV W0,	[W2++]       ; Asigna Valor de A[1][2]
MOV #0x0810, W2      ; W2 apunta a la dirección de la primera celda de A

MOV #0x0820, W3      ; W3 apunta a la dirección de la septima celda de A
MOV #7, W0	     ; Valor que se guardara
MOV W0,	[W3++]       ; Asigna Valor de A[2][0]
MOV #8, W0	     ; Valor que se guardara
MOV W0,	[W3++]       ; Asigna Valor de A[2][1]
MOV #9, W0	     ; Valor que se guardara
MOV W0,	[W3++]       ; Asigna Valor de A[2][2]
MOV #0x0820, W3      ; W3 apunta a la dirección de la primera celda de A]

				  
; Inicializar matriz B en direcciones de 0x0808
MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
MOV #11, W0	     ; Valor que se guardara
MOV W0,	[W4++]       ; Asigna Valor de B[0][0]
MOV #12, W0	     ; Valor que se guardara
MOV W0,	[W4++]       ; Asigna Valor de B[0][1]
MOV #13, W0	     ; Valor que se guardara
MOV W0,	[W4++]       ; Asigna Valor de B[0][2]
MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B

MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
MOV #14, W0	     ; Valor que se guardara
MOV W0,	[W5++]       ; Asigna Valor de B[1][0]
MOV #15, W0	     ; Valor que se guardara
MOV W0,	[W5++]       ; Asigna Valor de B[1][1]
MOV #16, W0	     ; Valor que se guardara
MOV W0,	[W5++]       ; Asigna Valor de B[1][2]
MOV #0x0818, W5      ; W5 apunta a la dirección de la primera celda de B

MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
MOV #17, W0	     ; Valor que se guardara
MOV W0,	[W6++]       ; Asigna Valor de B[2][0]
MOV #18, W0	     ; Valor que se guardara
MOV W0,	[W6++]       ; Asigna Valor de B[2][1]
MOV #19, W0	     ; Valor que se guardara
MOV W0,	[W6++]       ; Asigna Valor de B[2][2]
MOV #0x0828, W6      ; W6 apunta a la dirección de la primera celda de B
				  
; Inicializar matriz C en direcciones de 0x0840
MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C
				  
				  
; Switch Case
CP W10, #0x0      ; Case 0
BRA Z, MultiplicacionAB

CP W10, #0x1      ; Case 1
BRA Z, SumaAB

CP W10, #0x2      ; Case 2
BRA Z, RestaAB          

CP W10, #0x3      ; Case 3
BRA Z, RestaBA          

CP W10, #0x4      ; Case 4
BRA Z, DeterminanteA    

CP W10, #0x5      ; Case 5
BRA Z, DeterminanteB 

CP W10, #0x6      ; Case 6
BRA Z, TranspuestaA

CP W10, #0x7      ; Case 7
BRA Z, TranspuestaB

CP W10, #0x8      ; Case 8
BRA Z, NumeroMayorA

CP W10, #0x9      ; Case 9
BRA Z, NumeroMenorB

CP W10, #0xA      ; Case 10
BRA Z, AscenA           

CP W10, #0xB      ; Case 11
BRA Z, DescenB          

BRA done           ; Si no coincide con ningún caso, saltar a done

; Etiquetas de las operaciones
MultiplicacionAB:
    ;C[0][0]
    MOV [W1++], W11        ; Guardamos el valor de A[0][0] en W11
    MUL.UU W11, [W4], W12  ; Multiplicamos A[0][0] con B[0][0], resultado en W12 (parte baja) y W13 (parte alta)
    MOV W12, W14           ; Guardar la parte baja de la multiplicación en W14

    MOV [W1++], W11        ; Guardamos el valor de A[0][1] en W11
    MUL.UU W11, [W5], W12  ; Multiplicamos A[0][1] con B[1][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV [W1], W11          ; Guardamos el valor de A[0][2] en W11
    MUL.UU W11, [W6], W12  ; Multiplicamos A[0][2] con B[2][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV W14, [W7]          ; Guardar el resultado en la dirección apuntada por W7 (C[0][0])

    ;C[1][0]
    MOV [W2++], W11        ; Guardamos el valor de A[1][0] en W11
    MUL.UU W11, [W4], W12  ; Multiplicamos A[1][0] con B[0][0], resultado en W12 (parte baja) y W13 (parte alta)
    MOV W12, W14           ; Guardar la parte baja de la multiplicación en W14

    MOV [W2++], W11        ; Guardamos el valor de A[1][1] en W11
    MUL.UU W11, [W5], W12  ; Multiplicamos A[1][1] con B[1][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV [W2], W11          ; Guardamos el valor de A[1][2] en W11
    MUL.UU W11, [W6], W12  ; Multiplicamos A[1][2] con B[2][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV W14, [W8]          ; Guardar el resultado en la dirección apuntada por W8 (C[1][0])
    
    ;C[2][0]
    MOV [W3++], W11        ; Guardamos el valor de A[1][0] en W11
    MUL.UU W11, [W4], W12  ; Multiplicamos A[1][0] con B[0][0], resultado en W12 (parte baja) y W13 (parte alta)
    MOV W12, W14           ; Guardar la parte baja de la multiplicación en W14

    MOV [W3++], W11        ; Guardamos el valor de A[1][1] en W11
    MUL.UU W11, [W5], W12  ; Multiplicamos A[1][1] con B[1][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV [W3], W11          ; Guardamos el valor de A[1][2] en W11
    MUL.UU W11, [W6], W12  ; Multiplicamos A[1][2] con B[2][0], resultado en W12 (parte baja) y W13 (parte alta)
    ADD W14, W12, W14      ; Sumar la parte baja al acumulador W14

    MOV W14, [W9]          ; Guardar el resultado en la dirección apuntada por W9 (C[2][0])
    
    ; C[0][1] (Producto de la primera fila de A y la segunda columna de B)
    MOV #0x0800, W1        ; Reinicializamos el puntero de A (fila 0)
    MOV [W1++], W11        ; Guardamos el valor de A[0][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][1] (segunda columna)
    ADD #2, W4             ; Avanzar a la segunda columna de B
    MUL.UU W11, [W4], W12  ; Multiplicamos A[0][0] con B[0][1], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W1++], W11        ; Guardamos el valor de A[0][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][1]
    ADD #2, W5             ; Avanzar a la segunda columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[0][1] con B[1][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W1], W11          ; Guardamos el valor de A[0][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][1]
    ADD #2, W6             ; Avanzar a la segunda columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[0][2] con B[2][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W7+2]        ; Guardar el resultado final en la dirección correspondiente de C[0][1]

        ; C[1][1] (Producto de la segunda fila de A y la segunda columna de B)
    MOV #0x0810, W2        ; Reinicializamos el puntero de A (fila 1)
    MOV [W2++], W11        ; Guardamos el valor de A[1][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][1] (segunda columna)
    ADD #2, W4             ; Avanzar a la segunda columna de B[0]
    MUL.UU W11, [W4], W12  ; Multiplicamos A[1][0] con B[0][1], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W2++], W11        ; Guardamos el valor de A[1][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][1]
    ADD #2, W5             ; Avanzar a la segunda columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[1][1] con B[1][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W2], W11          ; Guardamos el valor de A[1][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][1]
    ADD #2, W6             ; Avanzar a la segunda columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[1][2] con B[2][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W8+2]        ; Guardar el resultado final en la dirección correspondiente de C[1][1]


    ; C[2][1] (Producto de la tercera fila de A y la segunda columna de B)
    MOV #0x0820, W3        ; Reinicializamos el puntero de A (fila 2)
    MOV [W3++], W11        ; Guardamos el valor de A[2][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][1] (segunda columna)
    ADD #2, W4             ; Avanzar a la segunda columna de B[0]
    MUL.UU W11, [W4], W12  ; Multiplicamos A[2][0] con B[0][1], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W3++], W11        ; Guardamos el valor de A[2][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][1]
    ADD #2, W5             ; Avanzar a la segunda columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[2][1] con B[1][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W3], W11          ; Guardamos el valor de A[2][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][1]
    ADD #2, W6             ; Avanzar a la segunda columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[2][2] con B[2][1], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W9+2]        ; Guardar el resultado final en la dirección correspondiente de C[2][1]

        ; C[0][2] (Producto de la primera fila de A y la tercera columna de B)
    MOV #0x0800, W1        ; Reinicializamos el puntero de A (fila 0)
    MOV [W1++], W11        ; Guardamos el valor de A[0][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][2] (tercera columna)
    ADD #4, W4             ; Avanzar a la tercera columna de B[0]
    MUL.UU W11, [W4], W12  ; Multiplicamos A[0][0] con B[0][2], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W1++], W11        ; Guardamos el valor de A[0][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][2]
    ADD #4, W5             ; Avanzar a la tercera columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[0][1] con B[1][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W1], W11          ; Guardamos el valor de A[0][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][2]
    ADD #4, W6             ; Avanzar a la tercera columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[0][2] con B[2][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W7+4]        ; Guardar el resultado final en la dirección correspondiente de C[0][2]


    ; C[1][2] (Producto de la segunda fila de A y la tercera columna de B)
    MOV #0x0810, W2        ; Reinicializamos el puntero de A (fila 1)
    MOV [W2++], W11        ; Guardamos el valor de A[1][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][2] (tercera columna)
    ADD #4, W4             ; Avanzar a la tercera columna de B[0]
    MUL.UU W11, [W4], W12  ; Multiplicamos A[1][0] con B[0][2], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W2++], W11        ; Guardamos el valor de A[1][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][2]
    ADD #4, W5             ; Avanzar a la tercera columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[1][1] con B[1][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W2], W11          ; Guardamos el valor de A[1][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][2]
    ADD #4, W6             ; Avanzar a la tercera columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[1][2] con B[2][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W8+4]        ; Guardar el resultado final en la dirección correspondiente de C[1][2]


    ; C[2][2] (Producto de la tercera fila de A y la tercera columna de B)
    MOV #0x0820, W3        ; Reinicializamos el puntero de A (fila 2)
    MOV [W3++], W11        ; Guardamos el valor de A[2][0] en W11
    MOV #0x0808, W4        ; Apuntamos a B[0][2] (tercera columna)
    ADD #4, W4             ; Avanzar a la tercera columna de B[0]
    MUL.UU W11, [W4], W12  ; Multiplicamos A[2][0] con B[0][2], resultado en W12
    MOV W12, W14           ; Guardar el valor parcial en W14

    MOV [W3++], W11        ; Guardamos el valor de A[2][1] en W11
    MOV #0x0818, W5        ; Apuntamos a B[1][2]
    ADD #4, W5             ; Avanzar a la tercera columna de B[1]
    MUL.UU W11, [W5], W12  ; Multiplicamos A[2][1] con B[1][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV [W3], W11          ; Guardamos el valor de A[2][2] en W11
    MOV #0x0828, W6        ; Apuntamos a B[2][2]
    ADD #4, W6             ; Avanzar a la tercera columna de B[2]
    MUL.UU W11, [W6], W12  ; Multiplicamos A[2][2] con B[2][2], resultado en W12
    ADD W14, W12, W14      ; Sumar el resultado al acumulador W14

    MOV W14, [W9+4]        ; Guardar el resultado final en la dirección correspondiente de C[2][2]

    BRA done


SumaAB:
    ; Código para suma de matrices A y B
    MOV [W1++], W11	    ;Movemos el valor de A[0][0] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][0] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][0]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][0] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][0] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][0]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][0] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][0] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][0]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][1] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][1] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][1]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][1] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][1] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][1]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][1] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][1] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][1]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][2] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][2] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][2]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][2] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][2] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][2]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][2] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][2] a W12
    ADD W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][2]
    
    MOV #0x0800, W1      ; W1 apunta a la dirección de la primera celda de A
    MOV #0x0810, W2      ; W2 apunta a la dirección de la cuarta celda de A
    MOV #0x0820, W3      ; W3 apunta a la dirección de la septima celda de A
    MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
    MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
    MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
    MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
    MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
    MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C
    BRA done

RestaAB:
    ; Código para resta de matrices A y B
    MOV [W1++], W11	    ;Movemos el valor de A[0][0] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][0] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][0]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][0] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][0] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][0]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][0] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][0] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][0]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][1] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][1] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][1]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][1] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][1] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][1]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][1] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][1] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][1]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][2] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][2] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][2]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][2] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][2] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][2]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][2] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][2] a W12
    SUB W11, W12, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][2]
    
    MOV #0x0800, W1      ; W1 apunta a la dirección de la primera celda de A
    MOV #0x0810, W2      ; W2 apunta a la dirección de la cuarta celda de A
    MOV #0x0820, W3      ; W3 apunta a la dirección de la septima celda de A
    MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
    MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
    MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
    MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
    MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
    MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C
    BRA done

RestaBA:
    ; Código para resta de matrices B y A
    MOV [W1++], W11	    ;Movemos el valor de A[0][0] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][0] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][0]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][0] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][0] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][0]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][0] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][0] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][0]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][1] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][1] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][1]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][1] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][1] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][1]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][1] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][1] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][1]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][2] a W11
    MOV [W4++], W12	    ;Movemos el valor de B[0][2] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W7++]	    ;Guardamos en C[0][2]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][2] a W11
    MOV [W5++], W12	    ;Movemos el valor de B[1][2] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W8++]	    ;Guardamos en C[1][2]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][2] a W11
    MOV [W6++], W12	    ;Movemos el valor de B[2][2] a W12
    SUB W12, W11, W13	    ;Realizamos la suma y guardamos en W13
    MOV W13, [W9++]	    ;Guardamos en C[2][2]
    
    MOV #0x0800, W1      ; W1 apunta a la dirección de la primera celda de A
    MOV #0x0810, W2      ; W2 apunta a la dirección de la cuarta celda de A
    MOV #0x0820, W3      ; W3 apunta a la dirección de la septima celda de A
    MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
    MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
    MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
    MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
    MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
    MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C
    BRA done

DeterminanteA:
; Calcular el producto de la diagonal principal de A y almacenarlo en C[0][0]
    MOV #0x0800, W1 ; Apunta a A[0][0]
    MOV [W1], W11   
    MOV #0x0812, W2 ; Apunta a A[1][1]
    MUL.UU W11, [W2], W12 ; Multiplica A[0][0] * A[1][1]
    MOV #0x0824, W3 ; Apunta a A[2][2]
    MUL.UU W12, [W3], W12 ; Multiplica el resultado anterior por A[2][2]
    ; Almacenar el resultado en C[0][0]
    MOV #0x0844, W7 ; Apunta a C[0][0]
    MOV W12, [W7]
    
    ; Calcular el producto de A[0][1], A[1][2], A[2][0] y almacenarlo en C[0][1]
    MOV #0x0802, W1 ; Apunta a A[0][1]
    MOV [W1], W11
    MOV #0x0814, W2 ; Apunta a A[1][2]
    MUL.UU W11, [W2], W12
    MOV #0x0820, W3 ; Apunta a A[2][0]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[0][1]
    MOV #0x0846, W7 ; Apunta a C[0][1]
    MOV W12, [W7]
    
    ; Calcular el producto de A[0][2], A[1][0] y A[2][1] y almacenarlo en C[0][2]
    MOV #0x0804, W1 ; Apunta a A[0][2]
    MOV [W1], W11
    MOV #0x0810, W2 ; Apunta a A[1][0]
    MUL.UU W11, [W2], W12 ; Multiplica A[0][2] * A[1][0]
    MOV #0x0822, W3 ; Apunta a A[2][1]
    MUL.UU W12, [W3], W12 ; Multiplica el resultado anterior por A[2][1]
    ; Almacenar el resultado en C[0][2]
    MOV #0x0848, W7 ; Apunta a C[0][2]
    MOV W12, [W7]
    
    ; Sumar C[0][0], C[0][1] y C[0][2] y almacenar el resultado en C[2][0]
    MOV #0x0844, W1 ; Apunta a C[0][0]
    MOV [W1], W11
    MOV #0x0846, W2 ; Apunta a C[0][1]
    ADD W11, [W2], W11
    MOV #0x0848, W2 ; Apunta a C[0][2]
    ADD W11, [W2], W11

    ; Almacenar el resultado de las diagonales positivas en C[2][0]
    MOV #0x0864, W2 ; Apunta a C[2][0]
    MOV W11, [W2]
    
    
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> DIAGONAL NEGATIVA
    ; Calcular el producto de A[0][2] * A[1][1] * A[2][0] y almacenarlo en C[1][0]
    MOV #0x0804, W1 ; Apunta a A[0][2]
    MOV [W1], W11
    MOV #0x0812, W2 ; Apunta a A[1][1]
    MUL.UU W11, [W2], W12
    MOV #0x0820, W3 ; Apunta a A[2][0]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][0]
    MOV #0x0854, W7 ; Apunta a C[1][0]
    MOV W12, [W7]    
    
    ; Calcular el producto de A[0][0] * A[1][2] * A[1][2] y almacenarlo en C[2][1]
    MOV #0x0800, W1 ; Apunta a A[0][0]
    MOV [W1], W11
    MOV #0x0814, W2 ; Apunta a A[1][2]
    MUL.UU W11, [W2], W12
    MOV #0x0822, W3 ; Apunta a A[1][2]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][2]
    MOV #0x0856, W7 ; Apunta a C[1][2]
    MOV W12, [W7]
    
    ; Calcular el producto de A[0][1] * A[1][0] * A[2][2] y almacenarlo en C[1][1]
    MOV #0x0802, W1 ; Apunta a A[0][1]
    MOV [W1], W11
    MOV #0x0810, W2 ; Apunta a A[1][0]
    MUL.UU W11, [W2], W12
    MOV #0x0824, W3 ; Apunta a A[2][2]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][1]
    MOV #0x0858, W7 ; Apunta a C[1][1]
    MOV W12, [W7]
    
    ; Sumar C[1][0], C[1][1] y C[1][2] y almacenar el resultado en C[2][1]
    MOV #0x0854, W1 ; Apunta a C[1][0]
    MOV [W1], W11
    MOV #0x0856, W2 ; Apunta a C[1][1]
    ADD W11, [W2], W11
    MOV #0x0858, W2 ; Apunta a C[1][2]
    ADD W11, [W2], W11
    ; Almacenar el resultado en C[2][1]
    MOV #0x0866, W2 ; Apunta a C[2][1]
    MOV W11, [W2]
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ; Restar C[2][1] de C[2][0] y almacenar el resultado en C[2][2]
    MOV #0x0864, W1 ; Apunta a C[2][0]
    MOV [W1], W11
    MOV #0x0866, W2 ; Apunta a C[2][1]
    
    SUB W11, [W2], W11 ; Restamos C[2][1] de C[2][0] y guardamos en W11
    ; Almacenar el resultado en C[2][2]
    MOV #0x0868, W2 ; Apunta a C[2][2]
    MOV W11, [W2]
    
    
    
    
    MOV #0x0800, W1      ; W1 apunta a la dirección de A[0][0]
    MOV #0x0810, W2      ; W2 apunta a la dirección de A[1][0]
    MOV #0x0820, W3      ; W3 apunta a la dirección de A[2][0]
    MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
    MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
    MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
    MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
    MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
    MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C
    
    BRA done

DeterminanteB:
    ; Calcular el producto de la diagonal principal de B y almacenarlo en C[0][0]
    MOV #0x0808, W1 ; Apunta a B[0][0]
    MOV [W1], W11   
    MOV #0x081A, W2 ; Apunta a B[1][1]
    MUL.UU W11, [W2], W12 ; Multiplica B[0][0] * B[1][1]
    MOV #0x082C, W3 ; Apunta a B[2][2]
    MUL.UU W12, [W3], W12 ; Multiplica el resultado anterior por B[2][2]
    ; Almacenar el resultado en C[0][0]
    MOV #0x0844, W7 ; Apunta a C[0][0]
    MOV W12, [W7]
    
    ; Calcular el producto de B[0][1], B[1][2], B[2][0] y almacenarlo en C[0][1]
    MOV #0x080A, W1 ; Apunta a B[0][1]
    MOV [W1], W11
    MOV #0x081C, W2 ; Apunta a B[1][2]
    MUL.UU W11, [W2], W12
    MOV #0x0828, W3 ; Apunta a B[2][0]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[0][1]
    MOV #0x0846, W7 ; Apunta a C[0][1]
    MOV W12, [W7]
    
    ; Calcular el producto de B[0][2], B[1][0] y B[2][1] y almacenarlo en C[0][2]
    MOV #0x080C, W1 ; Apunta a B[0][2]
    MOV [W1], W11
    MOV #0x0818, W2 ; Apunta a B[1][0]
    MUL.UU W11, [W2], W12 ; Multiplica B[0][2] * B[1][0]
    MOV #0x082A, W3 ; Apunta a B[2][1]
    MUL.UU W12, [W3], W12 ; Multiplica el resultado anterior por B[2][1]
    ; Almacenar el resultado en C[0][2]
    MOV #0x0848, W7 ; Apunta a C[0][2]
    MOV W12, [W7]
    
    ; Sumar C[0][0], C[0][1] y C[0][2] y almacenar el resultado en C[2][0]
    MOV #0x0844, W1 ; Apunta a C[0][0]
    MOV [W1], W11
    MOV #0x0846, W2 ; Apunta a C[0][1]
    ADD W11, [W2], W11
    MOV #0x0848, W2 ; Apunta a C[0][2]
    ADD W11, [W2], W11

    ; Almacenar el resultado de las diagonales positivas en C[2][0]
    MOV #0x0864, W2 ; Apunta a C[2][0]
    MOV W11, [W2]
    
    ; >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ; Calcular el producto de B[0][2] * B[1][1] * B[2][0] y almacenarlo en C[1][0]
    MOV #0x080C, W1 ; Apunta a B[0][2]
    MOV [W1], W11
    MOV #0x081A, W2 ; Apunta a B[1][1]
    MUL.UU W11, [W2], W12
    MOV #0x0828, W3 ; Apunta a B[2][0]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][0]
    MOV #0x0854, W7 ; Apunta a C[1][0]
    MOV W12, [W7]    
    
    ; Calcular el producto de B[0][0] * B[1][2] * B[2][1] y almacenarlo en C[1][2]
    MOV #0x0808, W1 ; Apunta a B[0][0]
    MOV [W1], W11
    MOV #0x081C, W2 ; Apunta a B[1][2]
    MUL.UU W11, [W2], W12
    MOV #0x082A, W3 ; Apunta a B[2][1]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][2]
    MOV #0x0856, W7 ; Apunta a C[1][2]
    MOV W12, [W7]
    
    ; Calcular el producto de B[0][1] * B[1][0] * B[2][2] y almacenarlo en C[1][1]
    MOV #0x080A, W1 ; Apunta a B[0][1]
    MOV [W1], W11
    MOV #0x0818, W2 ; Apunta a B[1][0]
    MUL.UU W11, [W2], W12
    MOV #0x082C, W3 ; Apunta a B[2][2]
    MUL.UU W12, [W3], W12
    ; Almacenar el resultado en C[1][1]
    MOV #0x0858, W7 ; Apunta a C[1][1]
    MOV W12, [W7]
    
    ; Sumar C[1][0], C[1][1] y C[1][2] y almacenar el resultado en C[2][1]
    MOV #0x0854, W1 ; Apunta a C[1][0]
    MOV [W1], W11
    MOV #0x0856, W2 ; Apunta a C[1][1]
    ADD W11, [W2], W11
    MOV #0x0858, W2 ; Apunta a C[1][2]
    ADD W11, [W2], W11
    ; Almacenar el resultado en C[2][1]
    MOV #0x0866, W2 ; Apunta a C[2][1]
    MOV W11, [W2]
    
    ; Restar C[2][1] de C[2][0] y almacenar el resultado en C[2][2]
    MOV #0x0864, W1 ; Apunta a C[2][0]
    MOV [W1], W11
    MOV #0x0866, W2 ; Apunta a C[2][1]
    SUB W11, [W2], W11 ; Restamos C[2][1] de C[2][0] y guardamos en W11
    ; Almacenar el resultado en C[2][2]
    MOV #0x0868, W2 ; Apunta a C[2][2]
    MOV W11, [W2]
    
    ; Reinicializamos los apuntadores de A, B y C
    MOV #0x0800, W1      ; W1 apunta a la dirección de A[0][0]
    MOV #0x0810, W2      ; W2 apunta a la dirección de A[1][0]
    MOV #0x0820, W3      ; W3 apunta a la dirección de A[2][0]
    MOV #0x0808, W4      ; W4 apunta a la dirección de la primera celda de B
    MOV #0x0818, W5      ; W5 apunta a la dirección de la cuarta celda de B
    MOV #0x0828, W6      ; W6 apunta a la dirección de la septima celda de B
    MOV #0x0840, W7      ; W7 apunta a la dirección de la primera celda de C
    MOV #0x0850, W8      ; W8 apunta a la dirección de la cuarta celda de C
    MOV #0x0860, W9      ; W9 apunta a la dirección de la septima celda de C

    BRA done

TranspuestaA:
    MOV [W1++], W11	    ;Movemos el valor de A[0][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][0]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][0]
    
    MOV [W1++], W11	    ;Movemos el valor de A[0][2] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][0]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][1]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][1]
    
    MOV [W2++], W11	    ;Movemos el valor de A[1][2] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][1]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][2]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][2]
    
    MOV [W3++], W11	    ;Movemos el valor de A[2][1] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][2]
    
    BRA done

TranspuestaB:
    MOV [W4++], W11	    ;Movemos el valor de B[0][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][0]
    
    MOV [W4++], W11	    ;Movemos el valor de B[0][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][0]
    
    MOV [W4++], W11	    ;Movemos el valor de B[0][2] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][0]
    
    MOV [W5++], W11	    ;Movemos el valor de B[1][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][1]
    
    MOV [W5++], W11	    ;Movemos el valor de B[1][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][1]
    
    MOV [W5++], W11	    ;Movemos el valor de B[1][2] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][1]
    
    MOV [W6++], W11	    ;Movemos el valor de B[2][0] a W11
    MOV W11, [W7++]	    ;Guardamos en C[0][2]
    
    MOV [W6++], W11	    ;Movemos el valor de B[2][1] a W11
    MOV W11, [W8++]	    ;Guardamos en C[1][2]
    
    MOV [W6++], W11	    ;Movemos el valor de B[2][1] a W11
    MOV W11, [W9++]	    ;Guardamos en C[2][2]
    
    BRA done

NumeroMayorA:
    ; Inicializamos W14 con el primer valor de la matriz A (A[0][0])
    MOV #0x0800, W1         ; W1 apunta a la dirección de la primera celda de A
    MOV [W1++], W14         ; Cargar A[0][0] en W14 (asumimos que es el mayor inicialmente)

    ; Comparar A[0][1] con el valor en W14
    MOV [W1++], W11         ; Cargar A[0][1] en W11
    CP W11, W14             ; Comparar A[0][1] con el mayor actual
    BRA LE, Check_A02       ; Si A[0][1] <= W14, continuar

    ; Si A[0][1] es mayor, actualizar W14
    MOV W11, W14            ; A[0][1] es mayor, lo guardamos en W14

Check_A02:
    ; Comparar A[0][2] con el valor en W14
    MOV [W1], W11           ; Cargar A[0][2] en W11
    CP W11, W14             ; Comparar A[0][2] con el mayor actual
    BRA LE, Check_A10       ; Si A[0][2] <= W14, continuar

    ; Si A[0][2] es mayor, actualizar W14
    MOV W11, W14            ; A[0][2] es mayor, lo guardamos en W14

Check_A10:
    ; Comparar A[1][0] con el valor en W14
    MOV #0x0810, W2         ; W2 apunta a la primera celda de la segunda fila (A[1][0])
    MOV [W2++], W11         ; Cargar A[1][0] en W11
    CP W11, W14             ; Comparar A[1][0] con el mayor actual
    BRA LE, Check_A11       ; Si A[1][0] <= W14, continuar

    ; Si A[1][0] es mayor, actualizar W14
    MOV W11, W14            ; A[1][0] es mayor, lo guardamos en W14

Check_A11:
    ; Comparar A[1][1] con el valor en W14
    MOV [W2++], W11         ; Cargar A[1][1] en W11
    CP W11, W14             ; Comparar A[1][1] con el mayor actual
    BRA LE, Check_A12       ; Si A[1][1] <= W14, continuar

    ; Si A[1][1] es mayor, actualizar W14
    MOV W11, W14            ; A[1][1] es mayor, lo guardamos en W14

Check_A12:
    ; Comparar A[1][2] con el valor en W14
    MOV [W2], W11           ; Cargar A[1][2] en W11
    CP W11, W14             ; Comparar A[1][2] con el mayor actual
    BRA LE, Check_A20       ; Si A[1][2] <= W14, continuar

    ; Si A[1][2] es mayor, actualizar W14
    MOV W11, W14            ; A[1][2] es mayor, lo guardamos en W14

Check_A20:
    ; Comparar A[2][0] con el valor en W14
    MOV #0x0820, W3         ; W3 apunta a la primera celda de la tercera fila (A[2][0])
    MOV [W3++], W11         ; Cargar A[2][0] en W11
    CP W11, W14             ; Comparar A[2][0] con el mayor actual
    BRA LE, Check_A21       ; Si A[2][0] <= W14, continuar

    ; Si A[2][0] es mayor, actualizar W14
    MOV W11, W14            ; A[2][0] es mayor, lo guardamos en W14

Check_A21:
    ; Comparar A[2][1] con el valor en W14
    MOV [W3++], W11         ; Cargar A[2][1] en W11
    CP W11, W14             ; Comparar A[2][1] con el mayor actual
    BRA LE, Check_A22       ; Si A[2][1] <= W14, continuar

    ; Si A[2][1] es mayor, actualizar W14
    MOV W11, W14            ; A[2][1] es mayor, lo guardamos en W14

Check_A22:
    ; Comparar A[2][2] con el valor en W14
    MOV [W3], W11           ; Cargar A[2][2] en W11
    CP W11, W14             ; Comparar A[2][2] con el mayor actual
    BRA LE, Save_Max        ; Si A[2][2] <= W14, continuar

    ; Si A[2][2] es mayor, actualizar W14
    MOV W11, W14            ; A[2][2] es mayor, lo guardamos en W14

Save_Max:
    ; Guardar el mayor valor encontrado en la dirección 0x0840
    MOV #0x0840, W7         ; Apuntamos a la dirección 0x0840
    MOV W14, [W7]           ; Guardar el valor mayor en 0x0840

    BRA done                ; Terminar la función


NumeroMenorB:
     ; Inicializamos W14 con el primer valor de la matriz B (B[0][0])
    MOV #0x0808, W4         ; W4 apunta a la dirección de la primera celda de B
    MOV [W4++], W14         ; Cargar B[0][0] en W14 (asumimos que es el menor inicialmente)

    ; Comparar B[0][1] con el valor en W14
    MOV [W4++], W11         ; Cargar B[0][1] en W11
    CP W11, W14             ; Comparar B[0][1] con el menor actual
    BRA GE, Check_B02       ; Si B[0][1] >= W14, continuar

    ; Si B[0][1] es menor, actualizar W14
    MOV W11, W14            ; B[0][1] es menor, lo guardamos en W14

Check_B02:
    ; Comparar B[0][2] con el valor en W14
    MOV [W4], W11           ; Cargar B[0][2] en W11
    CP W11, W14             ;c Comparar B[0][2] con el menor actual
    BRA GE, Check_B10       ; Si B[0][2] >= W14, continuar

    ; Si B[0][2] es menor, actualizar W14
    MOV W11, W14            ; B[0][2] es menor, lo guardamos en W14

Check_B10:
    ; Comparar B[1][0] con el valor en W14
    MOV #0x0818, W5         ; W5 apunta a la primera celda de la segunda fila (B[1][0])
    MOV [W5++], W11         ; Cargar B[1][0] en W11
    CP W11, W14             ; Comparar B[1][0] con el menor actual
    BRA GE, Check_B11       ; Si B[1][0] >= W14, continuar

    ; Si B[1][0] es menor, actualizar W14
    MOV W11, W14            ; B[1][0] es menor, lo guardamos en W14

Check_B11:
    ; Comparar B[1][1] con el valor en W14
    MOV [W5++], W11         ; Cargar B[1][1] en W11
    CP W11, W14             ; Comparar B[1][1] con el menor actual
    BRA GE, Check_B12       ; Si B[1][1] >= W14, continuar

    ; Si B[1][1] es menor, actualizar W14
    MOV W11, W14            ; B[1][1] es menor, lo guardamos en W14

Check_B12:
    ; Comparar B[1][2] con el valor en W14
    MOV [W5], W11           ; Cargar B[1][2] en W11
    CP W11, W14             ; Comparar B[1][2] con el menor actual
    BRA GE, Check_B20       ; Si B[1][2] >= W14, continuar

    ; Si B[1][2] es menor, actualizar W14
    MOV W11, W14            ; B[1][2] es menor, lo guardamos en W14

Check_B20:
    ; Comparar B[2][0] con el valor en W14
    MOV #0x0828, W6         ; W6 apunta a la primera celda de la tercera fila (B[2][0])
    MOV [W6++], W11         ; Cargar B[2][0] en W11
    CP W11, W14             ; Comparar B[2][0] con el menor actual
    BRA GE, Check_B21       ; Si B[2][0] >= W14, continuar

    ; Si B[2][0] es menor, actualizar W14
    MOV W11, W14            ; B[2][0] es menor, lo guardamos en W14

Check_B21:
    ; Comparar B[2][1] con el valor en W14
    MOV [W6++], W11         ; Cargar B[2][1] en W11
    CP W11, W14             ; Comparar B[2][1] con el menor actual
    BRA GE, Check_B22       ; Si B[2][1] >= W14, continuar

    ; Si B[2][1] es menor, actualizar W14
    MOV W11, W14            ; B[2][1] es menor, lo guardamos en W14

Check_B22:
    ; Comparar B[2][2] con el valor en W14
    MOV [W6], W11           ; Cargar B[2][2] en W11
    CP W11, W14             ; Comparar B[2][2] con el menor actual
    BRA GE, Save_Min        ; Si B[2][2] >= W14, continuar

    ; Si B[2][2] es menor, actualizar W14
    MOV W11, W14            ; B[2][2] es menor, lo guardamos en W14

Save_Min:
    ; Guardar el menor valor encontrado en la dirección 0x0840
    MOV #0x0840, W7         ; Apuntamos a la dirección 0x0840
    MOV W14, [W7]           ; Guardar el valor menor en 0x0840

    BRA done

AscenA:
    ; Movemos la matriz A a un vector 
    MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880
    
    MOV [W1++], W12	    ; Guardamos A[0][0] en W12
    MOV W12, [W11++]	    ; Guardamos A[0][0] en 0x0880
    MOV [W1++], W12	    ; Guardamos A[0][1] en W12
    MOV W12, [W11++]	    ; Guardamos A[0][1] en 0x0882
    MOV [W1++], W12	    ; Guardamos A[0][2] en W12
    MOV W12, [W11++]	    ; Guardamos A[0][2] en 0x0884
    
    MOV [W2++], W12	    ; Guardamos A[1][0] en W12
    MOV W12, [W11++]	    ; Guardamos A[1][0] en 0x0886
    MOV [W2++], W12	    ; Guardamos A[1][1] en W12
    MOV W12, [W11++]	    ; Guardamos A[1][1] en 0x0888
    MOV [W2++], W12	    ; Guardamos A[1][2] en W12
    MOV W12, [W11++]	    ; Guardamos A[1][2] en 0x088A
    
    MOV [W3++], W12	    ; Guardamos A[2][0] en W12
    MOV W12, [W11++]	    ; Guardamos A[2][0] en 0x088C
    MOV [W3++], W12	    ; Guardamos A[2][1] en W12
    MOV W12, [W11++]	    ; Guardamos A[2][1] en 0x088E
    MOV [W3++], W12	    ; Guardamos A[2][2] en W12
    MOV W12, [W11++]	    ; Guardamos A[2][2] en 0x0890
    
    ; Implementamos ordenamiento burbuja
    MOV #0x12 ,W15	    ; variable de control del loop2
    LOOP2:
    DEC W15, W15
    CP0 W15
    BRA Z, FIN		    ; salta al fin del algoritmo si se ha repetido las veces necesarias
    
    MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880 
    MOV #0x9, W14	    ; variable de control de loop1
    MOV [W11++], W12	    
    MOV [W11], W13
    LOOP1:
	DEC W14, W14
	CP0 W14
	BRA Z, LOOP2	    ;sale del loop1 si se ha repetido suficientes veces
	CPSLT W12, W13	    ; si ya es menor se salta el swap
	BRA SWAP1
    
	MOV [W11++], W12
	MOV [W11], W13
	BRA LOOP1	    ; vuelve al inicio del loop1
    
    SWAP1:
	MOV W12, [W11--]
	MOV W13, [W11++]
	MOV [W11++], W12
	MOV [W11], W13
	BRA LOOP1

    FIN: 
	MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880
	;guardamos los valores ordenados en la matriz C
	MOV [W11++], W12
	MOV W12, [W7++]
	MOV [W11++], W12
	MOV W12, [W7++]
	MOV [W11++], W12
	MOV W12, [W7++]

	MOV [W11++], W12
	MOV W12, [W8++]
	MOV [W11++], W12
	MOV W12, [W8++]
	MOV [W11++], W12
	MOV W12, [W8++]
	
	MOV [W11++], W12
	MOV W12, [W9++]
	MOV [W11++], W12
	MOV W12, [W9++]
	MOV [W11++], W12
	MOV W12, [W9++]
	
	BRA done

DescenB:
    ; Movemos la matriz B a un vector 
    MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880
    
    MOV [W4++], W12	    ; Guardamos B[0][0] en W12
    MOV W12, [W11++]	    ; Guardamos B[0][0] en 0x0880
    MOV [W4++], W12	    ; Guardamos B[0][1] en W12
    MOV W12, [W11++]	    ; Guardamos B[0][1] en 0x0882
    MOV [W4++], W12	    ; Guardamos B[0][2] en W12
    MOV W12, [W11++]	    ; Guardamos B[0][2] en 0x0884
  
    MOV [W5++], W12	    ; Guardamos B[1][0] en W12
    MOV W12, [W11++]	    ; Guardamos B[1][0] en 0x0886
    MOV [W5++], W12	    ; Guardamos B[1][1] en W12
    MOV W12, [W11++]	    ; Guardamos B[1][1] en 0x0888
    MOV [W5++], W12	    ; Guardamos B[1][2] en W12
    MOV W12, [W11++]	    ; Guardamos B[1][2] en 0x088A
    
    MOV [W6++], W12	    ; Guardamos B[2][0] en W12
    MOV W12, [W11++]	    ; Guardamos B[2][0] en 0x088C
    MOV [W6++], W12	    ; Guardamos B[2][1] en W12
    MOV W12, [W11++]	    ; Guardamos B[2][1] en 0x088E
    MOV [W6++], W12	    ; Guardamos B[2][2] en W12
    MOV W12, [W11++]	    ; Guardamos B[2][2] en 0x0890
   
    ; Implementamos ordenamiento burbuja
    MOV #0x12 ,W15	    ; variable de control del loop4
    LOOP4:
    DEC W15, W15
    CP0 W15
    BRA Z, FIN2		    ; salta al final si se ha repetido suficientes veces
    
    MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880 
    MOV #0x9, W14
    MOV [W11++], W12
    MOV [W11], W13
    LOOP3:
	DEC W14, W14
	CP0 W14
	BRA Z, LOOP4	    ;sale del loop3 si se ha repetido suficientes veces
	CPSGT W12, W13	    ; si ya es mayor se salta el swap
	BRA SWAP2
    
	MOV [W11++], W12
	MOV [W11], W13
	BRA LOOP3
    
    SWAP2:
	MOV W12, [W11--]
	MOV W13, [W11++]
	MOV [W11++], W12
	MOV [W11], W13
	BRA LOOP3
   
    FIN2: 
	MOV #0x0880, W11	    ; Apuntamos a la direccion 0x0880
	;guardamos los valores ordenados en la matriz C
	MOV [W11++], W12
	MOV W12, [W7++]
	MOV [W11++], W12
	MOV W12, [W7++]
	MOV [W11++], W12
	MOV W12, [W7++]

	MOV [W11++], W12
	MOV W12, [W8++]
	MOV [W11++], W12
	MOV W12, [W8++]
	MOV [W11++], W12
	MOV W12, [W8++]
	
	MOV [W11++], W12
	MOV W12, [W9++]
	MOV [W11++], W12
	MOV W12, [W9++]
	MOV [W11++], W12
	MOV W12, [W9++]
	
	BRA done
    
NOP

done:	    ;INFINITE LOOP    
    COM	    PORTB
    NOP
    BRA     done              ;Place holder for last line of executed code

;..............................................................................
;Subroutine: Initialization of W registers to 0x0000
;..............................................................................

_wreg_init:
    CLR W0
    MOV W0, W14
    REPEAT #12
    MOV W0, [++W14]
    CLR W14
    RETURN




;--------End of All Code Sections ---------------------------------------------

.end                               ;End of program code in this file