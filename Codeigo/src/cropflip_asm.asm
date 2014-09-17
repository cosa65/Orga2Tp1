global cropflip_asm

section .text
;void tiles_asm(unsigned char *src,
;              unsigned char *dst,
;		int cols, rows
;              int src_row_size,
;              int dst_row_size,
;		int tamx, int tamy,
;		int offsetx, int offsety);

;%define limpUp 0x00000000FFFFFFFF

cropflip_asm:
			
			push rbp
			mov rbp, rsp

			push r12
			push r13
			push r14
			push r15
			push rbx

			;R9 tamx
			;R10 tamy
			;R11 final del archivo destino
			;R12 offsetx en BYTES
			;R13 offsety
			;R14 Principio cacho a modificar
			
			mov eax, [rbp+24]
			mov r10d, eax
			mov rbx, 8589934591
			and rax, rbx

			xor r11, r11
			mov r11d, [rbp+16]

			mul r11
			shl rax, 2
			add rax, rsi
			mov r11, rax
			mov rcx, [rbp+16]
			shl rcx, 2
			sub r11, rcx

			mov r12d, [rbp+32]
			mov r13d, [rbp+40]

			and r8, rbx
			and r12, rbx
			and r13, rbx
			mov rax, r8
			
			mul r13
			shl r12, 2
			add rax, r12
			
			mov r14, rax
			add r14, rdi

			mov edx, [rbp+16]
			mov rbx, 8589934591
			and rdx, rbx
			shl rdx, 2
			mov rbx, rdx

			mov eax, r10d

.fosconi:	movdqu xmm0, [r14]
			movdqu [r11], xmm0
			add r14, 16
			add r11, 16
			sub rbx, 16
			cmp rbx, 0
			jne .fosconi
			sub r11, r9
			sub r11, r9
			add r14, r8
			sub r14, rdx
			mov rbx, rdx
			dec eax
			cmp eax, 0
			jne .fosconi

			pop rbx
			pop r15
			pop r14
			pop r13
			pop r12
			pop rbp

    		ret
