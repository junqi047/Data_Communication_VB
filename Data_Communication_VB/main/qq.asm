ORG 0000H
LJMP START
ORG 0003H
LJMP INT
START:MOV SP,#60H
SETB EA
SETB EX0
MOV P1,#0FFH
      MOV P2,#00H
      MOV R0,#10
      MOV R1,#0
	   MOV A,#0
	   JB P1.4,$
      SETB P2.3
LOOP1:JB P1.0,JIAN1
      ADD A,R0
      MOV R1,A
		LCALL ZCX
JIAN1:JB P1.1 ,JIAN2
      INC R1
      MOV A,R1
		LCALL ZCX
JIAN2: JB P1.2, JIAN3
      SUBB A,R0
      MOV R1,A
		LCALL ZCX
JIAN3: JB p1.3 ,JIAN4
      DEC R1
      MOV A,R1
		LCALL ZCX
JIAN4: JB P1.5 ,LOOP1 
      CLR P2.3
      SETB P2.4
      MOV A,#0
LOOP2: JB P1.0 ,JIAN5
      ADD A,R0
      MOV R2,A
		LCALL ZCX
JIAN5: JB P1.1,JIAN6
      INC R2
      MOV A,R2
		LCALL ZCX
JIAN6: JB P1.2, JIAN7
      SUBB A,R0
      MOV R2,A
		LCALL ZCX
JIAN7: JB P1.3 ,JIAN8
      DEC R2
      MOV A,R2
		LCALL ZCX
JIAN8:JB P1.6 ,LOOP2
      CLR P2.4
      SETB P2.5
      SETB P2.7
      LCALL DELAY
      CLR P2.7
LOOP3:
      MOV A,R1 
     	MOV B,#10 
DIV AB
    xch a,b
mov scon,#0
clr es
mov dptr,#table
movc a,@a+dptr
clr ti
mov sbuf,a
lcall delay1
mov a,b
movc a,@a+dptr
clr ti
mov sbuf,a
lcall delay
JB P1.7,$     
MOV A,R2 
SUBB A,R1
CJNE A,#0,LOOP4
SETB P2.7
LCALL DELAY
 CLR P2.7
LOOP4:INC R1
     CJNE R1,#61,LOOP3
     MOV R1,#0
     LJMP LOOP3
DELAY:MOV R5,#10
   D1:MOV R6,#200
   D2:MOV R7,#250
   D3:DJNZ R7,D3
      DJNZ R6,D2
      DJNZ R5,D1
      RET
DELAY1:MOV R3,#1
  JIAN10:DJNZ R3,JIAN10
     RET
ZCX: MOV R4,A
		MOV B,#10  
     DIV AB
     xch a,b
mov scon,#0
clr es
mov dptr,#table
movc a,@a+dptr
clr ti
mov sbuf,a
lcall delay1
mov a,b
movc a,@a+dptr
clr ti
mov sbuf,a
lcall delay
     MOV A,R4
	  RET
TABLE:DB 0FCH,60H,0DAH,0F2H,66H,0B6H,0BEH,0E0H,0FEH,0F6H

INT:PUSH ACC
JNB P3.4,$
JB P3.4,$
POP ACC
RETI
end
