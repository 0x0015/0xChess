%include "externs.inc"
%include "macros.inc"
%include "ffmt.inc"
%include "main.inc"
%include "chess.inc"

        section .data		; Data section, initialized variables
uci_msg: db "uci", 0
debug_msg: db "debug", 0
on_msg: db "on", 0
off_msg: db "off", 0
isready_msg: db "isready", 0
setoption_msg: db "setoption name", 0
go_msg: db "go",0
searchmoves_msg: db "searchmoves",0
ponder_msg:db "ponder",0
wtime_msg:db "wtime",0
btime_msg:db "btime",0
winc_msg:db "winc",0
binc_msg:db "binc",0
movestogo_msg:db "movestogo",0
depth_msg:db "depth",0
nodes_msg:db "nodes",0
mate_msg:db "mate",0
movetime_msg:db "movetime",0
infinite_msg:db "infinite",0
stop_msg: db "stop",0
quit_msg: db "quit",0
ucinewgame_msg: db "ucinewgame",0
position_msg: db "position", 0
ponderhit_msg: db "ponderhit",0


id_msg: db "id name 0xChess", 0xA, "id author 0x15", 0;0xA is the ASCII code for newline.
uciok_msg: db "uciok",0
readyok_msg: db "readyok", 0


        section .text           ; Code section.
;forsyth-edwards notation(fen)
global convert_to_fen:
convert_to_fen:
	ret
global convert_from_fen
convert_from_fen:;fen should be stored in rax
	mov r8b, 0;piece x pos
	mov r9b, 0;piece y pos
	mov rcx, 0;fenstring letter counter
fen_piece_placement_parse_char:
	mov rdx, [rax+rcx]
	cmp rdx, 0
	je fen_end
	cmp rdx, "p"
	je fen_bp
	cmp rdx, "n"
	je fen_bn
	cmp rdx, "b"
	je fen_bb
	cmp rdx, "r"
	je fen_br
	cmp rdx, "q"
	je fen_bq
	cmp rdx, "k"
	je fen_bk
	cmp rdx, "P"
	je fen_wp
	cmp rdx, "N"
	je fen_wn
	cmp rdx, "B"
	je fen_wb
	cmp rdx, "R"
	je fen_wr
	cmp rdx, "Q"
	je fen_wq
	cmp rdx, "K"
	je fen_wk
	cmp rdx, "/"
	je fen_pn_slash
	cmp rdx, "1"
	je fen_pn_1
	cmp rdx, "2"
	je fen_pn_2
	cmp rdx, "3"
	je fen_pn_3
	cmp rdx, "4"
	je fen_pn_4
	cmp rdx, "5"
	je fen_pn_5
	cmp rdx, "6"
	je fen_pn_6
	cmp rdx, "7"
	je fen_pn_7
	cmp rdx, "8"
	je fen_pn_8
	cmp rdx, " "
	je fen_pn_space

fen_piece_placement_parse_char_end:
	inc rcx
	jmp fen_piece_placement_parse_char
	

fen_bp:;add these.  you can compare the bitboards against 0 to check if they have a piece
fen_bn:
fen_bb:
fen_br:
fen_bq:
fen_bk:
fen_wp:
fen_wn:
fen_wb:
fen_wr:
fen_wq:
fen_wk:
fen_pn_slash:
	mov r8b, 0 
	inc r9b
	jmp fen_piece_placement_parse_char_end
fen_pn_8:
	inc r8b
fen_pn_7:
	inc r8b
fen_pn_6:
	inc r8b
fen_pn_5:
	inc r8b
fen_pn_4:
	inc r8b
fen_pn_3:
	inc r8b
fen_pn_2:
	inc r8b
fen_pn_1:
	inc r8b
	jmp fen_piece_placement_parse_char_end
jmp fen_piece_placement_parse_char_end
fen_pn_space:
	inc rcx
	;move on to piece placement end.  no jmp needed
fen_piece_placement_end:
;side to move
;castling
;en passant
;halfmove clock
;fullmove counter

fen_end:
	ret
