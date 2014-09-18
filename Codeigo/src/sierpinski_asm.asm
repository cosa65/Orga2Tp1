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

	xor r14,r14						;r14 = fila actual		(i)
	xor r10,r10						;r10 = columna actual	(j)
	xor r13,r13
	mov r13,rdi						;r13 = columna(byte) actual (en src)
	xor r15,r15
	mov r15,rsi						;r15 = columna(byte) actual (en src)

.ciclo:


;Primero defino los 2 Coefs
	pxor XMM7,XMM7
	pxor XMM0,XMM0

	movd MM0, r14					;MM0 = i
	divsd XMM0, rcx
	













												
	add r13, 8									;aca veo si termino el ciclo(o si cambio de fila)
	cmp r13, r8
	je .compFila
	inc r14
	xor r13,r13
	jmp .ciclo

.compFila:
	cmp r14, r8									;veo si llegue al final
	je .copiarBasura
	cmp r13, rdx								;veo si llegue al final de la fila actual solo
	jne .ciclo
	inc r14
	xor r13,r13
	jmp .ciclo


.fin:

	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
    ret
