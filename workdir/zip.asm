section .data
numbers: db "0123456789", 10
strings: db "ABCDEFGHIJ", 10

section .text
global _start

print_numbers:
    mov rax, 1
    mov rdi, 1
    mov rsi, numbers ; set base address
    add rsi, rcx ; add offset
    mov rdx, 1
    push rcx
    syscall
    pop rcx
    ret

print_strings:
    mov rax, 1
    mov rdi, 1
    lea rsi, [strings + rcx] ; set relative address ( base + offset )
    mov rdx, 1
    push rcx
    syscall
    pop rcx
    ret

exit:
    mov rax, 60
    xor rdi, rdi
    syscall

_start:
    mov rcx, 0

.loop:
    call print_numbers
    call print_strings

    inc rcx
    cmp rcx, 10
    jle .loop

    call exit