section .data
extern gettimeofday
section .text
global millis
millis:;finally replaced the single c file I had to call this function
	;to facilitate calling the c function, set up the stack
	push rbp
	mov rbp, rsp
	sub rsp, 16
	lea rdi, [rbp-16]

	mov eax, 0
	mov esi, 0
	call gettimeofday
	mov rax, [rbp-8]
	imul rcx, [rbp-16], 1000000
	add rax, rcx
	mov ecx, 1000
	cqo
	idiv rcx
	;reset the stack to how it was before
	add rsp, 16
	pop rbp
	ret
	
