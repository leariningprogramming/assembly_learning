; 本程序系统关键字全部使用大写
; 自定义标号和变量名全部使用小写
; 数字及其进制标记全部使用小写
; 实际上系统关键字和数字及其进制不区分大小写
; 而自定义标号和变量名要区分大小写
datas SEGMENT
	x DD 23 ; x, y在本程序中并未使用，仅用于创建4字节变量的示例
	y DD -10
	msg DB "Hello ", "$" ; $表示字符串结尾
	info DB "Input your name: ", "$"
	buf DB 20,0,20 dup("$") ; 输入缓冲区
				; 第一个字节代表总长度
				; 第二个字节表示实际长度（将由程序自动更新）
				; n dup(m) 表示创建20个内容为m的字节
datas ENDS

stacks SEGMENT stack
	DB 128 DUP(0)
stacks ENDS

puts MACRO string ; 宏定义，参数只能用字符或者字符串,可以不加参数
	LEA DX, string
	MOV AH, 09h ; 将09h移动到ah寄存器
	INT 21h	; 调用dos功能，21h指执行ah寄存器指定功能，详见dos功能表
ENDM

gets MACRO buff 
	LEA DX, buff
	MOV AH, 0ah
	INT 21h
ENDM

enter MACRO ; 换行防止覆盖原本的输出
	MOV DL, 0ah ; 换行符   
	MOV AH, 02h
	INT 21h 
ENDM

codes SEGMENT
	ASSUME CS:codes,DS:datas,SS:stacks ;指定代码段，数据段，堆栈段
start:
	MOV AX, stacks
	MOV SS, AX
	MOV AX, datas
	MOV DS, AX
	puts info
	gets buf
	enter
	puts msg
	puts buf+2
	MOV AH, 4ch
	INT 21h
codes ENDS
	END start
