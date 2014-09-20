
global mblur_asm

section .data

cerodos: dd 0.2, 0.2, 0.2, 0.2
cinco: dd 5.0, 5.0, 5.0, 5.0


section .text
;void mblur_asm    (
	;unsigned char *src,  	rdi
	;unsigned char *dst,	rsi
	;int filas,				edx
	;int cols,				ecx
	;int src_row_size,		r8d
	;int dst_row_size)		r9d

mblur_asm:
	
				push rbp
				mov rbp, rsp
				push r12
				push r13
				push r14
				push r15
				
				and r9, 8589934591
				and r8, 8589934591
				and rcx, 8589934591
				and rdx, 8589934591

				add rsi, r9 
				add rsi, r9 
				add rsi, 8

				mov r10, rcx
				sub r10, 4

				mov r11, r8
				add r11, r11
				add r11, r8

				sub rdx, 4

				mov r12, rdi
				mov r13, rsi
				mov r14, r10

				pxor xmm15, xmm15
				;movq xmm14, 0x3E4CCCCD3E4CCCCD muy turbio
				
				;movdqu xmm11, [cinco]
				mov r15d, 5
				cvtsi2ss xmm11, r15d
				shufps xmm11, xmm11, 00000000


	.riquelme:	movdqu xmm0, [rdi]
				punpcklbw xmm0, xmm15
				movdqa xmm1, xmm0
				punpckhwd xmm1, xmm15
				punpcklwd xmm0, xmm15
				movdqu xmm2, [rdi+r8+4]
				punpcklbw xmm2, xmm15
				movdqa xmm3, xmm2
				punpckhwd xmm3, xmm15
				punpcklwd xmm2, xmm15
				movdqu xmm4, [r8*2+rdi+8]
				punpcklbw xmm4, xmm15
				movdqa xmm5, xmm4
				punpckhwd xmm5, xmm15
				punpcklwd xmm4, xmm15
				movdqu xmm6, [rdi+r11+12]
				punpcklbw xmm6, xmm15
				movdqa xmm7, xmm6
				punpckhwd xmm7, xmm15
				punpcklwd xmm6, xmm15
				movdqu xmm8, [r8*4+rdi+16]
				punpcklbw xmm8, xmm15
				movdqa xmm9, xmm8
				punpckhwd xmm9, xmm15
				punpcklwd xmm8, xmm15

				cvtdq2ps xmm0, xmm0
				cvtdq2ps xmm1, xmm1
				cvtdq2ps xmm2, xmm2
				cvtdq2ps xmm3, xmm3
				cvtdq2ps xmm4, xmm4
				cvtdq2ps xmm5, xmm5
				cvtdq2ps xmm6, xmm6
				cvtdq2ps xmm7, xmm7
				cvtdq2ps xmm8, xmm8
				cvtdq2ps xmm9, xmm9

				;mulps xmm0, xmm11
				;mulps xmm1, xmm11
				;mulps xmm2, xmm11
				;mulps xmm3, xmm11
				;mulps xmm4, xmm11
				;mulps xmm5, xmm11
				;mulps xmm6, xmm11
				;mulps xmm7, xmm11
				;mulps xmm8, xmm11
				;mulps xmm9, xmm11

				addps xmm0, xmm2
				addps xmm0, xmm4
				addps xmm0, xmm6
				addps xmm0, xmm8

				addps xmm1, xmm3
				addps xmm1, xmm5
				addps xmm1, xmm7
				addps xmm1, xmm9

				divps xmm0, xmm11
				divps xmm1, xmm11

				cvttps2dq xmm0, xmm0
				cvttps2dq xmm1, xmm1
				
				packusdw xmm0, xmm1
				packuswb xmm0, xmm15

				movq [rsi], xmm0

				add rsi, 8
				add rdi, 8
				sub r10, 2
				cmp r10, 0
				jne .riquelme
				mov r10, r14
				add r12, r8
				add r13, r9
				mov rdi, r12
				mov rsi, r13
				dec rdx
				cmp rdx, 0
				jne .riquelme
				pop r15
				pop r14
				pop r13
				pop r12
				pop rbp

			    ret