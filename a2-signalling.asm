; a2-signalling.asm
; CSC 230: Spring 2025
;
; Student name: Jasvin Kaur
; Student ID: V01041632
; Date of completed work: (2025-Feb-17)
;
; *******************************
; Code provided for Assignment #2
;
; Author: Mike Zastre (2022-Oct-15)
; Modified: Sudhakar Ganti (2025-Jan-31)
 
; This skeleton of an assembly-language program is provided to help you
; begin with the programming tasks for A#2. As with A#1, there are "DO
; NOT TOUCH" sections. You are *not* to modify the lines within these
; sections. The only exceptions are for specific changes changes
; announced on Brightspace or in written permission from the course
; instructor. *** Unapproved changes could result in incorrect code
; execution during assignment evaluation, along with an assignment grade
; of zero. ****

.include "m2560def.inc"
.cseg
.org 0

; ***************************************************
; **** BEGINNING OF FIRST "STUDENT CODE" SECTION ****
; ***************************************************

	; initializion code will need to appear in this
    	; section

	; Initialize stack pointer
	ldi R16, high(RAMEND)
	out SPH, R16
	ldi R16, low(RAMEND)
	out SPL, R16
	

	; Set data direction registers for ports B and L
	ldi R16, 0xFF
	sts DDRL, R16
	out DDRB, R16

	; Clear output ports
	clr R16
	sts PORTL, R16
	out PORTB, R16
	


; ***************************************************
; **** END OF FIRST "STUDENT CODE" SECTION **********
; ***************************************************

; ---------------------------------------------------
; ---- TESTING SECTIONS OF THE CODE -----------------
; ---- TO BE USED AS FUNCTIONS ARE COMPLETED. -------
; ---------------------------------------------------
; ---- YOU CAN SELECT WHICH TEST IS INVOKED ---------
; ---- BY MODIFY THE rjmp INSTRUCTION BELOW. --------
; -----------------------------------------------------

	rjmp test_part_a
	;Test code


test_part_a:
	ldi r16, 0b00100001
	rcall configure_leds
	rcall delay_long

	clr r16
	rcall configure_leds
	rcall delay_long

	ldi r16, 0b00111000
	rcall configure_leds
	rcall delay_short

	clr r16
	rcall configure_leds
	rcall delay_long

	ldi r16, 0b00100001
	rcall configure_leds
	rcall delay_long

	clr r16
	rcall configure_leds

	rjmp end


test_part_b:
	ldi r17, 0b00101010
	rcall slow_leds
	ldi r17, 0b00010101
	rcall slow_leds
	ldi r17, 0b00101010
	rcall slow_leds
	ldi r17, 0b00010101
	rcall slow_leds

	rcall delay_long
	rcall delay_long

	ldi r17, 0b00101010
	rcall fast_leds
	ldi r17, 0b00010101
	rcall fast_leds
	ldi r17, 0b00101010
	rcall fast_leds
	ldi r17, 0b00010101
	rcall fast_leds
	ldi r17, 0b00101010
	rcall fast_leds
	ldi r17, 0b00010101
	rcall fast_leds
	ldi r17, 0b00101010
	rcall fast_leds
	ldi r17, 0b00010101
	rcall fast_leds

	rjmp end

test_part_c:
	ldi r16, 0b11111000
	push r16
	rcall leds_with_speed
	pop r16

	ldi r16, 0b11011100
	push r16
	rcall leds_with_speed
	pop r16

	ldi r20, 0b00100000
test_part_c_loop:
	push r20
	rcall leds_with_speed
	pop r20
	lsr r20
	brne test_part_c_loop

	rjmp end


test_part_d:
	ldi r21, 'A'
	push r21
	rcall encode_letter
	pop r21
	push r25
	rcall leds_with_speed
	pop r25

	rcall delay_long

	ldi r21, 'B'
	push r21
	rcall encode_letter
	pop r21
	push r25
	rcall leds_with_speed
	pop r25

	rcall delay_long


	ldi r21, 'C'
	push r21
	rcall encode_letter
	pop r21
	push r25
	rcall leds_with_speed
	pop r25

	rcall delay_long

	rjmp end


test_part_e:
	ldi r25, HIGH(WORD05 << 1)
	ldi r24, LOW(WORD05 << 1)
	rcall display_message_signal
	rjmp end

end:
    rjmp end






