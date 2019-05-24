; 本程序系统关键字全部使用大写
; 自定义标号和变量名全部使用小写
; 数字及其进制标记全部使用小写
; 实际上系统关键字和数字及其进制不区分大小写
; 而自定义标号和变量名要区分大小写

; 本程序将用函数实现两个一位正数的加法

data SEGMENT
data ENDS

stack SEGMENT stack
	DW 128 DUP(0)
stack ENDS

code SEGMENT
	ASSUME CS:code,DS:data,SS:stack

addxy PROC ; 过程，即函数
	PUSH BP
	MOV BP, SP
	MOV AX, [BP+4]
	SUB AX, 30h ; 转化为数字
	MOV CX, [BP+6]
	SUB CX, 30h
	ADD AX, CX
	ADD AX, 30h
	POP BP
	RET
addxy ENDP

start:
	MOV AX, stack
	MOV SS, AX
	MOV AX, data
	MOV DS, AX
	
	; 输入两个字符并入栈
	MOV AH, 01h
	INT 21h
	MOV BX, AL
	PUSH BX
	INT 21h ; 忽略掉换行符
	MOV AH, 01h
	INT 21h
	MOV BX, AL
	PUSH BX

	CALL addxy
	
	MOV BL, AL
	MOV AH, 02h
	MOV DL, 0ah ; 换行防止覆盖
	INT 21h
	MOV AH, 02h
	MOV DL, BL
	INT 21h
	
	MOV AH, 4ch
	INT 21h
code ENDS
	END start