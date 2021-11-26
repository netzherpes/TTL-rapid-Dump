; Target assembler: cc65 v2.18.0 [--target none -C dump.bin_cc65.cfg]
;***************************************
;*        KIM rapid DUMP / LOAD        *
;* *********************************** *
;***************************************
;*     (c) 1980                        *
;*     Bruce Nazarian                  *
;*     1007 Wright Street #3           *
;*     Ann Arbor, MI 48105             *
;***************************************
         .setcpu "6502"
CLEAR    =       $1c64
PRTPNT   =       $1e1e
CRLF     =       $1e2f
PRTBYT   =       $1e3b
GETCH    =       $1e5a
OUTSP    =       $1e9e
OUTCH    =       $1ea0
INCPT    =       $1f63
GETKEY   =       $1f6a
PACK     =       $1fac
DATA     =       $1fcc

         .org    $0100
ENTER:   cld
         lda     #$00
         sta     $f8
         sta     $f9
         jsr     CRLF
ADDR:    jsr     GETCH
         cmp     #$20
         beq     ISDATA
         jsr     PACK
         beq     ADDR
ISDATA:  jsr     DATA
         jsr     CRLF
INPUT:   jsr     GETCH
         cmp     #$4c
         beq     LOAD
         cmp     #$51
         bne     INPUT
DUMP:    lda     #$0f
         sta     COUNT
         jsr     CRLF
         jsr     PRTPNT
         jsr     OUTSP
GET:     jsr     OUTSP
         ldy     #$00
         lda     ($fa),y
         jsr     PRTBYT
         jsr     INCPT
         dec     COUNT
         bpl     GET
         jsr     GETKEY
         cmp     #$15
         beq     DUMP
         jmp     CLEAR

LOAD:    jsr     CRLF
READ:    jsr     GETCH
         cmp     #$0d
         beq     LOAD
         cmp     #$1b
         bne     STORE
         jsr     STRING
         jmp     CLEAR

STORE:   jsr     PACK
         bne     READ
         jsr     GETCH
         jsr     PACK
         ldy     #$00
         lda     $f8
         sta     ($fa),y
         jsr     INCPT
         clc
         bcc     READ

         .byte   $ea
         .byte   $ea
         .byte   $ea
COUNT:   .byte   $00

STRING:  ldx     #$0c
STRING2: lda     TABLE,x
         jsr     OUTCH
         dex
         bpl     STRING2
         rts

         .byte   $ea
         .byte   $ea
         .byte   $ea
         .byte   $00
TABLE:   .byte   " ? MIK ?"
         .byte   $00
         .byte   $00
         .byte   $0a
         .byte   $0d