; ****************************************************
; **** BEGINNING OF SECOND "STUDENT CODE" SECTION ****
; ****************************************************

configure_leds:  ; Part A - Configures LEDs based on bit pattern (bits 5-0 control LEDs) in R16
	andi R16, 0b00111111  ; Mask out bits 6 and 7 (unused)
	push R17
	push R18
	push R19

	clr R17    ; Clear register for PORTL output
	clr R18    ; Clear register for PORTB output

	; Check and map individual bits to appropriate output ports
	ldi R19, 0b00100000
	andi R19, 0b00100000

	breq skip_bit5
	ori R18, 0b00000010    ; Set corresponding bit in PORTB

bit5_skip:
	ldi R19, 0b00010000
	and R19, R16
	breq bit4_skip
	ori R18, 0b00001000

bit4_skip:
	ldi R19, 0b00001000
	and R19, R16
	breq bit3_skip
	ori R17, 0b00000010

bit3_skip:
	ldi R19, 0b00000010
	and R19, R16
	breq bit2_skip
	ori R17, 0b00001000

bit2_skip:
	ldi R19, 0b00000010
	and R19, R16
	breq bit1_skip
	ori R17, 0b00100000

bit1_skip:
	ldi R19, 0b00000001
	and R19, R16
	breq bit3_skip
	ori R17, 0b10000000

bit0_skip:

	; Write values to ports
	sts PORTL, R17
	out PORTB, R18
	
	pop R19
	pop R18
	pop R17
	ret




slow_leds:       ; Part B - Displays LED pattern slowly
	mov R16, R17
	rcall configure_leds  ; Set LEDs
	rcall delay_long      ; Wait for long duration
	clr R16               ; Turn off all LEDs
	rcall configure_leds
	ret


fast_leds:       ; Part B - Display LED pattern quickly
	mov R16, R17
	rcall configure_leds  ; Set LEDs
	rcall delay_short     ; Wait for short duration
	clr r16               ; Turn off all LEDs
	rcall configure_leds
	ret


leds_with_speed:       ; Part C - Determines LED speed based on input
	; The parameter is on the stack
    	in YH, SPH
	in YL, SPL
	ldd R17, Y+4          ; Load LED pattern
	mov R22, R17
	andi R22, 0b11000000  ; Extract speed bits
	cpi R22, 0b11000000
	brne check
	call slow_leds
	ret

check:
	cpi R22, 0x00
	brne speed_end
	
	call fast_leds

speed_end:
	ret

; Note -- this function will only ever be tested
; with upper-case letters, but it is a good idea
; to anticipate some errors when programming (i.e. by
; accidentally putting in lower-case letters). Therefore
; the loop does explicitly check if the hyphen/dash occurs,
; in which case it terminates with a code not found
; for any legal letter.

encode_letter:       ; Part D - Encodes a letter into LED pattern
	ldi ZH, high(PATTERNS<<1) ; Load adress to PATTERNS table
	ldi ZL, low(PATTERNS<<1)
	in XL, SPL
	in XH, SPH
	ldi R18, 0xFF	
	sub R18, XL
	add XL, R18
	clr R18
	ld R16, X

	; Perform pattern lookup
	loop_search:
	lpm R17, Z+
	cp R16, R17
	breq found
		ldi R21, 7
	loop:
		lpm R17, Z+
		dec R21
		brne loop

	clr R21
	rjmp loop_search

	found:
	clr R18
	clr R19
	clr R20
	clr R22
	clr R23
	clr R24

	set_pattern:
		lpm R18, Z+
		lpm R19, Z+
		lpm R20, Z+
		lpm R22, Z+
		lpm R23, Z+
		lpm R24, Z+

	set_speed:
		lpm R16, Z+
		cpi R16, 0x01
		breq set_slow
		brne set_fast

		set_slow:
		ldi R25, 0b11000000
		jmp set_encoding
		set_fast:
		ldi R25, 0b00000000

	set_encode_letter:
		ldi R27, 0b00100000
		mov R26, R18
		cpi R26, 0x2E
		breq off_led1
		rjmp on_led1

	off_led1:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp led2

	on_led1:
		add R25, R27
		lsr R27

	led2:
		mov R26, R19
		cpi R26, 0x2E
		breq off_led2
		rjmp on_led2

	off_led2:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp led3

	on_led2:
		add R25, R27
		lsr R27

	led3:
		mov R26, r20
		cpi R26, 0x2E
		breq off_led3
		rjmp on_led3

	off_led3:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp led4

	on_led3:
		add R25, R27
		lsr R27

	led4:
		mov R26, R22
		cpi R26, 0x2E
		breq off_led4
		rjmp on_led4

	off_led4:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp led5

	on_led4:
		add R25, R27
		lsr R27

	led5:
		mov R26, R23
		cpi R26, 0x2E
		breq off_led5
		rjmp on_led5

	on_led5:
		add R25, R27
		lsr R27

	off_led5:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp led6

	led6:
		mov R26, R24
		cpi R26, 0x2E
		breq offled6
		rjmp on_led6

	off_led6:
		ldi R26, 0b00000000
		add R25, R26
		lsr R27
		jmp end_encode_letter

	on_led6:
		add R25, R27
		lsr R27

	end_encode_letter:
	ret


