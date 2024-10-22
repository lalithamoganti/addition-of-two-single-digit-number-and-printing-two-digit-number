ORG 100h

; Prompt for first digit (without newline)
mov ah, 09h             ; DOS interrupt to display a string
lea dx, msg1            ; Load address of the first message
int 21h                 ; Display the message

; Read first digit from the user
mov ah, 01h             ; DOS interrupt to read a character ---->al
int 21h                 ; Read first digit
sub al, '0'             ; Convert ASCII to integer
mov bl, al              ; Store first number in BL

; Prompt for second digit (without newline)
mov ah, 09h             ; DOS interrupt to display a string
lea dx, msg2            ; Load address of the second message
int 21h                 ; Display the message

; Read second digit from the user
mov ah, 01h             ; DOS interrupt to read a character
int 21h                 ; Read second digit
sub al, '0'             ; Convert ASCII to integer
add bl, al              ; Add second number to BL (BL now holds the sum)

; Check if the sum is greater than 9 (two-digit number)
cmp bl, 9
jg two_digits           ; If sum > 9, jump to handle two-digit result

mov ah, 09h             ; DOS interrupt to display a string
lea dx, msg3            ; Load address of the sum message
int 21h                 ; Display the sum message

; Print single-digit sum
add bl, '0'             ; Convert to ASCII
mov dl, bl              ; Move sum to DL for printing
mov ah, 02h             ; DOS interrupt to print a character
int 21h                 ; Print the result
jmp done                ; Jump to the end of the program

two_digits:
; Handle two-digit result (sum >= 10)
mov ah, 09h             ; DOS interrupt to display a string
lea dx, msg3            ; Load address of the sum message
int 21h                 ; Display the sum message

mov al, bl              ; Move sum to AL
mov ah, 0
mov dl, 10
div dl                  ; AL = quotient (tens), AH = remainder (ones)

; Print tens digit
add al, '0'             ; Convert to ASCII
mov dl, al 
mov bh, ah              ; Move tens to DL
mov ah, 02h             ; DOS interrupt to print a character
int 21h                 ; Print tens digit

; Print ones digit
mov ah,bh
mov al, ah              ; Move ones to AL
add al, '0'             ; Convert to ASCII
mov dl, al              ; Move ones to DL
mov ah, 02h             ; DOS interrupt to print a character
int 21h                 ; Print ones digit

done:
; Exit program
mov ah, 4Ch             ; DOS interrupt to exit the program
int 21h

msg1 db 'Enter first digit: $'  ; Message without newline
msg2 db 'Enter second digit: $' ; Message without newline
msg3 db 0Dh, 0Ah, 'The sum is: $' ; Message with newline
