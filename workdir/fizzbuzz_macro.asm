; @param: %1 -> string address
; @param: %2 -> string length
%macro print_string 2
mov rax, 1
mov rdi, 1
mov rsi, %1
mov rdx, %2
push rcx
syscall
pop rcx
%endmacro

; @before: rax -> number
%macro print_rax_number 0
lea rsi, [numbers + rax]
mov rax, 1
mov rdi, 1
mov rdx, 1
push rcx
syscall
pop rcx
%endmacro

; @param: %1 -> decimal digit
; @before: rcx -> number
; @after:  stack -> lower digit number
%macro print_number 1
mov rdx, 0
mov rax, rcx
mov rbx, %1
div rbx
push rdx
print_rax_number
%endmacro

%macro print_number_100 0
print_number 100
pop rax
print_number 10
pop rax
print_rax_number
%endmacro

section .data
fizz: db "fizz"
buzz: db "buzz"
numbers: db "0123456789"
newline: db 10

section .text
global _start

_start:

%assign i 1

%rep 100

    %if i % 15 = 0

        print_string fizz, 4
        print_string buzz, 4
        print_string newline, 1

    %elif i % 3 = 0

        print_string fizz, 4
        print_string newline, 1

    %elif i % 5 = 0

        print_string buzz, 4
        print_string newline, 1

    %else

        mov rcx, i
        print_number_100
        print_string newline, 1

    %endif

    %assign i i + 1
%endrep

mov rax, 60
xor rdi, rdi
syscall