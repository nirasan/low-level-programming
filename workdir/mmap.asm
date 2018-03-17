
%define O_READONLY 0
%define PROT_READ 0x1
%define MAP_PRIVATE 0x2

section .data
fname: db 'test.txt', 0

section .text
global _start

; print string
; @before: rdi -> string start address
print_string:
    push rdi
    call string_length
    pop rsi
    mov rdx, rax
    mov rax, 1
    mov rdi, 1
    syscall
    ret

; count string length
; @before: rdi -> string start address
; @after:  rax -> string length
string_length:
    xor rax, rax
.loop:
    cmp byte [rdi+rax], 0
    je .end
    inc rax
    jmp .loop
.end:
    ret

_start:

; call open
mov rax, 2
mov rdi, fname
mov rsi, O_READONLY
mov rdx, 0
syscall

; save opened file descriptor
mov r8, rax

; call mmap
mov rax, 9
mov rdi, 0
mov rsi, 4096
mov rdx, PROT_READ
mov r10, MAP_PRIVATE
mov r9, 0
syscall

; set memory address to rdi
mov rdi, rax
call print_string

; exit
mov rax, 60
xor rdi, rdi
syscall