
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

				;Aca se limpia la parte alta
				;de los parametros de entrada
				
				and r9, 4294967295
				and r8, 4294967295
				and rcx, 4294967295
				and rdx, 4294967295

				;Primero se preparan registros
				;necesarios para loopear y ver
				;si el puntero de escritura
				;esta en algun borde

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
				cvtsi2ss xmm3, ebx
				shufps xmm3, xmm3, 00000000

				pxor xmm15, xmm15

				;Al principio del ciclo se checkea si el
				;puntero de escritura apunta a algun borde.
				;Si es asi se salta para escribir pixeles
				;negros, sino se procede al procesamiento

	.riquelme:	cmp rcx, 2
				jle .zero1
				cmp rcx, r15
				jg .zero1
				cmp r10, 2
				jle .zero2
				cmp r10, rax
				jg .zero2

				;Primero se cargan de memoria 20 pixeles
				;para poder procesar 4. Se desempaquetan
				;a words los 2 pixeles mas bajos para poder
				;sumar sin que se genere overflow. Tambien
				;se hace una copia de los 4 pixeles para 
				;luego desempaquetar los 2 mas altos
				
				movdqu xmm0, [rdi]
				movdqa xmm10, xmm0
				punpcklbw xmm0, xmm15
				
				movdqu xmm2, [rdi+r8+4]
				movdqa xmm11, xmm2
				punpcklbw xmm2, xmm15
				
				movdqu xmm4, [r8*2+rdi+8]
				movdqa xmm12, xmm4
				punpcklbw xmm4, xmm15
				
				movdqu xmm6, [rdi+r11+12]
				movdqa xmm13, xmm6
				punpcklbw xmm6, xmm15
				
				movdqu xmm8, [r8*4+rdi+16]
				movdqa xmm14, xmm8
				punpcklbw xmm8, xmm15

				;Aca se suman 2 pixeles y luego
				;se desempaquetan y se convierten
				;a floats para dividirlos por 5
				;Por ultimo se empaquetan a words
				;nuevamente

				paddw xmm0, xmm2
				paddw xmm0, xmm4
				paddw xmm0, xmm6
				paddw xmm0, xmm8

				movdqa xmm1, xmm0
				punpckhwd xmm1, xmm15
				punpcklwd xmm0, xmm15

				cvtdq2ps xmm0, xmm0
				cvtdq2ps xmm1, xmm1

				divps xmm0, xmm3
				divps xmm1, xmm3

				cvttps2dq xmm0, xmm0
				cvttps2dq xmm1, xmm1
				
				packusdw xmm0, xmm1

				;Aca se procesan de igual forma
				;los 2 pixeles altos de los 4
				;traidos de la memoria

				punpckhbw xmm10, xmm15
				punpckhbw xmm11, xmm15
				punpckhbw xmm12, xmm15
				punpckhbw xmm13, xmm15
				punpckhbw xmm14, xmm15

				paddw xmm10, xmm11
				paddw xmm10, xmm12
				paddw xmm10, xmm13
				paddw xmm10, xmm14
 	
				movdqa xmm9, xmm10
				punpckhwd xmm10, xmm15
				punpcklwd xmm9, xmm15

				cvtdq2ps xmm10, xmm10
				cvtdq2ps xmm9, xmm9

				divps xmm10, xmm3
				divps xmm9, xmm3

				cvttps2dq xmm10, xmm10
				cvttps2dq xmm9, xmm9

				packusdw xmm9, xmm10

				;Se empaquetan los 4 pixeles a bytes
				;y se cargan a memoria
				
				packuswb xmm0, xmm9

				movdqu [rsi], xmm0
			
				add rsi, 16
				add rdi, 16
				sub r10, 4
				jmp .riquelme

.zero1:			mov qword[rsi], 0xF0000000F000000
				add rsi, 8 
				sub r10, 2
.zero2:			mov qword[rsi], 0xF0000000F000000
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