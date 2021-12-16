%include "externs.inc"
%include "macros.inc"
%include "ffmt.inc"
%include "main.inc"
%include "uci.inc"

        section .data
starting_fen: db "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1",0
;6 bytes used out of 8 bytes in a 64 bit register
;1byte source piece
;1byte dest piece
;1byte piece.  12 possible pieces, wp, wc, wk, wb, wq, wking, bp, bc, bk, bb, bq, bking
;1byte promotion.  0=none, 1=knight, 2=queen
;1byte en passant
;1byte takes

;bsr  bit scan reverse gives index of first leading 1(rather than 0)
moveposes: times 256 dq 0;technically only needs 132 max but I decided that it was better to leave extra room
moveposes_size: dd 0
global bestmove
bestmove: dq 0

;general code map
;
;for general depth
;
;calculate moves for current boardstate, push to stack
;for each of those:
;	incriment current search depth
;	check how good the boardstate is, and if it's the best take note of it
;	if the current seach depth < max search depth:
;		calculate moves for current boardstate, recurse....(I hope I can figure out how to do this)
;	decriment current search depth

	section .text
global reset_board
reset_board:
	mov rax, starting_fen
	call convert_from_fen
	ret


global generate_moves
generate_moves:
	mov rcx, 0
gm_sub_1:;loop for going through the different pieces in the bitboard
	mov rdi, [boardstate + rcx]
	cmp rdi, 0
	je gm_next_piece;if any bitboard is empty, just go on to the next piece

	;find piece pos.  x will be stored in r8b, and y in r9b.  both start in 0 at the bottom left corner.
	bsr rax, rdi
	mov rdx, 0;required or you get an error(?)
	mov r11, 8
	div r11;eight pieces per row.
	mov r9b, al;bottom 8 bytes of rax
	mov r8b, dl;bottom 8 bytes of rdx
	
	jmp gm_found_piece
gm_next_piece:
	inc rcx
	cmp rcx, 32;if you have gone through all the moves, end.
	jge generate_moves_end
	jmp gm_sub_1

generate_moves_end:
	ret;replace after figuring out the whole stack thing


gm_found_piece:;when this is called, rax should be the result of the bsr
	cmp rcx, 7
	jle gm_board_le7
	cmp rcx, 9
	jle gm_board_le9
	cmp rcx, 11
	jle gm_board_le11
	cmp rcx, 13
	jle gm_board_le13
	cmp rcx, 14
	jle gm_board_le14
	cmp rcx, 15
	jle gm_board_le15
	cmp rcx, 23
	jle gm_board_le23
	cmp rcx, 25
	jle gm_board_le25
	cmp rcx, 27
	jle gm_board_le27
	cmp rcx, 29
	jle gm_board_le29
	cmp rcx, 30
	jle gm_board_le30
	cmp rcx, 31
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
	jmp gm_next_piece
