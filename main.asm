
; Declare needed C  functions
	%include "externs.mac"
	%include "macros.mac"

        section .data		; Data section, initialized variables
msg:	db "Hello world", 0	; C string needs 0
msg2: db "Test2!",0
readbuf: times 64 db 0

%include "ffmt.mac"

        section .text           ; Code section.

        global main		; the standard gcc entry point
main:				; the program label for the entry point
        str_print(msg)

	str_read(readbuf)

	str_print(msg2)
	str_print(readbuf)

	return(0)
