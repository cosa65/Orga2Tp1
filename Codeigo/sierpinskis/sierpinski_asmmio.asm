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
	push r14

											;rdi = source			,(copia de)
											;rsi = destino			,(copia a)
											;rdx = #cols			,cantColumnas
											;rcx = #filas			,cantFilas

											;r9  = dst row_size

	pxor XMM11,XMM11						;r14 = fila actual		(i)
	pxor XMM12,XMM12						;r12 = columna actual	(j)

	addps XMM12, [ceundotre]				;XMM12 = {j,j+1,j+2,j+3}

	xor r14,r14
	xor r12,r12



	pxor XMM8,XMM8							;XMM8 = 0

	movdqu XMM14, [cuatrocuatros]			;XMM14 = {4,4,4,4}
	movdqu XMM15, [cuatrounos]				;XMM15 = {1,1,1,1}
	movdqu XMM10, [D55]						;XMM10 = {255,255,255,255}

	pxor XMM6,XMM6
	pxor XMM7,XMM7
	movd XMM6, edx							;XMM6 = #cols
	movd XMM7, ecx							;XMM7 = #filas
	shufps XMM6, XMM6, 0					;XMM6 = {#filas,#filas,#filas,#filas}
	shufps XMM7, XMM7, 0					;XMM7 = {#columnas,#columnas,#columnas,#columnas}
	cvttdq2ps XMM6, XMM6	
	cvttdq2ps XMM7, XMM7	

.ciclo:


		movdqa XMM0, XMM11					;XMM0 = {i,i,i,i}
		movdqa XMM1, XMM12					;XMM1 = {j,j+1,j+2,j+3}

		mulps XMM0, XMM10					;XMM0 = {i*255,i*255,i*255,i*255}
		mulps XMM1, XMM10					;XMM1 = {j*255,(j+1)*255,(j+2)*255,(j+3)*255}

		divps XMM0, XMM6					;XMM0 = {i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas}
		divps XMM1, XMM7					;XMM1 = {j*255/#columnas,(j+1)*255/#columnas,(j+2)*255/#columnas,(j+3)*255/#columnas}

		cvttps2dq XMM0, XMM0				;XMM0 = int({i*255/#filas,i*255/#filas,i*255/#filas,i*255/#filas})
		cvttps2dq XMM1, XMM1				;XMM1 = int({j*255/#columnas,(j+1)*255/#columnas(j+2)*255/#columnas,(j+3)*255/#columnas})

		pxor XMM0,XMM1						;XMM0 = int({coef,coef1,coef2,coef3}) SIN DIVIDIR

		cvttdq2ps XMM0, XMM0				;XMM0 = {coef,coef1,coef2,coef3} SIN DIVIDIR

		pxor XMM2,XMM2
		pxor XMM3,XMM3
		pxor XMM4,XMM4
		pxor XMM5,XMM5

		movdqu XMM2,[rdi]					;XMM2 = {p3,p2,p1,p0}		
		shufps XMM3,XMM2, 64
		shufps XMM3,XMM3, 3

		shufps XMM4,XMM2, 128
		shufps XMM4,XMM4, 3

		shufps XMM5,XMM2, 192
		shufps XMM5,XMM5, 3


		punpcklbw XMM2, XMM8
		punpcklbw XMM3, XMM8
		punpcklbw XMM4, XMM8
		punpcklbw XMM5, XMM8

		punpcklwd XMM2, XMM8				;XMM2={r0,g0,b0,a0}
		punpcklwd XMM3, XMM8				;XMM3={r1,g1,b1,a1}
		punpcklwd XMM4, XMM8				;XMM4={r2,g2,b2,a2}
		punpcklwd XMM5, XMM8				;XMM5={r3,g3,b3,a3}

		cvttdq2ps XMM2, XMM2
		cvttdq2ps XMM3, XMM3
		cvttdq2ps XMM4, XMM4
		cvttdq2ps XMM5, XMM5

		movdqa XMM9, XMM0
		shufps XMM9, XMM9, 0				;XMM9 = {coef3,coef3,coef3,coef3}
		mulps XMM5, XMM9

		movdqa XMM9, XMM0
		shufps XMM9, XMM9, 85				;XMM9 = {coef2,coef2,coef2,coef2}
		mulps XMM4, XMM9

		movdqa XMM9, XMM0
		shufps XMM9, XMM9, 170 				;XMM9 = {coef1,coef1,coef1,coef1}
		mulps XMM3, XMM9

		movdqa XMM9, XMM0
		shufps XMM9, XMM9, 255				;XMM9 = {coef0,coef0,coef0,coef0}
		mulps XMM2, XMM9

		divps XMM5, XMM10
		divps XMM4, XMM10
		divps XMM3, XMM10
		divps XMM2, XMM10

		cvttps2dq XMM5, XMM5
		cvttps2dq XMM4, XMM4
		cvttps2dq XMM3, XMM3
		cvttps2dq XMM2, XMM2

		packusdw XMM5,XMM8
		packusdw XMM4,XMM8
		packusdw XMM3,XMM8
		packusdw XMM2,XMM8

		packuswb XMM2,XMM8					;XMM2 = {0,0,0,p0}
		packuswb XMM3,XMM8					;XMM3 = {0,0,0,p1}
		packuswb XMM4,XMM8					;XMM4 = {0,0,0,p2}
		packuswb XMM5,XMM8					;XMM5 = {0,0,0,p3}

		shufps XMM2, XMM3, 0				;XMM2 = {p1,p1,p0,p0}
		shufps XMM4, XMM5, 0				;XMM4 = {p3,p3,p2,p2}
		shufps XMM2, XMM4, 0x88				;XMM2 = {p3,p2,p1,0}
		movdqu [rsi],  XMM2


.ChequeoSiSeguir:

	add rdi,16
	add rsi,16

	add r12d,16							;r12 = {(pixel+4)*4}

	addps XMM12,XMM14					;XMM12 = {j+4,j+5,j+6,j+7}

	cmp r12d,r9d 						;veo si llegue al final de la fila
	jne .ciclo							;caso NO llegue al final de fila

										;caso SI llegue al final de fila

	addps XMM11,XMM15					;XMM11 = {i+1,i+1,i+1,i+1}
	inc r14d

	pxor XMM12,XMM12
	xor r12,r12
	cmp r14d,ecx						;veo si llegue al final de la matriz

	jne .ciclo

.fin:

	pop r14
	pop r12
	pop rbp
    ret