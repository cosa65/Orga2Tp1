
global bandas_asm

section .data



section .text
;void bandas_asm    (
	;unsigned char *src,
	;unsigned char *dst,
	;int filas,
	;int cols,
	;int src_row_size,
	;int dst_row_size)
	;(([x/96]+1)/2] *64
		

bandas_asm:

		push rbp
		mov rbp, rsp

		and r9, 4294967295
		and r8, 4294967295
		and rcx, 4294967295
		and rdx, 4294967295

		mov r11d, 64
		movd xmm4, r11d
		pshufd xmm4, xmm4, 0x00

		mov r11d, 192
		movd xmm5, r11d
		pshufd xmm5, xmm5, 0x00

		mov r11d, 95
		movd xmm11, r11d
		pshufd xmm11, xmm11, 0x00

		mov r11d, 287
		movd xmm12, r11d
		pshufd xmm12, xmm12, 0x00

		mov r11d, 479
		movd xmm13, r11d
		pshufd xmm13, xmm13, 0x00

		mov r11d, 671
		movd xmm14, r11d
		pshufd xmm14, xmm14, 0x00

		pxor xmm9, xmm9

		mov r11, 0x0C0C0C0C08080808
		movq xmm6, r11
		pslldq xmm6, 8
		mov r11, 0x0404040400000000
		movq xmm9, r11
		por xmm9, xmm6

		mov r11d, 0x000000FF
		movd xmm10, r11d
		pshufd xmm10, xmm10, 0x00

		mov r11, rdi
		mov rax, rsi
		mov r10, rdx

.ciclope movdqu xmm0, [r11]
		movdqa xmm1, xmm0
		movdqa xmm2, xmm0		

		psrldq xmm1, 1
		psrldq xmm2, 2		

		pand xmm0, xmm10
		pand xmm1, xmm10
		pand xmm2, xmm10

		paddd xmm0, xmm1
		paddd xmm0, xmm2

		pxor xmm3, xmm3

		movdqa xmm15, xmm0
		pcmpgtd xmm15, xmm11
		pand xmm15, xmm4
		por xmm3, xmm15

		movdqa xmm15, xmm0
		pcmpgtd xmm15, xmm12
		pand xmm15, xmm5
		pxor xmm3, xmm15

		movdqa xmm15, xmm0
		pcmpgtd xmm15, xmm13
		pand xmm15, xmm4
		por xmm3, xmm15

		pcmpgtd xmm0, xmm14
		por xmm3, xmm0

		pshufb xmm3, xmm9

		movdqu [rax], xmm3

		sub r10, 4
		add rax, 16
		add r11, 16
		cmp r10, 0
		jne .ciclope
		add rsi, r9
		mov rax, rsi
		add rdi, r8
		mov r11, rdi
		mov r10, rdx
		dec rcx
		cmp rcx, 0
		jne .ciclope

		pop rbp
    	
    	ret


