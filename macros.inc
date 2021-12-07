%ifndef MACROS_INC 
	%define MACROS_INC
	
	%macro str_print 1
	    	push rbp
	
		mov rdi, str_print_fmt
		mov rsi, %1
		mov rax, 0
		
		call printf
		
		pop rbp
	%endmacro

	%macro str_read 1
		push rbp

		mov rdi, %1
		mov rsi, 0
		mov rax, 0

		call gets;so unsafe that I get yelled at for doing it in assembly

		pop rbp

	%endmacro

	%macro str_cmp 2
		push rbp

		mov rdi, %1
		mov rsi, %2
		mov rax, 0

		call strcmp

		pop rbp
	%endmacro

	%macro str_stoi 1
		push rbp

		mov rdi, %1
		mov rax, 0

		call stoi

		pop rbp
		%endmacro
	
	%macro str_substr 4;base string, write to substring, position, length
		mov rax, %3;rax= position
		mov rdx, 0
		%%loop:
		mov cl, [%1+rax+rdx]
		mov [%2+rdx], cl
		inc rdx
		cmp rdx, %4
		jl %%loop
		mov cl, 0
		mov [%2+rdx], cl

	%endmacro

	%macro str_strlen 1
		mov rdi, 0
		%%loop:
		mov cl, [%1+rax]
		cmp cl, 0
		jne %%loop
		mov rax, rdi
	%endmacro

	%macro str_cat 2
		push rbp

		mov rdi, %1
		mov rsi, %2
		mov rax, 0

		call strcat

		pop rbp
	%endmacro

	%macro return 1
		mov rax,0
		ret
	%endmacro

	%macro millis 0
		push rbp

		call millis

		pop rbp
	%endmacro
%endif
