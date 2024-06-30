bits 16
org 0x7c00

%define ENDL 0x0D, 0x0A
%define BUFFER_SIZE 256

; Read a character into al
; mov ah, 0x00
; int 0x16

main:
	mov ax, 0
	mov ds, ax
	mov es, ax

	; Set up the stack
	mov ss, ax
	mov sp, 0x7c00

	mov di, input_buffer

	; Output a welcome message
	mov si, hello
	call systemputs

.promptloop:
	; Display the prompt ("> ")
	mov si, prompt
	call puts

.inputloop:
	; Read a character
	mov ah, 0x00
	int 0x16

	cmp al, 0x0d   	   ; newline (enter)
	je .process_input  ; If enter was pressed, echo the buffer back out and re-prompt

	mov [di], al
	inc di

	; Echo the character pressed back onto the screen
	mov ah, 0x0e
	int 0x10
	jmp .inputloop

.process_input:
	; Output a newline before hand
	mov si, newline
	call puts

	mov byte [di], 0 ; Null terminate the buffer
	mov di, input_buffer

	; Output the buffer
	mov si, input_buffer
	call puts
	jmp .promptloop

	cli
.die:
	hlt
	jmp .die


puts:
	push si
	push ax

.putsloop:
	lodsb         ; Load next character into al
	or al, al     ; Check if next character is null
	jz .putsdone  ; If zero (null), return

	mov ah, 0x0e
	int 0x10

	jmp .putsloop

.putsdone:
	pop ax
	pop si
	ret


systemputs:
	push si

	mov si, systemmsg
	call puts

	pop si
	call puts
	ret


newline: db ENDL, 0

hello: db "Hello from my OS! :)", ENDL, 0

systemmsg: db "[SYSTEM] ", 0

prompt: db ENDL, "> ", 0

input_buffer: times BUFFER_SIZE db 0


times 510 - ($ - $$) db 0
dw 0xAA55
