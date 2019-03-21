;=================================================
; Name: Steven Tran
; Email:  stran050@ucr.edu
; GitHub username: Azenros
; 
; Lab: lab 9
; Lab section: 25
; TA: Daniel Handojo
;=================================================
.ORIG x3000

LD R4, STACK_ARR_PTR
ADD R5, R4, #5
ADD R6, R4, #0

LD R1, SUB_3600
JSRR R1
LD R0, TEST_PUSH1
LD R1, SUB_3300
JSRR R1
JSRR R1
JSRR R1
JSRR R1
JSRR R1
JSRR R1
LD R1, SUB_3600
JSRR R1
JSRR R1
JSRR R1
JSRR R1
JSRR R1
JSRR R1
HALT

;----------
; Data
;----------
SUB_3300 .FILL x3300
SUB_3600 .FILL x3600
TEST_PUSH1 .FILL #6
TEST_PUSH2 .FILL #81
TEST_PUSH3 .FILL #48
TEST_PUSH4 .FILL #16
TEST_PUSH5 .FILL #68
TEST_PUSH_FULL .FILL #48


STACK_ARR_PTR .FILL xA000



;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (​ one less than​ the lowest available
;                 address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​ current ​ top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
;                If the stack was already full (TOS = MAX), the subroutine has printed an
;                overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3300

SUB_STACK_PUSH
  ST R0, R0_3300B
  ST R1, R1_3300B
  ST R2, R2_3300B
  ST R4, R4_3300B
  ST R5, R5_3300B
  ST R7, R7_3300B
  
  ADD R6, R6, #1
  NOT R5, R5
  ADD R5, R5, #1
  ADD R2, R6, R5
  BRp FULL_STACK
  
  STR R0, R6, #0
  BR END_3300
  
  FULL_STACK
    LEA R0, ERROR_OVERFLOW
    PUTS
    ADD R6, R6, #-1
  
END_3300
  LD R0, R0_3300B
  LD R1, R1_3300B
  LD R2, R2_3300B
  LD R4, R4_3300B
  LD R5, R5_3300B
  LD R7, R7_3300B
  RET

;--------------------
; Subroutine Data
;--------------------
ERROR_OVERFLOW .STRINGZ "ERROR: Tried to call push on a full stack\n"

R0_3300B .BLKW #1
R1_3300B .BLKW #1
R2_3300B .BLKW #1
R4_3300B .BLKW #1
R5_3300B .BLKW #1
R7_3300B .BLKW #1

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (​ one less than​ the lowest available
;                 address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​ current ​ top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;                If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
;               R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3600

SUB_STACK_POP
  ST R1, R1_3600B
  ST R2, R2_3600B
  ST R4, R4_3600B
  ST R5, R5_3600B
  ST R7, R7_3600B
  
  LDR R0, R6, #0
  ADD R6, R6, #-1
  NOT R4, R4
  ADD R4, R4, #1
  ADD R1, R6, R4
  BRn EMPTY_STACK
  BR END_3600
  
  EMPTY_STACK
    LEA R0, ERROR_UNDERFLOW
    PUTS
    ADD R6, R6, #1
  
END_3600
  LD R1, R1_3600B
  LD R2, R2_3600B
  LD R4, R4_3600B
  LD R5, R5_3600B
  LD R7, R7_3600B
  RET

;--------------------
; Subroutine Data
;--------------------
ERROR_UNDERFLOW .STRINGZ "ERROR: Tried to call pop on an empty stack\n"

R1_3600B .BLKW #1
R2_3600B .BLKW #1
R4_3600B .BLKW #1
R5_3600B .BLKW #1
R7_3600B .BLKW #1



.ORIG xA000
STACK_ARR .BLKW #5



.END