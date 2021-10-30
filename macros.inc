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

		mov rdi, str_read_fmt
		mov rsi, %1
		mov rax, 0

		call scanf

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
%endif
