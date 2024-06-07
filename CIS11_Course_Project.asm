.ORIG x3000 

 

LEA	 R0, WEL 

PUTS  

WEL	.STRINGZ "Welcome! Please enter 5 scores: (0 - 99)" 

 

LD R0, NEWLINE 

OUT			 

 

;CALLS JUMPS TO GET_GRADE FUNCTION TO GET THE NUMERIC GRADE, THEN STORES GRADE 

;INTO GRADES ARRAY. WE THEN JUMP TO GET THE GET LETTER FUNCTION. AFTER WE JUMP TO THE POP FUNCTION. 

 

JSR GET_GRADE 

LEA R6, GRADES 

STR R3, R6, #0 

JSR GET_LETTER 

JSR POP 

 

 

LD R0, NEWLINE 

OUT 

 

;IT DOES THE SAME AS THE TOP FUNCTION, EXCEPT THIS TIME IT USES G2 INSTEAD OF G1.  

;THE GRADE INTO THE GRADES ARRAY. 

 

JSR GET_GRADE 

LEA R6, GRADES 

STR R3, R6, #1 

JSR GET_LETTER 

JSR POP 

 

 

LD R0, NEWLINE 

OUT 

 

;NOW USING G3 

 

JSR GET_GRADE 

LEA R6, GRADES 

STR R3, R6, #2 

JSR GET_LETTER 

JSR POP 

 

LD R0, NEWLINE 

OUT 

 

;NOW USING G4  

 

JSR GET_GRADE 

LEA R6, GRADES 

STR R3, R6, #3 

JSR GET_LETTER 

JSR POP 

 

 

LD R0, NEWLINE 

OUT 

 

;NOW USING G5 

 

JSR GET_GRADE 

LEA R6, GRADES 

STR R3, R6, #4 

JSR GET_LETTER 

JSR POP 

 

 

LD R0, NEWLINE 

OUT 

 

; FALL THRU FUNCTION IN MAIN 

; R1 = NUM_TESTS (5) 

; R2 = GRADES ARRAY 

; R3 = MIN_GRADE 

; R4 = GRADES(x) 

; R5 = -G(x) / PLATFORM FOR COMPARISON  

 

 

 

CALCULATE_MAX 

LD R1, NUM_TESTS 	;R1 holds the total number of test  

 	LEA R2, GRADES 		;R2 holds the starting address of grades  

LD R4, GRADES		; G(0) 

ST R4, MAX_GRADE 

ADD R2, R2, #1 

 

LOOP1 	LDR R5, R2, #0		; ACCESS POINTER VALUE IN GRADES 

NOT R4, R4 

ADD R4, R4, #1 

ADD R5, R5, R4 

BRp NEXT1 

LEA R0, MAX 

PUTS 

LD R3, MAX_GRADE 

AND R1, R1, #0 

JSR BREAK_INT 

LD R0, SPACE 

OUT 

 

LD R0, NEWLINE 

OUT	 

JSR CLEAR_REG 

 

 

 

 

; CALCULATE MIN 

; R1 = NUM_TESTS (5) 

; R2 = GRADES ARRAY 

; R3 = MIN_GRADE 

; R4 = GRADES(x) 

; R5 = -G(x) / PLATFORM FOR COMPARISON  

 

CALCULATE_MIN 

LD R1, NUM_TESTS 	;R1 holds the total number of test  

 	LEA R2, GRADES 		;R2 holds the starting address of grades  

LD R4, GRADES		; G(0) 

ST R4, MIN_GRADE 

ADD R2, R2, #1 

ADD R1, R1, #-1 

 

LOOP2 	LDR R5, R2, #0		; ACCESS POINTER VALUE IN GRADES 

 

NOT R4, R4 

ADD R4, R4, #1		 

ADD R5, R5, R4 

BRn NEXT2 

 

 

ADD R2, R2, #1 

LD R4, GRADES 

AND R5, R5,#0 

ADD R1,R1,#-1 

BRp LOOP2 

 

LEA R0, MIN 

PUTS 

LD R3, MIN_GRADE 

AND R1, R1, #0 

JSR BREAK_INT 

LD R0, SPACE 

OUT 

 

JSR CLEAR_REG 

LD R0, NEWLINE 

OUT 

 

 

; CALCULATE AVG 

; R1 = NUM_TESTS (5)  

; R2 = GRADES ARRAY 

; R3 = SUM 

; R4 - GRADES[i] / SUM / PLATFORM FOR SUBTRACTION 

; R5 = DEC ->  

; R6 = COUNTER / DIV (QUOTIENT) 

 

 

CALC_AVG 

LD R1, NUM_TESTS 	;R1 holds the total number of test  

 	LEA R2, GRADES 		;R2 holds the starting address of grades  

 

GEN_SUM LDR R4, R2, #0 

ADD R3, R3, R4		;Sum will be stored in R3 

ADD R2, R2, #1 

ADD R1, R1, #-1 

BRp GEN_SUM 

 

LD R1, NUM_TESTS 

 	NOT R1, R1 

ADD R1, R1, #1 		;R1 has value of -5 

 	ADD R4, R3, #0 

 

LOOP3 	ADD R4, R4, #0 

BRnz DONE_AVG 

 	ADD R6, R6, #1		;Increment every time 

ADD R4, R4, R1		;Subtract 5 from total 

 	BRp LOOP3 

 

DONE_AVE  

ST R6, AVERAGE_SCORE 

LEA R0, AVG 

PUTS 

AND R3, R3, #0 

AND R1, R1, #0 

AND R4, R4, #0 

ADD R3, R3, R6 

JSR BREAK_INT 

 

 

JSR RESTART_PROG 

 

HALT 

 

 

NEWLINE			.FILL xA 

SPACE			.FILL X20 

DECODE_DEC 		.FILL #-48 

DECODE_SYM		.FILL #48 

DECODE_THIRTY		.FILL #-30 

NUM_TESTS		.FILL 5 

RESTART2		.FILL x3000 

 

MAX_GRADE		.BLKW 1 

MIN_GRADE		.BLKW 1 

DONE_AVG		.BLKW 1 

AVERAGE_SCORE		.BLKW 1 

 

 

 

 

; BRANCHES AND VARIABLES 

; FOR CALCULATE MIN AND MAX 

 

 

NEXT2  

LDR R4, R2, #0 

ST R4, MIN_GRADE 

ADD R2, R2, #1		; GRADES ARRAY MOVE UP 

ADD R1, R1, #-1		; COUNTER MOVE DOWN 

BRnzp LOOP2 

 

NEXT1  

LDR R4, R2, #0 

ST R4, MAX_GRADE 

ADD R2, R2, #1		; GRADES ARRAY MOVE UP 

ADD R1, R1, #-1		; COUNTER MOVE DOWN 

BRp LOOP1 

 

 

GRADES 	.BLKW 5 

 

MIN	.STRINGZ "MIN " 

MAX	.STRINGZ "MAX " 

AVG	.STRINGZ "AVG " 

 

 

 

; SUBROUTINE 

; RESTART_PROG 

; RESTARTS THE PROGRAM ON 'y' 

; R7 = JSR LOCATION 

; R0 = INPUT/ OUTPUT 

; R1 = VALUE OF LOWERCASE Y(- 121) 

; R2 = ORIGIN x3000 

; R3 = VALUE OF UPPERCASE Y (-89) 

 

 

RESTART_PROG 

ST R7, SAVELOC1			; SAVE JSR LOCATION 

LD R1, LOWER_Y			; LOAD NEG VALUE OF Y 

LD R3, UPPER_Y 

LD R2, ORIGIN			; LOAD ORIGIN ( x3000) 

 

LD R0, NEWLINE 

OUT 

LEA R0 RESTARTPROG_STR		; RESTART PROMPT STRING 

PUTS 

LD R0, NEWLINE 

OUT 

 

GETC	 

ADD R1, R1, R0			; COMPARE USER INPUT WITH -y 

BRz RESTART_TRUE 		; IF TRUE BRANCH TO RESTART 

ADD R3, R3, R0			; COMPARE USER INPUT WITH -Y 

BRz RESTART_TRUE 		; IF TRUE BRANCH TO RESTART 

 

HALT					; ELSE HALT PROGRAM 

 

; BRANCHES OR 

; RESTART_PROG 

 

RESTART_TRUE	 

JMP R2 

 

 

 

; VARIABLES FOR RESTART_PROG 

 

RESTARTPROG_STR 	.STRINGZ "Program Completed. Would you like to run this program again? Y/N " 

LOWER_Y			.FILL xFF87	; -121 

UPPER_Y			.FILL xFFA7	; -89 

ORIGIN			.FILL x3000 

 

SAVELOC1 .FILL X0 

SAVELOC2 .FILL X0 

SAVELOC3 .FILL X0 

SAVELOC4 .FILL X0 

SAVELOC5 .FILL X0 

 

 

; SUBROUTINE 

; GET_GRADE 

; READ IN TWO NUMBERS AND PUT 

; TOGETHER AS ONE DOUBLE DIGIT 

; BY MULTIPLYING FIRST NUMBER BY  

; 10 THEN ADDING TO SECOND 

; R1 = INPUT FROM R0 

; R2 = COUNTER FOR MULT10 

; R3 = PLATFORM FOR MULT10 / ANSWER 

; R4 = ASCII -> DECIMAL TRANSLATION 

 

 

 

;GET_GRADE FUNCTION 

;THIS FUNCTION I USED TO STORE JSR LOCATION 

;IT ALSO USES A JSR TO CLEAR THE REGISTER 

;IT ALSO USES ANOTHER FUNCTION TO DECODE  

;THE GRADE INDO A DECIMAL. 

 

GET_GRADE	ST R7, SAVELOC1		; STORE JSR LOCATION 

JSR CLEAR_REG		; CLEAR REGISTERS 

LD R4, DECODE_DEC	; LOAD TRANSLATION 

 

 

GETC			; GET FIRST CHAR 

JSR VALIDA 

OUT			; ECHO INPUT 

 

ADD R1, R0, #0		; COPY INPUT TO R1 

ADD R1, R1, R4		; TRANSLATE TO DECIMAL	 

ADD R2, R2, #10		; CLEAR R2 

 

 

MULT10	ADD R3, R3, R1			; ADD INPUT TO R3 (MULT PROCESS) 

ADD R2, R2, #-1		; DECREMENT COUNTER 

BRp MULT10		; LOOP UNTIL COUNTER IS ZERO 

 

GETC			; GET SECOND CHAR 

JSR VALIDA 

OUT			; ECHO INPUT TO SCREEN 

 

ADD R0, R0, R4		; TRANSLATE SECOND INPUT TO DECIMAL 

ADD R3, R3, R0		; ADD FIRST INPUT(X10) TO SECOND INPUT 

 

 

LD R0, SPACE		; ADD  SPACE 

OUT			; PRINT SPACE 

 

LD R7, SAVELOC1		; LOAD JSR RETURN LOCATION 

RET					; RETURN 

 

 

 

; SUBROUTINE 

; BREAK _ INT  

; BREAKS UP A DOUBLE DIGIT INTO TWO SEPERATE DIGITS FOR  

; PRINTING USING THE QUOTIENT AND MOD %10 

; R1 = COUNTER FOR DIVIDE (QUOTIENT) 

; R3 = INPUT 

; R4 = PLATFORM / REMAINDER 

; R5 = DECIMAL --> SYMBOL TRANSLATION 

; R6 = CHECK FOR 10 

 

 

BREAK_INT  

ST R7, SAVELOC1		; STORE JSR RETURN LOCATION 

LD R5, DECODE_SYM	; TRANSLATION TO CONVERT DECIMAL TO SYMBOL 

