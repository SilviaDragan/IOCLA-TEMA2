%include "io.mac"

section .data
    keylen db 0
    plainlen db 0
    nr db 0
    c1 db 0
    c2 db 0
    string1 db "reset", 0
    string2 db "not_letter", 0

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
    


    mov eax, 0
    mov [keylen], ebx
    mov [plainlen], ecx
    xor ebx, ebx
    xor ecx, ecx
    mov bl, byte [keylen]
    mov cl, byte [plainlen]

start:
    ;eax contor pentru plaintext
    mov al, byte [c1]
    mov bl, byte [esi + eax]
    mov cl, byte [c2]
    cmp al, 0
    jg increment_c2
    je continue
increment_c2:
    add ecx, 1
    mov [c2], cl
continue:
    ;intai stabilesc nr cu care voi roti litera din plain
    ;pe baza literei din key
    xor eax, eax
    xor ecx, ecx
    mov cl, byte [c2]
    mov al, [keylen]
    cmp ecx, eax
    jge reset_counter
    jl in_range

reset_counter:
    mov cl, 0
    mov [c2], cl

in_range:
    xor eax, eax
    mov al, [edi + ecx]
    sub eax, 65

    mov [nr], al
    mov al, byte [c1]

    cmp ebx, 122
    jle check_if_lowercase
    jg not_letter

check_if_lowercase:
    cmp ebx, 97
    jge lowercase
    jl check_if_upper

check_if_upper:
    cmp ebx, 90
    jge not_letter
    cmp ebx, 65
    jl not_letter
    jge uppercase

uppercase:
    xor eax, eax
    mov al, byte [nr]
    add ebx, eax
    xor eax, eax
    mov al, byte [c1]
    cmp ebx, 90
    jg u_circle
    mov [edx + eax], bl
    mov al, byte [c1]
    add eax, 1
    mov [c1], al
    mov cl, byte [plainlen]
    cmp eax, ecx
    jl start
    jmp exit

lowercase:
    xor eax, eax
    mov al, byte [nr]
    add ebx, eax
    mov al, byte [c1]
    cmp ebx, 122
    jg l_circle
    mov [edx + eax], bl
    mov al, byte [c1]
    add eax, 1
    mov [c1], al
    mov cl, byte [plainlen]
    cmp eax, ecx
    jl start
    jmp exit

u_circle:
    xor ecx, ecx
    sub ebx, 91
    mov cl, 'A'
    add ecx, ebx
    mov al, byte [c1]
    mov [edx + eax], cl
    mov al, byte [c1]
    add eax, 1
    mov [c1], al
    mov cl, byte [plainlen]
    cmp eax, ecx
    jl start
    jmp exit

l_circle:
    xor ecx, ecx
    sub ebx, 123
    mov cl, 'a'
    add ecx, ebx
    mov al, byte [c1]
    mov [edx + eax], cl
    mov al, byte [c1]
    add eax, 1
    mov [c1], al
    mov cl, byte [plainlen]
    cmp eax, ecx
    jl start
    jmp exit


not_letter:
    mov [edx + eax], ebx
    add eax, 1
    sub ecx, 1
    mov [c2], cl
    mov [c1], al
    xor ecx, ecx
    mov cl, byte [plainlen]
    

    cmp eax, ecx
    jl start
    jmp exit

exit:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY