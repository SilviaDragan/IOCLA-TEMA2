%include "io.mac"

section .text
    global my_strstr
    extern printf


section .data
    contor1 dd 0
    contor2 dd 0
    temp dd 0
    needle_len dd 0
    haystack_len dd 0
    result db 0
    string1 db "start", 0
    string2 db "t_string", 0
    string3 db "t_sub", 0
    string4 db "found", 0

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY
    ;; TO DO: Implement my_strstr
    push eax
    mov eax, 0
    mov [haystack_len], ecx
    mov [needle_len], edx
    mov edx, -1
start:
    mov [contor1], eax
    mov al, byte [contor1]

    push ebx
    mov ebx, [haystack_len]
    cmp eax, ebx
    pop ebx
    jl traverse_string
    jmp not_existing

traverse_string:
    mov [temp], eax
    mov al, [contor2]
    cmp al, [needle_len]
    jl traverse_substring

traverse_substring:
    add dl, 1

    mov [contor2], dl
    mov dl, 0
    mov cl, 0
    mov edx, dword [temp]


    ;source[temp] in ecx
    mov cl, byte [esi + edx]
    mov edx, 0
    mov al, byte [contor2]
    ;find[j]in edx
    mov dl, [ebx + eax]
    cmp ecx, edx
    jne not_found

    mov al, [temp]
    add eax, 1
    mov [temp], eax
    mov edx, dword[contor2]
    mov ecx, dword [needle_len]
    sub ecx, 1
    cmp edx, ecx
    jne traverse_substring
    mov ecx, [contor1]
    mov [edi], ecx
    jmp final


not_found:
    mov al, [contor1]
    add eax, 1
    mov edx, -1
    jmp start

not_existing:
    mov ecx, dword [haystack_len]
    add ecx, 1
    mov [edi], ecx
    jmp final

final:
    pop eax
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
