
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
		push r14
		push r13
		push rbx
		sub rsp, 8

		mov rbx, rdx

		xor rax, rax

		rdtsc

		mov r11, rax

		and r9, 4294967295
		and r8, 4294967295
		and rcx, 4294967295
		and rbx, 4294967295

		mov r10d, 96
		cvtsi2ss xmm11, r10d
		shufps xmm11, xmm11, 00000000

		mov r10d, 2
		cvtsi2ss xmm12, r10d
		shufps xmm12, xmm12, 00000000

		mov r10d, 1
		cvtsi2ss xmm13, r10d
		shufps xmm13, xmm13, 00000000

		mov r10d, 64
		cvtsi2ss xmm14, r10d
		shufps xmm14, xmm14, 00000000

		pxor xmm15, xmm15
		mov r10d, 65535
		movd xmm15, r10d

		pxor xmm4, xmm4

		mov r13, rdi
		mov r14, rsi
		mov r10, rbx

.ciclope movdqu xmm0, [r13]
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
		cvtdq2ps xmm0, xmm0
		addps xmm0, xmm13
		divps xmm0, xmm12
		cvttps2dq xmm0, xmm0
		cvtdq2ps xmm0, xmm0

		mulps xmm0, xmm14

		cvttps2dq xmm0, xmm0
		movdqa xmm1, xmm0
		movdqa xmm2, xmm0
		movdqa xmm3, xmm0

		pshufd xmm0, xmm0, 0x00
		pshufd xmm1, xmm1, 0x55
		pshufd xmm2, xmm2, 0xAA
		pshufd xmm3, xmm3, 0xFF

		packusdw xmm0, xmm1
		packusdw xmm2, xmm3
		packuswb xmm0, xmm2

		movdqu [r14], xmm0

		sub r10, 4
		add r14, 16
		add r13, 16
		cmp r10, 0
		jne .ciclope
		add rsi, r9
		mov r14, rsi
		add rdi, r8
		mov r13, rdi
		mov r10, rbx
		dec rcx
		cmp rcx, 0
		jne .ciclope

		rdtsc

		sub rax, r11

		add rsp, 8
		pop rbx
		pop r13
		pop r14
		pop rbp
    	
    	ret