!cpu 6502
!to "build/hello.prg",cbm
* = $0801                               ; BASIC starts at #2049
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC to load $c000
!byte $31,$35,$32,$00,$00,$00           ; inserts BASIC line: 2012 SYS 49152
* = $c000     				            ; start address for 6502 code

JSR $E544
loop jsr init_text      ; write line of text
jmp loop				; infinite loop

message   !scr "              hello world!              "	;40 cols of text

init_text  ldx #$00         ; init X-Register with $00
loop_text  lda message,x    ; read characters from message text...
           sta $0590,x      ; ...and place it into screen screen memory
           inx 				; increment to next character
           cpx #$28         ; false if != 40
           bne loop_text    ; loop if false
           rts
