%include "externs.inc"
%include "macros.inc"
%include "ffmt.inc"
%include "main.inc"

        section .data
;6bit source piece
;6bit dest piece
;4bit piece
;12 possible pieces, wp, wc, wk, wb, wq, wking, bp, bc, bk, bb, bq, bking
;2bit promotion
;0=none, 1=knight, 2=queen
;1bit en passant
;1bit takes
;10bit blank
moveposes: times 256 dd 0;technically only needs 132 max but I decided that it was better to leave extra room
moveposes_size: dd 0

%macro create_move 6
	mov eax, 0;zeroing
	mov al, %1;set source piece
	shr eax, 8-6
	shl eax, 8
	mov al, %2;set dest piece
	shr eax, 8-6
	shl eax, 8
	mov al, %3;set piece
	shr eax, 8-4
	shl eax, 8
	mov al, %4;set promotion
	shr eax, 8-2
	shl eax, 8
	mov al, %5;set en passant
	shr eax, 8-1
	shl eax, 8
	mov al, %6;set takes
	shr eax, 8-1
	
%endmacro

global generate_moves
generate_moves:
	
gm_end:
ret