ADD R4, R3, #0		; COPY INPUT TO R4 (PLATFORM) 

 

DIV1	ADD R1, R1, #1		; COUNTER FOR DIVISION (QUOTIENT) 

ADD R4, R4, #-10	; SUBTRACT 10 FROM INPUT 

BRp DIV1		; SUBTRACT 10 TILL INPUT IS 0 OR NEG 

 

ADD R1, R1 #-1		; REMOVE EXTRA 1 

ADD R4, R4, #10		; ADD 10 TO GET REMAINDER 

ADD R6, R4, #-10 

BRnp POS 

 

NEG 	ADD R1, R1, #1 

ADD R4, R4, #-10 

 

 

POS	ST R1, Q			; STORE QUOTIENT 

ST R4, R			; STORE REMAINDER (MOD 10) 

 

LD R0, Q			; LOAD QUOTIENT FOR PRINT 

ADD R0, R0, R5		; TRANSLATE DECIMAL TO SYMBOL 

OUT				; PRINT QUOTIENT 

LD R0, R			; LOAD REMAINDER FOR PRINT 

ADD R0, R0, R5		; TRANSLATE DECIMAL TO SYMBOL 

OUT				; PRINT REMAINDER (MOD 10) 

 

LD R7, SAVELOC1		; RESTORE JSR RETURN LOCATION 

RET 

 

 

 

R .FILL X0 

Q .FILL X0 

 

 

; SUBROUTINE 

; PUSH 

; TAKE IN A NUMBER IN R0 

; AND STORE IT TO A STACK 

; R6 = STACK POINTER 

; R0 = PUSHED TO STACK 

 

 

PUSH	ST R7, SAVELOC2		; STORE JSR LOCATION 

JSR CLEAR_REG		; CLEAR REGISTERS 

LD R6, POINTER		; INITIALIZE POINTER 

ADD R6, R6, #0 

BRnz STACK_ERROR 

 

ADD R6, R6, #-1		; DECREMENT POINTER 

STR R0, R6, #0		; STORE NUMBER IN R0 TO STACK 

ST R6, POINTER		; SAVE POINTER LOCATION 

LD R7, SAVELOC2		; RESTORE LOCATION 

 

RET 

 

POINTER	.FILL X4000		; POINTER START LOCATION 

 

 

 

; SUBROUTINE 

; POP 

; REMOVE A NUMBER FROM THE STACK 

; AND STORE IN R0 

; R6 = STACK POINTER 

; R0 = POPPED FROM STACK 

; R1 = -4000 

 

 

POP	LD R6, POINTER		; LOAD POINTER LOCATION 

ST R1, SAVELOC5 

LD R1, BASELINE 

ADD R1, R1, R6 

BRzp STACK_ERROR 

LD R1, SAVELOC5 

 

LDR R0, R6, #0		; LOAD VALUE IN STACK INTO R0 

ST R7, SAVELOC4		; STORE JSR LOCATION 

 

OUT			; PRINT NUMBER FROM STACK 

LD R0, SPACE		; LOAD A SPACE 

OUT			; PRINT SPACE 

 

ADD R6, R6, #1		; INCREMENT POINTER 

 

ST R6, POINTER		; STORE POINTER LOCATION 

LD R7, SAVELOC4 

 

 

RET 

 

STACK_ERROR	LEA R0, ERROR 

 	PUTS 

HALT 

 

BASELINE 	.FILL xC000 

ERROR		.STRINGZ "STACK UNDERFLOW OR UNDERFLOW. HALTING PROGRAM" 

 

 

; SUBROUTINE 

; GET_LETTER 

; TAKES A TWO DIGIT GRADE 

; AND RETURNS A CORRESPONDING 

; LETTER VALUE TO R0 

 

; R3 = INPUT - NUMBER TO CONVERT 

; R2 = PLATFORM FOR COMPARISON 

; R0 = NUMBER EQUIVALENT TO LETTER  

