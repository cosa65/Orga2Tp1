global sierpinski_asm

section .data

section .text

;void sierpinski_asm (unsigned char *src,			;rdi
;                     unsigned char *dst,			;rsi
;                     int cols, int rows,			;rdx, rcx
;                     int src_row_size,				;r8
;                     int dst_row_size)				;r9

sierpinski_asm:

	push rbp
	mov rbp, rsp
	push r12
	sub rsp,8

													;coef = r12


.cicloRows:


	.cicloCol:


		.calcularCoef:

		








	add rsp,8
	pop r12
	pop rbp
    ret