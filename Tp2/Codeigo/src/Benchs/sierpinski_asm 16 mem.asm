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
			push r13
			push r12

			and r9, 4294967295
			and r8, 4294967295
			and rcx, 4294967295
			and rdx, 4294967295

			pxor xmm15, xmm15
			pxor xmm14, xmm14
			mov r10d, 255
			cvtsi2ss xmm13, r10d
			shufps xmm13, xmm13, 00000000
			movdqa xmm12, xmm13
			movdqa xmm11, xmm13
			cvtsi2ss xmm10, edx
			shufps xmm10, xmm10, 00000000
			cvtsi2ss xmm9, ecx
			shufps xmm9, xmm9, 00000000
			divps xmm12, xmm10
			divps xmm11, xmm9
			mov r10d, 1
			cvtsi2ss xmm10, r10d
			shufps xmm10, xmm10, 00000000
			pxor xmm4, xmm4
			mov r10, rdx
			mov r11, rdi
			mov rax, rsi
			;xmm15 fila
			;xmm14 columna
			;xmm13 255 x4 
			;xmm12 255/cols x4 
			;xmm11 255/fils x4
			;xmm10 1 x4 
.cicloni:	movdqu xmm0, [r11]
			movdqa xmm1, xmm0
			movdqa xmm2, xmm0
			movdqa xmm3, xmm0
			
			punpcklbw xmm0, xmm4
			punpcklwd xmm0, xmm4
			punpcklbw xmm1, xmm4
			punpckhwd xmm1, xmm4
			punpckhbw xmm2, xmm4
			punpcklwd xmm2, xmm4
			punpckhbw xmm3, xmm4
			punpckhwd xmm3, xmm4
			cvtdq2ps xmm0, xmm0
			cvtdq2ps xmm1, xmm1
			cvtdq2ps xmm2, xmm2
			cvtdq2ps xmm3, xmm3
			
			movdqa xmm8, xmm15
			movdqa xmm7, xmm14
			mulps xmm8, xmm11
			mulps xmm7, xmm12
			cvttps2dq xmm7, xmm7
			cvttps2dq xmm8, xmm8
			pxor xmm8, xmm7
			cvtdq2ps xmm8, xmm8
			divps xmm8, xmm13
			mulps xmm0, xmm8

			addps xmm14, xmm10

			movdqa xmm8, xmm15
			movdqa xmm7, xmm14
			mulps xmm8, xmm11
			mulps xmm7, xmm12
			cvttps2dq xmm7, xmm7
			cvttps2dq xmm8, xmm8
			pxor xmm8, xmm7
			cvtdq2ps xmm8, xmm8
			divps xmm8, xmm13
			mulps xmm1, xmm8

			addps xmm14, xmm10

			movdqa xmm8, xmm15
			movdqa xmm7, xmm14
			mulps xmm8, xmm11
			mulps xmm7, xmm12
			cvttps2dq xmm7, xmm7
			cvttps2dq xmm8, xmm8
			pxor xmm8, xmm7
			cvtdq2ps xmm8, xmm8
			divps xmm8, xmm13
			mulps xmm2, xmm8

			addps xmm14, xmm10

			movdqa xmm8, xmm15
			movdqa xmm7, xmm14
			mulps xmm8, xmm11
			mulps xmm7, xmm12
			cvttps2dq xmm7, xmm7
			cvttps2dq xmm8, xmm8
			pxor xmm8, xmm7
			cvtdq2ps xmm8, xmm8
			divps xmm8, xmm13
			mulps xmm3, xmm8

			addps xmm14, xmm10

			cvttps2dq xmm0, xmm0
			cvttps2dq xmm1, xmm1
			cvttps2dq xmm2, xmm2
			cvttps2dq xmm3, xmm3

			packusdw xmm0, xmm1
			packusdw xmm2, xmm3
			packuswb xmm0, xmm2

			mov [rax], r12
			mov qword[rax], 111
			mov r13, [r11]
			mov r12, [rax]
			mov [rax], r12
			mov qword[rax], 111
			mov r13, [r11]
			mov r12, [rax]
			mov [rax], r12
			mov qword[rax], 111
			mov r13, [r11]
			mov r12, [rax]
			mov [rax], r12
			mov qword[rax], 111
			mov r13, [r11]
			mov r12, [rax]

			movdqu [rax], xmm0

			sub r10, 4
			add rax, 16
			add r11, 16
			cmp r10, 0
			jne .cicloni
			add rsi, r9
			mov rax, rsi
			add rdi, r8
			mov r11, rdi
			mov r10, rdx
			pxor xmm14, xmm14
			addps xmm15, xmm10
			dec rcx
			cmp rcx, 0
			jne .cicloni

			pop r12
			pop r13
			pop rbp
    		ret
