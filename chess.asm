%include "externs.inc"
%include "macros.inc"
%include "ffmt.inc"
%include "main.inc"

        section .data
;111111 111111 1111 11 1 1 0000000000
;1byte source piece
;1byte dest piece
;1byte piece
;12 possible pieces, wp, wc, wk, wb, wq, wking, bp, bc, bk, bb, bq, bking
;1byte promotion
;0=none, 1=knight, 2=queen
;1byte en passant
;1byte takes
moveposes: times 256 dq 0;technically only needs 132 max but I decided that it was better to leave extra room
moveposes_size: dd 0
global bestmove
bestmove: dq 0


global generate_moves
generate_moves:
	mov rcx, 0
gm_sub_1:
	mov al, [boardstate + rcx]
	mov rsi, 0
gm_sub_2:
	add rsi, 8
	;1 is 00000001
	mov dl, 1
gm_loop2:
	cmp al, dl
	je gm_found_piece
	dec rsi
	mov rdi, 0
	cmp rsi, rdi
	je gm_sub_1_end
	shr al, 1
	jmp gm_loop2
gm_sub_1_end:
	inc rcx
	mov rdi, 32
	cmp rcx, rdi
	je gm_found_piece_end
	jmp gm_sub_1

gm_found_piece:
	mov rdi, 7
	cmp rdi, rcx
	jle gm_board_le7
	mov rdi, 9
	cmp rdi, rcx
	jle gm_board_le9
	mov rdi, 11
	cmp rdi, rcx
	jle gm_board_le11
	mov rdi, 13
	cmp rdi, rcx
	jle gm_board_le13
	mov rdi, 14
	cmp rdi, rcx
	jle gm_board_le14
	mov rdi, 15
	cmp rdi, rcx
	jle gm_board_le15
	mov rdi, 23
	cmp rdi, rcx
	jle gm_board_le23
	mov rdi, 25
	cmp rdi, rcx
	jle gm_board_le25
	mov rdi, 27
	cmp rdi, rcx
	jle gm_board_le27
	mov rdi, 29
	cmp rdi, rcx
	jle gm_board_le29
	mov rdi, 30
	cmp rdi, rcx
	jle gm_board_le30
	mov rdi, 31
	cmp rdi, rcx
	jle gm_board_le31

gm_board_le7:;b pawn
	
	jmp gm_found_piece_end
gm_board_le9:;b rook
	
	jmp gm_found_piece_end
gm_board_le11:;b knight
	
	jmp gm_found_piece_end
gm_board_le13:;b bushop
	
	jmp gm_found_piece_end
gm_board_le14:;b queen
	
	jmp gm_found_piece_end
gm_board_le15:;b king
	
	jmp gm_found_piece_end
gm_board_le23:;w pawn
	
	jmp gm_found_piece_end
gm_board_le25:;w rook
	
	jmp gm_found_piece_end
gm_board_le27:;w knight
	
	jmp gm_found_piece_end
gm_board_le29:;w bushop
	
	jmp gm_found_piece_end
gm_board_le30:;w queen
	
	jmp gm_found_piece_end
gm_board_le31:;w king
	
	jmp gm_found_piece_end
	
gm_found_piece_end:
	

gm_end:
ret

