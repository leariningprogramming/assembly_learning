; ������ϵͳ�ؼ���ȫ��ʹ�ô�д
; �Զ����źͱ�����ȫ��ʹ��Сд
; ���ּ�����Ʊ��ȫ��ʹ��Сд
; ʵ����ϵͳ�ؼ��ֺ����ּ�����Ʋ����ִ�Сд
; ���Զ����źͱ�����Ҫ���ִ�Сд

; �������ú���ʵ������һλ�����ļӷ�

data SEGMENT
data ENDS

stack SEGMENT stack
	DW 128 DUP(0)
stack ENDS

code SEGMENT
	ASSUME CS:code,DS:data,SS:stack

addxy PROC ; ���̣�������
	PUSH BP
	MOV BP, SP
	MOV AX, [BP+4]
	SUB AX, 30h ; ת��Ϊ����
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
	
	; ���������ַ�����ջ
	MOV AH, 01h
	INT 21h
	MOV BX, AL
	PUSH BX
	INT 21h ; ���Ե����з�
	MOV AH, 01h
	INT 21h
	MOV BX, AL
	PUSH BX

	CALL addxy
	
	MOV BL, AL
	MOV AH, 02h
	MOV DL, 0ah ; ���з�ֹ����
	INT 21h
	MOV AH, 02h
	MOV DL, BL
	INT 21h
	
	MOV AH, 4ch
	INT 21h
code ENDS
	END start