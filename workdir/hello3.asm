section .data

message: db "Hello, World", 10

section .text

global _start

_start:

    ; set counter registry
    mov rcx, 3

.loop:
    dec rcx

    ; prepare write
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 14

    ; write
    push rcx
    syscall
    pop rcx

    ; jump if zero
    test rcx, rcx
    jnz .loop

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
