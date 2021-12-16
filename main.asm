%include "externs.inc"
%include "macros.inc"
%include "uci.inc"
%include "chess.inc"

        section .data		; Data section, initialized variables
global str_print_fmt
str_print_fmt:    db "%s", 10, 0          ; The printf format, "\n",'0'
global str_read_fmt
str_read_fmt: db "%2047[^",10,"]", 0; scanf format
str_readNL_fmt: db "%s", 10, 0

global readbuf
readbuf: times 2048 db 0
global tempstr
tempstr: times 2048 db 0
global stop
stop: db 0
global debug
debug: db 0
global boardstate
;boardstate ordering:
;first black than white, 8 pawns, 2 rooks, 2 knights, 2 bishops, queen, king
boardstate: times 32 dq 0

        section .text           ; Code section.

global main
main:

setup:
	call reset_board
main_loop:

	str_read readbuf

	call parse_uci

	mov al, [stop]
	mov cl, 0
	cmp al, cl
	je main_loop

end:
	return 0
