%macro print_string 2
mov rax, 1
mov rdi, 1
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .data

hello: db 'Hello, World', 10
hi: db 'Hi, World', 10

section .text
global _start

_start:

%assign i 0

%rep 10
    %if i % 2 = 0
        print_string hi, 11
    %else
        print_string hello, 14
    %endif

    %assign i i + 1
%endrep

mov rax, 60
xor rdi, rdi
syscall
