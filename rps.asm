# roshambo-dos
A simple Rock, Paper, Scissors COM DOS game.
.model small

.code

org 100h

start:

mov dx, offset msg     ; obtain message to display on screen
mov ah, 09h            ; value to output string
int 21h                ; interrupt number for DOS services

mov ah, 07h            ; value to directly read character input
int 21h
cmp al, 31h            ; the 1 key is pressed
je ROK
cmp al, 32h            ; the 2 key is pressed
je PPR
cmp al, 33h            ; the 3 key is pressed
je SSR
jmp start              ; repeat prompt if none of those keys are pressed

RAND:                  ; generates pseudo-random number

mov ah, 00h            ; get system time (cx:dx holds this value)
int 1ah

mov ax, dx             ; rearrange values to suit div instruction
xor dx, dx             ; set dx to 0
mov cx, 3
div cx                 ; divide dx:ax by 3
ret                    ; properly ends function

ROK:                   ; if rock gets picked

call RAND              ; computer "randomly" chooses its weapon
cmp dl, 0
je RKT
cmp dl, 1
je RKL
cmp dl, 2
je RKW
ret

RKT:                   ; tie between rocks
mov dx, offset trk
mov ah, 09h
int 21h
ret
RKL:                   ; rock loses
call PBEAT
call DFEAT
ret
RKW:                   ; rock wins
call RBEAT
call VCTRY
ret

PPR:                   ; if paper gets picked

call RAND
cmp dl, 0
je PRW
cmp dl, 1
je PRT
cmp dl, 2
je PRL
ret

PRT:                   ; tie between papers
mov dx, offset tpr
mov ah, 09h
int 21h
ret
PRL:                   ; paper loses
call SBEAT
call DFEAT
ret
PRW:                   ; paper wins
call PBEAT
call VCTRY
ret

SSR:                   ; if scissors get picked

call RAND
cmp dl, 0
je SRL
cmp dl, 1
je SRW
cmp dl, 2
je SRT
ret

SRT:                   ; tie between scissors
mov dx, offset tsr
mov ah, 09h
int 21h
ret
SRL:                   ; scissors lose
call RBEAT
call DFEAT
ret
SRW:                   ; scissors win
call SBEAT
call VCTRY
ret

RBEAT:                 ; rock beats scissors
mov dx, offset rxs
mov ah, 09h
int 21h
ret
SBEAT:                 ; scissors beat paper
mov dx, offset sxp
mov ah, 09h
int 21h
ret
PBEAT:                 ; paper beats rock
mov dx, offset pxr
mov ah, 09h
int 21h
ret

DFEAT:                 ; prints out the losing message
mov dx, offset los
mov ah, 09h
int 21h
ret

VCTRY:                 ; prints out the winning message
mov dx, offset win
mov ah, 09h
int 21h
ret

mov ax, 4c00h          ; terminate the program
int 21h

msg db "Rock (1), Paper (2), or Scissors (3)?", 0dh, 0ah, "$"
rxs db "Rock crushes Scissors.", 0dh, 0ah, "$"
sxp db "Scissors cuts Paper.", 0dh, 0ah, "$"
pxr db "Paper covers Rock.", 0dh, 0ah, "$"
los db "You lose...", 0dh, 0ah, "$"
win db "You win!!!", 0dh, 0ah, "$"
trk db "Tie between Rocks.", 0dh, 0ah, "$"
tpr db "Tie between Papers.", 0dh, 0ah, "$"
tsr db "Tie between Scissors.", 0dh, 0ah, "$"

end start
