global sierpinski_asm

section .data

D55: DD 255.0, 255.0, 255.0, 255.0
ceundotre: DD 0.0, 1.0, 2.0, 3.0
cuatrocuatros: DD 4.0, 4.0, 4.0, 4.0
cuatrounos: DD 1.0, 1.0, 1.0, 1.0

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

	pxor XMM11,XMM11						;r14 = fila actual		(i)
	pxor XMM12,XMM12						;r12 = columna actual	(j)

	addps XMM12, [ceundotre]				;XMM12 = {j,j+1,j+2,j+3}

	xor r14,r14
	xor r13,r13
	xor r12,r12
	mov r13,rsi								;r13 = Lo que va a rax (*dst)


	pxor XMM6,XMM6
	movd XMM6, edx							;XMM6 = #cols
	pxor XMM7,XMM7
	movd XMM7, ecx							;XMM7 = #filas
	pxor XMM8,XMM8							;XMM8 = 0

	movdqu XMM14, [cuatrocuatros]			;XMM14 = {4,4,4,4}
	movdqu XMM15, [cuatrounos]				;XMM15 = {1,1,1,1}
	movdqu XMM10, [D55]						;XMM10 = {255,255,255,255}

	shufps XMM6, XMM6, 0					;XMM6 = {#filas,#filas,#filas,#filas}
	shufps XMM7, XMM7, 0					;XMM7 = {#columnas,#columnas,#columnas,#columnas}

.ciclo:


		movdqu XMM0, XMM11					;XMM0 = {i,i,i,i}
		movdqu XMM1, XMM12					;XMM1 = {j,j+1,j+2,j+3}

		mulps XMM0, XMM10					;XMM0 = {i*255,i*255,i*255,i*255}
		mulps XMM1, XMM10					;XMM1 = {j*255,(j+1)*255,(j+2)*255,(j+3)*255}

		divps XMM0, XMM6					;XMM0 = {i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas}
		divps XMM1, XMM7					;XMM1 = {j*255/#columnas,(j+1)*255/#columnas,(j+2)*255/#columnas,(j+3)*255/#columnas}

		cvtps2dq XMM0, XMM0					;XMM0 = int({i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas})
		cvtps2dq XMM1, XMM1					;XMM1 = int({j*255/#columnas,(j+1)*255/#columnas(j+2)*255/#columnas,(j+3)*255/#columnas})

		pxor XMM0,XMM1						;XMM0 = int({coef,coef1,coef2,coef3}) SIN DIVIDIR

		cvtdq2ps XMM0, XMM0					;NOSEGIRUGORSGXMM0 = {j*255/#columnas,(j+1)*255/#columnas(j+2)*255/#columnas,(j+3)*255/#columnas}

		pxor XMM2,XMM2
		pxor XMM3,XMM3
		pxor XMM4,XMM4
		pxor XMM5,XMM5

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

		cvtdq2ps XMM2, XMM2
		cvtdq2ps XMM3, XMM3
		cvtdq2ps XMM4, XMM4
		cvtdq2ps XMM5, XMM5

		movdqu XMM9, XMM0
		shufps XMM9, XMM9, 0				;XMM9 = {coef3,coef3,coef3,coef3}
		mulps XMM5, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM9, 85				;XMM9 = {coef2,coef2,coef2,coef2}
		mulps XMM4, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM9, 170 				;XMM9 = {coef1,coef1,coef1,coef1}
		mulps XMM3, XMM9

		movdqu XMM9, XMM0
		shufps XMM9, XMM9, 255				;XMM9 = {coef0,coef0,coef0,coef0}
		mulps XMM2, XMM9

		divps XMM5, XMM10
		divps XMM4, XMM10
		divps XMM3, XMM10
		divps XMM2, XMM10

		cvtps2dq XMM5, XMM5
		cvtps2dq XMM4, XMM4
		cvtps2dq XMM3, XMM3
		cvtps2dq XMM2, XMM2

		packusdw XMM5,XMM8
		packusdw XMM4,XMM8
		packusdw XMM3,XMM8
		packusdw XMM2,XMM8

		packuswb XMM2,XMM8
		packuswb XMM3,XMM8
		packuswb XMM4,XMM8
		packuswb XMM5,XMM8

		movd [rsi],  XMM2
		movd [rsi+1],XMM3
		movd [rsi+2],XMM4
		movd [rsi+3],XMM5



.ChequeoSiSeguir:

	add rdi,16
	add rsi,16

	add r12d,16							;r12 = {(pixel+4)*4}

	addps XMM12,XMM14					;XMM12 = {j+4,j+5,j+6,j+7}

	cmp r12d,r9d 						;veo si llegue al final de la fila
	jne .ciclo							;caso NO llegue al final de fila

										;caso SI llegue al final de fila
	cmp r14d,ecx						;veo si llegue al final de la matriz

	je .fin

	addps XMM11,XMM15					;XMM11 = {i+1,i+1,i+1,i+1}
	inc r14d

	xor r12,r12
	jmp .ciclo

.fin:

	add rsp,8
	pop r14
	pop r13
	pop r12
	pop rbp
    ret