display_message_signal:       ; Part E - Displays a message using LED encoding
	mov ZH, R25
    	mov ZL, R24

loop_display:
    	lpm R16, Z+        ; Load character from message
    	cpi R16, 0         ; Check for null terminator
    	breq end_display
    	push R16
    	rcall encode_letter
    	push R25
    	rcall leds_with_speed
    	rjmp loop_display

end_display:
    	ret



; ****************************************************
; **** END OF SECOND "STUDENT CODE" SECTION **********
; ****************************************************




; =============================================
; ==== BEGINNING OF "DO NOT TOUCH" SECTION ====
; =============================================

; about one second
delay_long:
	push r16

	ldi r16, 14
delay_long_loop:
	rcall delay
	dec r16
	brne delay_long_loop

	pop r16
	ret


; about 0.25 of a second
delay_short:
	push r16

	ldi r16, 4
delay_short_loop:
	rcall delay
	dec r16
	brne delay_short_loop

	pop r16
	ret

; When wanting about a 1/5th of a second delay, all other
; code must call this function
;
delay:
	rcall delay_busywait
	ret


; This function is ONLY called from "delay", and
; never directly from other code. Really this is
; nothing other than a specially-tuned triply-nested
; loop. It provides the delay it does by virtue of
; running on a mega2560 processor.
;
delay_busywait:
	push r16
	push r17
	push r18

	ldi r16, 0x08
delay_busywait_loop1:
	dec r16
	breq delay_busywait_exit

	ldi r17, 0xff
delay_busywait_loop2:
	dec r17
	breq delay_busywait_loop1

	ldi r18, 0xff
delay_busywait_loop3:
	dec r18
	breq delay_busywait_loop2
	rjmp delay_busywait_loop3

delay_busywait_exit:
	pop r18
	pop r17
	pop r16
	ret


; Some tables
;.cseg
;.org 0x800

PATTERNS:
	; LED pattern shown from left to right: "." means off, "o" means
    ; on, 1 means long/slow, while 2 means short/fast.
	.db "A", "..oo..", 1
	.db "B", ".o..o.", 2
	.db "C", "o.o...", 1
	.db "D", ".....o", 1
	.db "E", "oooooo", 1
	.db "F", ".oooo.", 2
	.db "G", "oo..oo", 2
	.db "H", "..oo..", 2
	.db "I", ".o..o.", 1
	.db "J", ".....o", 2
	.db "K", "....oo", 2
	.db "L", "o.o.o.", 1
	.db "M", "oooooo", 2
	.db "N", "oo....", 1
	.db "O", ".oooo.", 1
	.db "P", "o.oo.o", 1
	.db "Q", "o.oo.o", 2
	.db "R", "oo..oo", 1
	.db "S", "....oo", 1
	.db "T", "..oo..", 2
	.db "U", "o.....", 1
	.db "V", "o.o.o.", 2
	.db "W", "o.o...", 2
	.db "W", "oo....", 2
	.db "Y", "..oo..", 2
	.db "Z", "o.....", 2
	.db "-", "o...oo", 1   ; Just in case!

WORD00: .db "CSC230", 0, 0
WORD01: .db "ALL", 0
WORD02: .db "ROADS", 0, 0, 0
WORD03: .db "LEAD", 0, 0, 0, 0
WORD04: .db "TO", 0, 0
WORD05: .db "UVIC", 0, 0, 0, 0

; =======================================
; ==== END OF "DO NOT TOUCH" SECTION ====
; =======================================

