%include "io.mac"

section .data
    key db 0

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

    xor ebx, ebx
    xor eax, eax

    mov [key], edi
    mov al, byte [key]
    mov bl, 26
    div bl
    xor ebx, ebx
    mov bl, ah
    mov edi, ebx

    xor ebx, ebx
    xor eax, eax
start:
    ;;litera din plaintext se afla in bl
    mov bl, byte [esi + ecx - 1]
    ;; verific daca e < 122
    cmp ebx, 122
    jle check_if_lowercase
    jg not_letter

check_if_lowercase:
    ;; daca e > 97 e liter mica, daca nu verif daca e mare
    cmp ebx, 97
    jl check_if_uppercase
    jge lowercase

check_if_uppercase:
    ;; daca e < 90 verfic daca e mare, iar
    cmp ebx, 90
    jge not_letter
    cmp ebx, 65
    jl not_letter
    jge uppercase

uppercase:
    add ebx, edi 
    cmp ebx, 90
    jg u_circle 
    mov [edx + ecx - 1], bl
    jmp final

lowercase:
    add ebx, edi
    cmp ebx, 122
    jg l_circle
    mov [edx + ecx - 1], bl
    jmp final

l_circle:
    sub ebx, 123
    mov al, 'a'
    add eax, ebx
    mov [edx + ecx - 1], al
    jmp final

u_circle:
    sub ebx, 91
    mov al, 'A'
    add eax, ebx
    mov [edx + ecx - 1], al
    jmp final

not_letter:
    mov [edx + ecx - 1], bl

final:
    xor ebx, ebx
loop start
   
    

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY