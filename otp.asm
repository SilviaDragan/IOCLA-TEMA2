%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

	xor eax, eax
	xor ebx, ebx
l:
	mov al, byte [esi + ecx - 1]
	mov bl, byte [edi + ecx -1]
	xor eax, ebx
	mov [edx + ecx - 1], al
	loop l

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