; R1 = LETTER EQUIVALENT TO NUMBER 

 

 

GET_LETTER 

AND R2, R2, #0			; CLEAR R2 

 

A_GRADE	LD R0, A_NUM			; LOAD NUMBER VALUE  

LD R1, A_LET		; LOAD SYMBOL VALUE  

 

ADD R2, R3, R0		; COMPARE INPUT TO VALUE OF GRADE 

BRzp STR_GRADE		; IF POS OR ZERO STORE GRADE 

 

B_GRADE	AND R2, R2, #0 

LD R0, B_NUM 

LD R1, B_LET 

 

ADD R2, R3, R0 

BRzp STR_GRADE 

 

C_GRADE	AND R2, R2, #0 

LD R0, C_NUM 

LD R1, C_LET 

 

ADD R2, R3, R0 

BRzp STR_GRADE 

 

D_GRADE	AND R2, R2, #0 

LD R0, D_NUM 

LD R1, D_LET 

 

ADD R2, R3, R0 

BRzp STR_GRADE 

 

F_GRADE	AND R2, R2, #0 

LD R0, F_NUM 

LD R1, F_LET 

 

ADD R2, R3, R0 

BRNZP STR_GRADE 

 

RET 

 

 

STR_GRADE 	ST R7, SAVELOC1	  	; SAVE JSR LOCATION 

AND R0, R0, #0	 	; CLEAR R0 

ADD R0, R1, #0	 	; ADD LETTER TO R0 

JSR PUSH		; PUSH LETTER TO STACK 

LD R7, SAVELOC1		; RESTORE JSR LOCATION 

RET				 	; RETURN TO MAIN 

 

 

A_NUM	.FILL #-90 

A_LET	.FILL X41 

 

B_NUM	.FILL #-80 

B_LET	.FILL X42 

 

C_NUM	.FILL #-70 

C_LET	.FILL X43 

 

D_NUM	.FILL #-60 

D_LET	.FILL X44 

 

F_NUM	.FILL #-50 

F_LET	.FILL X46 

 

 

 

CLEAR_REG	AND R1, R1, #0 

AND R2, R2, #0 

AND R3, R3, #0 

AND R4, R4, #0 

AND R5, R5, #0 

AND R6, R6, #0 

RET 

 

 

 

 

; SUBROUTINE 

; CHECKS THE INPUT FOR A NUMBER 

; IF NOT A NUMBER RESTARTS PROGRAM 

; R1 = -48  (START OF NUMBERS) 

; R2 = -57  (END OF NUMBERS) 

; R0 = INPUT 

 

 

VALIDA	ST R1, SAVELOC5		; STORE VARIABLES 

ST R2, SAVELOC4 

ST R3, SAVELOC3 

 

LD R1, DATA_MIN		; COMPARE INPUT TO LOWEST ACCEPTABLE DEC VALUE 

ADD R2, R0, R1		 

BRN FAIL		; FAIL IF OUT OF RANGE 

 

LD R1, DATA_MAX		; COMPARE INPUT TO HIGHEST ACCEPTABLE DEC VALUE 

ADD R3, R0, R1 

BRP FAIL		; FAIL IF OUT OF RANGE 

 

LD R1, SAVELOC5		; RESTORE VARIABLES 

LD R2, SAVELOC4 

LD R3, SAVELOC3 

 

RET 

 

 

; BRANCHES AND VARIABLES FOR 

; VALIDA 

 

 

FAIL 	LEA R0, FAIL_STR	; FAIL BRANCH 

PUTS 

LD R0, NEWLINE2 

OUT 

LD R7, RESTART		; LOAD X3000 LOCATION 

JMP R7			; RESTART PROGRAM 

 

 

FAIL_STR	.STRINGZ "INVALID ENTRY, RESTARTING..." 

RESTART		.FILL X3000 

DATA_MIN	.FILL #-48 

DATA_MAX	.FILL #-57 

NEWLINE2	.FILL XA 

 

 

.END 