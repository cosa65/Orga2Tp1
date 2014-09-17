global sierpinski_asm

section .data

section .text

;void sierpinski_asm (unsigned char *src,			;rdi = source
;                     unsigned char *dst,			;rsi = destino
;                     int cols, int rows,			;rdx = cols				== a row_size
													;rcx = filas
;                     int src_row_size,				;r8  = src row_size		(mismo
;                     int dst_row_size)				;r9  = dst row_size			  tamaño)

sierpinski_asm:

	push rbp
	mov rbp, rsp
	push r12
	push r13


	mov rax, rdx
	xor r8,r8
	mov r8, 4
	div r8

	mul rcx
	mov r9, rax

									;r9  = contador(en pixeles)
									;rdx = columnas
									;rcx = filas
	xor r12,r12						;r12 = columna(byte) actual
	xor r13,r13						;r13 = fila actual

.ciclo:

	movq XMM0, r12
	movq XMM1, r13

	mov r8, 255
	


	cmp r12, r8

	pop r13
	pop r12
	pop rbp
    ret
