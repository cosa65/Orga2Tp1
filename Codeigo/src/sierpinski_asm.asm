global sierpinski_asm

section .data

section .text

;void sierpinski_asm (unsigned char *src,	
;                     unsigned char *dst,		
;                     int cols, int rows,	

;                     int src_row_size,	
;                     int dst_row_size)		

sierpinski_asm:

	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	push rbx
	sub rsp,8


	;xor r15, r15
	;mov r15d, edx
	;xor rdx, rdx
	;mov rax, 255		;Esto servia de algo al final?
	;div r15
	;mov r12, rax



	





									;rdi = source			,los punteros que voy avanzando (copia de)
									;rsi = destino			,los punteros que voy avanzando	(copia a)
									;rdx = cols				,cmps de mis operandos
									;rcx = filas			,cmps de mis operandos

									;r9  = dst row_size		,cmp anterior para ver si hay basura
	xor r10,r10
	xor r11,r11
	xor r14,r14						;r14 = fila actual		(i)
	xor r12,r12						;r12 = columna actual	(j)
	xor r13,r13
	mov r13,rdi						;r13 = columna(byte) actual (en src)
	xor r15,r15
	mov r15,rsi						;r15 = columna(byte) actual (en src)

.ciclo:

;Primero defino los 2 Coefs


;-----------------------Definicion 1er Coef-----------------------------------------------------------------------------
	pxor XMM7,XMM7
	pxor XMM0,XMM0
	pxor XMM1,XMM1
	pxor XMM2,XMM2
	pxor XMM3,XMM3

	movd MM0, r14					;MM0 = i
	movd MM1, r12					;MM1 = j

	pxor XMM6,XMM6
	mov rax, 255
	movq XMM6, rax
	mulps XMM0, XMM6				;XMM0=i*255/cantFilas
	mulps XMM1, XMM6				;XMM1=j*255/cantColumnas

	CVTSI2SD XMM2, ecx
	divsd XMM0, XMM2				;XMM0=i/cantFilas
	CVTSI2SD XMM3, edx
	divsd XMM1, XMM3				;XMM0=j/cantColumnas



	CVTTSD2SI r10, XMM0				;r10=int(i*255/cantFilas)
	CVTTSD2SI r11, XMM1				;r11=int(j*255/cantColumnas)

	xor r10d,r11d					;rax = int(j*255/cantColumnas) ^ int(i*255/cantFilas)

	push rdx

	xor rdx,rdx
	xor rax,rax
	mov eax,r10d
	xor r11,r11
	mov r11,255
	div r11							;rax = int(j*255/cantColumnas) ^ int(i*255/cantFilas)/255

	pop rdx

	pxor XMM4,XMM4
	CVTSI2SD XMM4, rax

;-----------------------Definicion 2do Coef-----------------------------------------------------------------------------

	

	pxor XMM1,XMM1
	pxor XMM2,XMM2
	pxor XMM3,XMM3

	inc r14
	inc r12

	movd MM0, r14					;MM0 = i+1
	movd MM1, r12					;MM1 = j+1

	CVTSI2SD XMM2, ecx
	divsd XMM0, XMM2				;XMM0=i+1/cantFilas
	CVTSI2SD XMM3, edx
	divsd XMM1, XMM3				;XMM0=j+1/cantColumnas

	pxor XMM6,XMM6
	mov rax, 255
	movq XMM6, rax
	mulps XMM0, XMM6				;XMM0=i*255/cantFilas
	mulps XMM1, XMM6				;XMM1=j*255/cantColumnas

	CVTTSD2SI r10, XMM0				;r10=int(i+1*255/cantFilas)
	CVTTSD2SI r11, XMM1				;r11=int(j+1*255/cantColumnas)

	xor r10d,r11d					;rax = int(j+1*255/cantColumnas) ^ int(i+1*255/cantFilas)

	push rdx

	xor rdx,rdx
	xor rax,rax
	mov eax,r10d
	xor r11,r11
	mov r11,255
	div r11							;rax = int(j+1*255/cantColumnas) ^ int(i+1*255/cantFilas)/255

	pop rdx


	MOVHPD XMM4,8					;shiftear para arriba (NO ME ANDA TODAVIA)
	CVTSI2SD XMM4, rax				;esto me borra lo que habia en la parte alta????PREGUNTAAAAAAAAAAAAA

;-----------------------Fin Definicion Coefs----------------------------------------------------------------------------
;XMM4h = coef0, XMM4l = coef1


	








.finciclo:

	inc r14
	inc r12
												
;	add r13, 8									;aca veo si termino el ciclo(o si cambio de fila)
;	cmp r13, r8
;	je .compFila
;	inc r14
;	xor r13,r13
;	jmp .ciclo

;.compFila:
;	cmp r14, r8									;veo si llegue al final
;	je .copiarBasura
;	cmp r13, rdx								;veo si llegue al final de la fila actual solo
;	jne .ciclo
;	inc r14
;	xor r13,r13
;	jmp .ciclo


.fin:

	add rsp,8
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
    ret
