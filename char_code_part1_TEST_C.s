/******************************************************************************
* file: char_code.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
LENGTH: .word 3;
START1: .byte 0x43,0x41,0x54; 	//CAT
START2: .byte 0x43,0x55,0x54; 	//CUT
RES: .byte 0x0, 0x0;			//for allignment

Output: 
GREATER: .word     0x0;			//Output variable to store GREATER value

@ TEXT section
.text

.globl _main

_main:
	LDR r1, =LENGTH; 	//loading Lenght address to r1
	LDR r2, [r1];		//loading length value to r2
	LDR r1, =START1;	//load START1 address to r1
	LDR r3, =START2;	//load START2 address to r2
	MOV r4, #0;			//initialize r4 to 0 for counter
	MOV r6, #0;			//initialize r6 to 0 for string1 weight accumulator
	MOV r7, #0;			//initialize r7 to 0 for string2 weight accumulator
	
LOOP: 
	LDRB r5, [r1] ,#1; 	//load byte from r1 location and update r1 = r1+1
	ADD r6, r6, r5;		//added read byte to accumulator
	LDRB r5, [r3], #1;	//load byte from r3 location and update r3 = r3+1
	ADD r7, r7, r5;     //added read byte to accumulator
	ADD r4, r4, #1;		//increment the length counter
	CMP r4, r2;			//compare to check if reach full length
	BNE LOOP;			//if not reached LOOP to read the next byte, once we reach length continue 
	CMP r6, r7;			//compare string 1 and 2 weights
	BPL END;			//if string 1 is greater or equal jump to end. else update the greater variable
	LDR r1, =GREATER;	//load greater address to r1.
	MOV r2, #0xFFFFFFFF;//MOV r2 with 0xffffffff, the value tobe updated
	STR r2, [r1];		//store r2 in the r1 location
END: NOP				//END
.end

