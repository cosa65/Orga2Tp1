
global mblur_asm

section .data

section .text
;void mblur_asm    (
	;unsigned char *src,  	rdi
	;unsigned char *dst,	rsi
	;int cols,				edx
	;int filas,				ecx
	;int src_row_size,		r8d
	;int dst_row_size)		r9d

mblur_asm:
	
				push rbp
				mov rbp, rsp
				push r12
				push r13
				push r15
				push rbx
				
				and r9, 4294967295
				and r8, 4294967295
				and rcx, 4294967295
				and rdx, 4294967295

				mov r10, rdx
				mov rax, rdx
				sub rax, 2

				mov r11, r8
				add r11, r11
				add r11, r8

				mov r15, rcx
				sub r15, 2

				sub rdi, r8
				sub rdi, r8
				mov r12, rdi
				mov r13, rsi

				mov ebx, 5
				cvtsi2ss xmm15, ebx
				movd ebx, xmm15

	.riquelme:	cmp rcx, 2
				jle .zero
				cmp r10, 2
				jle .zero
				cmp rcx, r15
				jg .zero
				cmp r10, rax
				jg .zero

				pxor xmm15, xmm15
				
				movdqu xmm0, [rdi]
				movdqa xmm10, xmm0
				punpcklbw xmm0, xmm15
				movdqa xmm1, xmm0
				punpckhwd xmm1, xmm15
				punpcklwd xmm0, xmm15
				movdqu xmm2, [rdi+r8+4]
				movdqa xmm11, xmm2
				punpcklbw xmm2, xmm15
				movdqa xmm3, xmm2
				punpckhwd xmm3, xmm15
				punpcklwd xmm2, xmm15
				movdqu xmm4, [r8*2+rdi+8]
				movdqa xmm12, xmm4
				punpcklbw xmm4, xmm15
				movdqa xmm5, xmm4
				punpckhwd xmm5, xmm15
				punpcklwd xmm4, xmm15
				movdqu xmm6, [rdi+r11+12]
				movdqa xmm13, xmm6
				punpcklbw xmm6, xmm15
				movdqa xmm7, xmm6
				punpckhwd xmm7, xmm15
				punpcklwd xmm6, xmm15
				movdqu xmm8, [r8*4+rdi+16]
				movdqa xmm14, xmm8
				punpcklbw xmm8, xmm15
				movdqa xmm9, xmm8
				punpckhwd xmm9, xmm15
				punpcklwd xmm8, xmm15

				paddd xmm0, xmm2
				paddd xmm0, xmm4
				paddd xmm0, xmm6
				paddd xmm0, xmm8

				paddd xmm1, xmm3
				paddd xmm1, xmm5
				paddd xmm1, xmm7
				paddd xmm1, xmm9

				cvtdq2ps xmm0, xmm0
				cvtdq2ps xmm1, xmm1

				movd xmm15, ebx
				shufps xmm15, xmm15, 00000000

				divps xmm0, xmm15
				divps xmm1, xmm15

				cvttps2dq xmm0, xmm0
				cvttps2dq xmm1, xmm1
				
				packusdw xmm0, xmm1

				pxor xmm15, xmm15

				punpckhbw xmm10, xmm15
				movdqa xmm9, xmm10
				punpckhwd xmm10, xmm15
				punpcklwd xmm9, xmm15

				punpckhbw xmm11, xmm15
				movdqa xmm8, xmm11
				punpckhwd xmm11, xmm15
				punpcklwd xmm8, xmm15
				
				punpckhbw xmm12, xmm15
				movdqa xmm7, xmm12
				punpckhwd xmm12, xmm15
				punpcklwd xmm7, xmm15
				
				punpckhbw xmm13, xmm15
				movdqa xmm6, xmm13
				punpckhwd xmm13, xmm15
				punpcklwd xmm6, xmm15
				
				punpckhbw xmm14, xmm15
				movdqa xmm5, xmm14
				punpckhwd xmm14, xmm15
				punpcklwd xmm5, xmm15

				paddd xmm10, xmm11
				paddd xmm10, xmm12
				paddd xmm10, xmm13
				paddd xmm10, xmm14

				paddd xmm9, xmm8
				paddd xmm9, xmm7
				paddd xmm9, xmm6
				paddd xmm9, xmm5

				cvtdq2ps xmm10, xmm10
				cvtdq2ps xmm9, xmm9

				movd xmm15, ebx
				shufps xmm15, xmm15, 00000000

				divps xmm10, xmm15
				divps xmm9, xmm15

				cvttps2dq xmm10, xmm10
				cvttps2dq xmm9, xmm9

				packusdw xmm9, xmm10
				
				packuswb xmm0, xmm9

				movdqu [rsi], xmm0
			
				add rsi, 16
				add rdi, 16
				sub r10, 4
				jmp .riquelme

.zero:			mov qword[rsi], 0xF0000000F000000
				add rsi, 8 
				sub r10, 2
				cmp r10, 0
				jne .riquelme
				mov r10, rdx
				add r13, r9
				mov rsi, r13
				add r12, r8
				mov rdi, r12
				dec rcx
				cmp rcx, 0
				jne .riquelme

				pop rbx
				pop r15
				pop r13
				pop r12
				pop rbp

			    ret