;algebraic notation
convert_to_abn:
	ret
convert_from_abn:
	ret

        global parse_uci
parse_uci:
        ;str_print readbuf;debug message

	str_cmp readbuf, uci_msg
	je uci_uci

	str_substr readbuf, tempstr, 0, 5
	str_cmp tempstr, debug_msg
	je uci_debug
	

	str_cmp readbuf, isready_msg
	je uci_isready

	str_substr readbuf, tempstr, 0, 14
	str_cmp tempstr, setoption_msg
	je uci_setoption

	str_substr readbuf, tempstr, 0, 2
	str_cmp tempstr, go_msg
	je uci_go

	str_cmp readbuf, stop_msg
	je uci_stop

	str_cmp readbuf, quit_msg
	je uci_quit

	str_cmp readbuf, ucinewgame_msg
	je uci_ucinewgame

	str_substr readbuf, tempstr, 0, 8
	str_cmp tempstr, position_msg
	je uci_position

	str_cmp readbuf, ponderhit_msg
	je uci_ponderhit

	jmp uci_end

uci_uci:
	str_print id_msg
	str_print uciok_msg
	jmp uci_end
uci_debug:
	str_substr readbuf, tempstr, 6, 2
	str_cmp tempstr, on_msg
	je uci_debug_on

	str_substr readbuf, tempstr, 6, 3
	str_cmp tempstr, off_msg
	je uci_debug_off
uci_debug_on:
	mov al, 1
	mov [debug], al
	jmp uci_end
uci_debug_off:
	mov al, 0
	mov [debug], al
	jmp uci_end
uci_isready:
	str_print readyok_msg
	jmp uci_end
uci_setoption:
	jmp uci_end
uci_go:
	str_substr readbuf, tempstr, 3, 11
	str_cmp tempstr, searchmoves_msg
	je uci_go_searchmoves
	str_substr readbuf, tempstr, 3, 6
	str_cmp tempstr, ponder_msg
	je uci_go_ponder
	str_substr readbuf, tempstr, 3, 5
	str_cmp tempstr, wtime_msg
	je uci_go_wtime
	str_substr readbuf, tempstr, 3, 5
	str_cmp tempstr, btime_msg
	je uci_go_btime
	str_substr readbuf, tempstr, 3, 4
	str_cmp tempstr, winc_msg
	je uci_go_winc
	str_substr readbuf, tempstr, 3, 4
	str_cmp tempstr, binc_msg
	je uci_go_binc
	str_substr readbuf, tempstr, 3, 9
	str_cmp tempstr, movestogo_msg
	je uci_go_movestogo
	str_substr readbuf, tempstr, 3, 5
	str_cmp tempstr, depth_msg
	je uci_go_depth
	str_substr readbuf, tempstr, 3, 5
	str_cmp tempstr, nodes_msg
	je uci_go_nodes
	str_substr readbuf, tempstr, 3, 4
	str_cmp tempstr, mate_msg
	je uci_go_mate
	str_substr readbuf, tempstr, 3, 8
	str_cmp tempstr, movetime_msg
	je uci_go_movetime
	str_substr readbuf, tempstr, 3, 8
	str_cmp tempstr, infinite_msg
	je uci_go_infinite

	;str_print tempstr;debug messages
	call generate_moves ;just a test for now 

	jmp uci_end;if you found none of those, there is probably something wrong

uci_go_searchmoves:
uci_go_ponder:
uci_go_wtime:
uci_go_btime:
uci_go_winc:
uci_go_binc:
uci_go_movestogo:
uci_go_depth:
	str_print infinite_msg
	jmp uci_end
uci_go_nodes:
uci_go_mate:
uci_go_movetime:
uci_go_infinite:
	jmp uci_end
uci_stop:
	jmp uci_end
uci_quit:
	mov al, 1
	mov [stop], al
	jmp uci_end
uci_ucinewgame:
	jmp uci_end
uci_position:
	jmp uci_end
uci_ponderhit:
	jmp uci_end
	
uci_end:
	ret
