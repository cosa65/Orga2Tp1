
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

		mov r11d, 96
		cvtsi2ss xmm11, r11d
		shufps xmm11, xmm11, 00000000

		mov r11d, 1
		movd xmm13, r11d
		shufps xmm13, xmm13, 00000000

		pxor xmm15, xmm15
		mov r11d, 65535
		movd xmm15, r11d

		pxor xmm9, xmm9

		mov r11, 0x0C0C0C0C08080808
		movq xmm4, r11
		pslldq xmm4, 8
		mov r11, 0x0404040400000000
		movq xmm9, r11
		por xmm9, xmm4

		pxor xmm4, xmm4

		mov r11d, 255
		movd xmm8, r11d,
		pshufd xmm8, xmm8, 0x00

		mov r11, rdi
		mov rax, rsi
		mov r10, rdx

.ciclope movdqu xmm0, [r11]
		movdqa xmm5, xmm0
		punpcklbw xmm0, xmm4
		punpckhbw xmm5, xmm4
		movdqa xmm1, xmm0
		movdqa xmm2, xmm0		
		movdqa xmm6, xmm5
		movdqa xmm7, xmm5
		psrldq xmm1, 2
		psrldq xmm2, 4		
		psrldq xmm6, 2
		psrldq xmm7, 4
		paddw xmm0, xmm1
		paddw xmm0, xmm2
		paddw xmm5, xmm6
		paddw xmm5, xmm7

		movdqa xmm1, xmm0		
		movdqa xmm6, xmm5

		psrldq xmm1, 8
		psrldq xmm6, 8

		pand xmm0, xmm15
		pand xmm1, xmm15
		pand xmm5, xmm15
		pand xmm6, xmm15

		pslldq xmm1, 2
		pslldq xmm5, 4
		pslldq xmm6, 6

		por xmm0, xmm1
		por xmm0, xmm5
		por xmm0, xmm6

		punpcklwd xmm0, xmm4

		cvtdq2ps xmm0, xmm0
		divps xmm0, xmm11
		cvttps2dq xmm0, xmm0
		paddd xmm0, xmm13
		psrld xmm0, 1
		pslld xmm0, 6

		movdqa xmm1, xmm0
		pcmpgtd xmm1, xmm8
		por xmm0, xmm1
		pshufb xmm0, xmm9

		movdqu [rax], xmm0

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


