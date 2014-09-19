global sierpinski_asm

section .data

D55: DD 255, 255, 255, 255
ceundotre: DD 0, 1, 2, 3

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
	sub rsp,8




									;rdi = source			,(copia de)
									;rsi = destino			,(copia a)
									;rdx = #cols			,cantColumnas
									;rcx = #filas			,cantFilas

									;r9  = dst row_size

	xor r14,r14						;r14 = fila actual		(i)
	xor r12,r12						;r12 = columna actual	(j)
	xor r13,r13
	mov r13,rdi						;r15 = Lo que va a rax (*dst)

	pxor XMM6,XMM6
	movd XMM6, edx						;XMM6 = #cols
	pxor XMM7,XMM7
	movd XMM7, ecx						;XMM7 = #filas

	shufps XMM6, XMM6, 0				;XMM6 = {#filas,#filas,#filas,#filas}
	shufps XMM7, XMM7, 0				;XMM7 = {#columnas,#columnas,#columnas,#columnas}

.ciclo:

		;r14=i
		;r12=j


		movd XMM0, r14d						;XMM0 = i
		movd XMM1, r12d						;XMM1 = j

		shufps XMM0, XMM0, 0				;XMM0 = {i,i,i,i}
		shufps XMM1, XMM1, 0				;XMM1 = {j,j,j,j}

		addpd XMM1, [ceundotre]				;XMM1 = {j,j+1,j+2,j+3}

		mulps XMM0, [D55]					;XMM0 = {i*255,i*255,i*255,i*255}
		mulps XMM1, [D55]					;XMM1 = {j*255,(j+1)*255,(j+2)*255,(j+3)*255}

		divps XMM0, XMM6					;XMM0 = {i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas}
		divps XMM1, XMM7					;XMM1 = {j*255/#columnas,(j+1)*255/#columnas,(j+2)*255/#columnas,(j+3)*255/#columnas}

		cvtps2dq XMM0, XMM0					;XMM0 = int({i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas})
		cvtps2dq XMM1, XMM1					;XMM1 = int({j*255/#columnas,(j+1)*255/#columnas(j+2)*255/#columnas,(j+3)*255/#columnas})

		pxor XMM0,XMM1						;XMM0 = int({coef,coef1,coef2,coef3}) SIN DIVIDIR

		cvtdq2ps XMM1, XMM1					;XMM1 = {j*255/#columnas,(j+1)*255/#columnas(j+2)*255/#columnas,(j+3)*255/#columnas}

		pxor XMM2,XMM2
		pxor XMM3,XMM3
		pxor XMM4,XMM4
		pxor XMM5,XMM5
		pxor XMM8,XMM8						;XMM8 = 0
		movd XMM2,[rdi]
		movd XMM3,[rdi+1]
		movd XMM4,[rdi+2]
		movd XMM5,[rdi+3]

		punpcklbw XMM2, XMM8
		punpcklbw XMM3, XMM8
		punpcklbw XMM4, XMM8
		punpcklbw XMM5, XMM8

		punpcklwd XMM2, XMM8				;XMM2={r0,g0,b0,a0}
		punpcklwd XMM3, XMM8				;XMM3={r1,g1,b1,a1}
		punpcklwd XMM4, XMM8				;XMM4={r2,g2,b2,a2}
		punpcklwd XMM5, XMM8				;XMM5={r3,g3,b3,a3}

		movdqu XMM9, XMM0
		shufps XMM9, XMM0, 0				;XMM9 = {coef3,coef3,coef3,coef3}
		mulps XMM5, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM0, 85				;XMM9 = {coef2,coef2,coef2,coef2}
		mulps XMM4, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM0, 170 				;XMM9 = {coef1,coef1,coef1,coef1}
		mulps XMM3, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM0, 255				;XMM9 = {coef0,coef0,coef0,coef0}
		mulps XMM2, XMM9

		divps XMM5, [D55]
		divps XMM4, [D55]
		divps XMM3, [D55]
		divps XMM2, [D55]

		cvtps2dq XMM5, XMM5
		cvtps2dq XMM4, XMM4
		cvtps2dq XMM3, XMM3
		cvtps2dq XMM2, XMM2

		packusdw XMM5,XMM5
		packusdw XMM4,XMM4
		packusdw XMM3,XMM3
		packusdw XMM2,XMM2
		packuswb XMM2,XMM2
		packuswb XMM3,XMM3
		packuswb XMM4,XMM4
		packuswb XMM5,XMM5

		movd [rsi],  XMM2
		movd [rsi+1],XMM3
		movd [rsi+2],XMM4
		movd [rsi+3],XMM5



.finciclo:

	add rdi,16
	add rsi,16
	add r12,4							;r12 = j+4

	cmp r12d,edx						;veo si llegue al final de la fila
	jne .ciclo							;caso NO llegue al final de fila

										;caso SI llegue al final de fila
	cmp r14d,ecx						;veo si llegue al final de la matriz
	je .fin

	inc r14
	xor r12,r12
	jmp .ciclo

.fin:

	add rsp,8
	pop r14
	pop r13
	pop r12
	pop rbp
    ret
