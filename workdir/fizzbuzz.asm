section .data
str_fizz: db "fizz"
str_buzz: db "buzz"
str_numbers: db "0123456789"
str_newline: db 10

section .text
global _start

print_fizz:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_fizz
    mov rdx, 4

    push rcx
    syscall
    pop rcx

    ret

print_buzz:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_buzz
    mov rdx, 4

    push rcx
    syscall
    pop rcx

    ret

print_number:
    ; get 100's place number
    mov rdx, 0
    mov rax, rcx
    mov rbx, 100
    div rbx
    ; save 10's place number
    push rdx
    call print_rax_number

    ; load 10's place number
    pop rax
    ; get 10's place number
    mov rdx, 0
    mov rbx, 10
    div rbx
    ; save surplus
    push rdx
    ; print 10
    call print_rax_number

    ; load surplus
    pop rax
    ; print 1
    call print_rax_number

    ret

print_rax_number:
    lea rsi, [str_numbers + rax]
    mov rax, 1
    mov rdi, 1
    mov rdx, 1

    push rcx
    syscall
    pop rcx

    ret

print_newline:
    mov rax, 1
    mov rdi, 1
    mov rsi, str_newline
    mov rdx, 1

    push rcx
    syscall
    pop rcx

    ret

check_fizz:
    mov rdx, 0
    mov rax, rcx
    mov rbx, 3
    div rbx
    cmp rdx, 0
    ret

check_buzz:
    mov rdx, 0
    mov rax, rcx
    mov rbx, 5
    div rbx
    cmp rdx, 0
    ret

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
    ret

_start:
    mov rcx, 1

    .loop:
        call check_fizz
        je .print_fizz

        call check_buzz
        je .print_buzz

        .print_default:
            call print_number
            call print_newline
            jmp .next

        .print_fizz:
            call print_fizz

            call check_buzz
            je .print_buzz

            call print_newline
            jmp .next

        .print_buzz:
            call print_buzz
            call print_newline
            jmp .next

        .next:

        inc rcx
        cmp rcx, 100
        jle .loop

    call exit
