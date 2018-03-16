section .data

message: db "Hello, World", 10

section .text

global _start

_start:

    ; set counter registry
    mov rcx, 3

.loop:
    ; dec counter
    dec rcx

    ; prepare write
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 14

    ; write
    push rcx ; save for protecting counter from overwrite by syscall
    syscall
    pop rcx ; load counter

    ; jump if counter is not zero
    test rcx, rcx
    jnz .loop

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
