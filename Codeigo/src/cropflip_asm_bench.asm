global cropflip_asm

section .data

section .text
;void tiles_asm(unsigned char *src,
;              unsigned char *dst,
;		int cols, rows
;              int src_row_size,
;              int dst_row_size,
;		int tamx, int tamy,
;		int offsetx, int offsety);

cropflip_asm:
			
			push rbp
			mov rbp, rsp

			push r12
			push r13
			push r14
			push r15
			push rbx
			sub rsp, 8

			xor rax, rax

			rdtsc

			mov rdx, rax

			;la pila queda desalineada, pero como no
			;llamo a ninguna funcion esta todo bien (creo)

			;Los parametros que te pasan por
			;la pila se acceden asi:
			;mov r64/r32/r16/r8, [rbp+8+i*8]
			;siendo i el numero de parametro (empieza en 1)


			;El primer parrafo de codigo modifica el puntero
			;de la imagen destino para que apunte a donde
			;hay que empezar a escribir, queda en R11:

			mov ecx, [rbp+16]
			mov eax, [rbp+24]
			mov rbx, 4294967295		;Ahora en cada and con rbx
			and rax, rbx			;se va a limpiar la parte alta
			xor r11, r11 			;del registro, es necesario
			mov r11d, ecx		;para hacer aritmetica de punteros
			mul r11
			shl rax, 2
			add rax, rsi
			mov r11, rax
			mov r10d, ecx
			shl r10d, 2
			and r10, rbx
			sub r11, r10

			;Este parrafo modifica el puntero de
			;la imagen fuente para que apunte a donde
			;hay que empezar a leer, queda en R14:

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

			;Ahora se setean 3 contadores,
			;Uno de bytes horizontales en RBX,
			;uno de pixeles verticales en EAX
			;y un backup del primero en R15
			

			mov r15d, ecx
			and r15, rbx
			shl r15, 2
			mov rbx, r15 		;RBX pierde su funcion de and
			mov eax, [rbp+24]

			;Aca se procesa la imagen:
			;En cada iteracion se copian 16 bytes de
			;una fila y se decrementa el contador RBX.
			;Cuando este llega a 0 se restaura usando
			;el backup y los punteros se actualizan
			;para que apunten al primer elemento de
			;la fila siguiente. Se decrementa el
			;contador EAX, si llego a 0 significa que
			;ya se copiaron todas las filas, y el
			;programa para. Sino se loopea y se
			;prosigue a copiar la fila siguiente.
			;Notar que una imagen va leyendo las
			;filas de arriba para abajo y la otra las
			;va escribiendo de abajo para arriba.
			;Ambos leen la fila de izquierda a derecha

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
			sub r14, r15
			mov rbx, r15
			dec eax
			cmp eax, 0
			jne .fosconi

			mov r14, rdx

			rdtsc

			sub rax, r14

			add rsp, 8
			pop rbx
			pop r15
			pop r14
			pop r13
			pop r12
			pop rbp

    		ret
