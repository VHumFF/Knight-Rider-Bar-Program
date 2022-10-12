	ORG 0000H; start program at address 0000H
	CALL SEG ;call SEG subroutine
	MOV R3, #10 ;move 10 into Register 3
	
;-----Knight Rider Bar LED-----;
Knightbar:
	MOV P1,#0FFH;move FFH into port 1
	CALL delay; call delay subroutine
	CALL rotLRRL; call rotLRRL subroutine, rotate led from right to left and back
	MOV R1, #3; move 3 into register 1
	CALL blink; call blink subroutine, turn on all LED and OFF 3 times
	MOV R1, #2
	CALL blink2; call blink2 subroutine, blink LED unique sequence
	CALL rot2bLRRL; rotate 2 led from right to left and back
	MOV R1, #2
	CALL blink
	MOV R2, #2
	CALL blink3; blink LED in unique sequnce
	DJNZ R3, Knightbar; decrement register 3 and jump to knightbar if r3 not 0
	JMP $; jump to same line, do noting


rotLRRL:
	MOV A,#0FEH;store FEH into accumulator
	MOV R1, #7
	rotcw:
		MOV P1,A ;move accumulator to port 1
		RL A ;rotate left for accumulator 7 times
		CALL delay
		DJNZ R1, rotcw;decrement r1, jump to rotcw if r1 not 0
	MOV R1, #8
	rotacw:
		MOV P1,A
		RR A ;rotate right for accumulator 8 times
		CALL delay
		DJNZ R1, rotacw
	RET; returning from subroutine

rot2bLRRL:
	MOV A,#0FEH; store FEH into accumulator
	MOV R1, #8
	rot2bcw:
		MOV P1,A ;move accumulator to port 1
		RLC A ;rotate 2bit data right for accumulator
		CALL delay
		DJNZ R1, rot2bcw
	MOV R1, #9
	rot2bacw:
		MOV P1,A ;move accumulator to port 1
		RRC A ;rotate 2bit data right for accumulator
		CALL delay
		DJNZ R1, rot2bacw
	RET


blink:
	MOV P1, #0FFH; turn off all LED
	CALL delay
	MOV P1, #00H; turn on all LED
	CALL delay
	DJNZ R1, blink; repeat blink until R1 = 0
	CALL delay
	RET

blink2:
	MOV P1, #7EH; move data to port 1,turn on led 7 and led 0
	CALL delay
	MOV P1, #0BDH; turn on led 6 and led 1
	CALL delay
	MOV P1, #0DBH; turn on led 5 and led 2
	CALL delay
	MOV P1, #0E7H; turn on led 4 and led 3
	CALL delay
	MOV P1, #0DBH; turn on led 5 and led 2
	CALL delay
	MOV P1, #0BDH; turn on led 6 and led 1
	CALL delay
	MOV P1, #7EH; turn on led 7 and led 1
	CALL delay
	MOV P1, #0FFH; turn off all LED
	CALL delay
	DJNZ R1, blink2; repeat routine ultil R1 = 0
	CALL delay
	RET

blink3:
	MOV P1, #0F0H; turn on led 0,1,2,3
	CALL delay2
	MOV P1, #0FH; turn on led 4,5,6,7
	CALL delay2
	MOV P1, #18H; turn on led 0,1,2,5,6,7
	CALL delay2
	MOV P1, #0E7H; turn on led 3 and 4
	CALL delay2
	DJNZ R2, blink3; decrement R2, jump to blink3 if R2 not 0
	MOV R1, #1; move 1 into register 1
	CALL blink2; call blink2 subroutine
	RET; returning from subroutine
	


SEG:
	SETB P3.3; set p3.3 to 1
	SETB P3.4; set p3.4 to 1, enable display 3
	MOV P1, #0B0H; display 3 on 7 segment display
	CALL delay3
	CLR P3.3; set p3.3 to 0, enable display 2
	MOV P1, #0A4H; display 2 on 7 segment screen
	CALL delay3
	CLR P3.4; set p3.4 to 0
	SETB P3.3; set p3.3 to 1, enable display 1
	MOV P1, #0F9H; display 1 on 7 segment
	CALL delay3
	CLR P3.3; set p3.3 to 0, enable display 0
	MOV P1, #0C0H; display 0 on 7 segment
	CALL delay3
	MOV R1, #3
	CALL Blink; call blink subroutine
	RET; returning from subroutine

delay:
	MOV R0, #50; move 50 into register 0
	DJNZ R0, $; repeat same line ultil R0 = 0
	RET
	
delay2:
	MOV R4, #100
	DJNZ R4, $
	RET

delay3:
	MOV R5, #150
	DJNZ R5, $
	RET

END
