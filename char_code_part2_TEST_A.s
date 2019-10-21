/******************************************************************************
* file: char_code.s
* author: Venkatesh Ravipati
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
.bss

@ DATA SECTION
.data
STRING: .byte 0x43,0x53,0x36,0x36,0x32,0x30,0x0 ; //CS6620
SUBSTR: .byte 0x53,0x53,0x0; 					  //SS
RES: .byte 0x0, 0x0;		//for allignment
                            
Output:                     
PRESENT: .word     0x0;		//Output variable to store PRESENT value

@ TEXT section
.text

.globl _main

_main:
	LDR r1, =STRING;    //load START1 address to r1
	LDR r2, =SUBSTR;    //load START2 address to r2
	MOV r4, #0;         //initialize r4 to 0 for position counter
	MOV r5, #0;         //initialize r5 to 0
	MOV r6, #0;         //initialize r5 to 0
	MOV r3, #0;         //initialize r5 to 0
LOOP:
	ADD r10, r1, r5;	//r10 = r1 + r5
	ADD r10, r10,r3; 	//r10 = r10+ r3 //address counter for string	
	LDRB r7, [r10];  	//load byte from r10 location to r7
	CMP r7, #0;			//compare if r7 is null
	BEQ RET1;			//if null, we reach string end. brach to return1 
	LDRB r8, [r2,r6];  	//load byte from r2+r6 location to r8
	CMP r8, #0;			//compare if r8 is null
	BEQ RET;            //if null, we reach substring end. brach to return 
	CMP r7, r8;			//compare the present char's
	BNE MISS;			//if not equal branch to miss
	ADD r4, r5,#1;		//if equal, update current char positoin if sting to r4, adding 1 as indexing starts from 1
	ADD r3,r3,#1;		//increment address counter to read next byte
	ADD r6,r6,#1;		//increment address counter to read next byte
	B LOOP;				//repeat for next char
MISS:					//if miss
	ADD r5, r5, #1;		//update string position counter
	MOV r6, #0;			//clear temp increment registers r6
	MOV r4, #0;			//clear temp increment registers r4
	MOV r3, #0;			//clear temp increment registers r3
	B LOOP;				//repeat for next char
RET1:					//if return from string, we need to check if substring is also terminated
	LDRB r8, [r2,r6];  	//load byte from r2+r6 location to r8
	CMP r8, #0;			//compare if r8 is null
	BEQ RET;			//if null substring also terminated, go to return
	MOV r4, #0;			//else clear position counter and then return.
RET:					//return
	LDR r9, =PRESENT;	//load PRESENT address to r9
	STR r4, [r9];		//store r4 value in PRESENT
END: NOP	            //END
.end
