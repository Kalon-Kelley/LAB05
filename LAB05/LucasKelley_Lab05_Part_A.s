;*******************************************************************************
;
;    CS 107: Computer Architecture and Organization -- LAB 5
;    Filename: Lab05.s
;    Date: [4/5/2022]
;    Author: [Lucas Kelley]
;
;*******************************************************************************
;
	GLOBAL __main
	AREA main, CODE, READONLY
	EXPORT __main
	EXPORT __use_two_region_memory
__use_two_region_memory EQU 0
	EXPORT SystemInit
	EXPORT Virtual_GPIO1_PIN
	ENTRY

	GET		BOARD.S

; You may want to define some constant(s) for delay and/or bitmask.
; if so, do it below this lines or uncomment following lines and
; type proper constant(s) instead of '??????'
;
main_delay	EQU	3200
;
; #11. Make the mask for your virtual pin(s)  
;
RGB_PINS	EQU (RGBLED_R_BIT:OR:RGBLED_B_BIT)

; System Init routine
SystemInit
;================ DO NOT CHANGE ANYTHING BELOW THIS LINE =======================
	LDR		r1, =0x34525363
	LDR		r0, =Virtual_GPIO1_PIN
	STR		r1, [r0]
	MOV		r1, #0
	MOV		r0, #0
;================ DO NOT CHANGE ANYTHING ABOVE THIS LINE =======================
;
; #10. Reset virtual GPIO R, G andB Pins, do not change any another virtual pins!
;
; --- Write your code to turn all 3 virtual LEDs off here...

   LDR 		R0, =Virtual_GPIO1_PIN
   LDR 		R1, [R0]
   BIC 		R1, #(RGBLED_R_BIT:OR:RGBLED_G_BIT:OR:RGBLED_B_BIT)
   STR 		R1, [R0]

;
	BX		LR
;
	ALIGN

__main
;
; #12. You may write some additional initialization code here...

loop
	LDR		R3, =main_delay
delay_loop
	SUBS	R3, #1
	BNE 	delay_loop

;
; #14. Invert pin(s)
;
; --- Write your code to invert virtual pin(s) here...

    LDR     R0, =Virtual_GPIO1_PIN
    LDR     R1, =RGB_PINS
    LDR     R2, [R0]
    EOR     R2, R1
    STR     R2, [R0]
	
	B		loop	; Loop forever!


;================ DO NOT CHANGE ANYTHING BELOW THIS LINE =======================
	ALIGN

	AREA vars, DATA, ALIGN=2

Virtual_GPIO1_PIN
	SPACE	4
;================ DO NOT CHANGE ANYTHING ABOVE THIS LINE =======================
	
	END