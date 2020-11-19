%include "io.mac"

section .data
    contor1 db 0
    contor2 db 0
    contor3 db 0
    adresaedx dd 0
    len db 0
    string1 db "start", 0
    string2 db "lastbits", 0
    stringHEX db "HEXLEN", 0

    power2 db 0
    result db 0
    hexlen db 0
    hexlenendl db 0 
    parts db 0
    remain db 0

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    mov     [adresaedx], edx

    ;; TODO: Implement bin to hex

;cred ca o sa fac un loop care merge din 4 in 4 pana cand iese numarul din range 

    xor eax, eax
    xor ebx, ebx
    mov [len], cl
    mov al, 1
    mov [power2], al
    ;PRINTF32 `len: %u\n\x0`, ecx
    mov al, byte [len]
    mov bl, 4
    div bl
    cmp ah, 0
    jg add1
    je dont
add1:
    add al, 1
dont:
    mov [hexlen], al

    mov [parts], al
    ;mov al, byte [parts]
    ;PRINTF32 `PARTS: %hhu\n\x0`, eax
    mov [remain], ah
    mov al, byte [remain]
    cmp eax, 0
    jg not_multiplu
    ;PRINTF32 `rest: %hhu\n\x0`, eax


multiplu:
    add eax, 4
    mov [remain], al


not_multiplu:
    xor eax, eax
    mov al, [remain]
    xor eax, eax
    xor ecx, ecx
    xor ebx, ebx
    mov cl, byte [len]
    mov [contor1], cl
    xor ecx, ecx



    mov cl, byte [parts]
    mov [hexlenendl], cl
    

    ;PRINTF32 `asdsadsadasdsa %u\n\x0`, ecx

    xor ecx, ecx

start:
    mov cl, byte [contor1]
    mov al, byte [parts]
    mov bl, 0
    mov [contor2], bl
    sub al, 1
    cmp eax, 0
    jl exit
    mov [contor1], cl
    cmp ecx, 4
    jg setsof4
    jle lastset

setsof4:
    xor eax, eax
    mov al, byte [contor1]
    ;PRINTF32 `c1: %u \x0`, eax

    xor eax, eax
    mov al, byte [result]
    ;PRINTF32 `result :%u\n\x0`, eax
    xor eax, eax
    mov eax, ecx
    mov bl, byte [contor2]

    ;PRINTF32 `c2: %u\x0`, ebx
    cmp ebx, 0   
    je dont_multiply
    jg multiply
    
dont_multiply:
    sub eax, ebx
    xor ebx, ebx
    mov bl, byte [esi + eax - 1]
    sub ebx, 48
    ;PRINTF32 `bit: %u\x0`, ebx
    cmp ebx, 0
    je zero
    jne one

multiply:
    sub eax, ebx
    ;PRINTF32 ` eax: %u\n\x0`, eax
    xor ebx, ebx
    mov bl, byte [esi + eax -1]
    sub ebx, 48
    ;PRINTF32 `bit: %u\x0`, ebx
    xor eax, eax
    mov al, byte [power2]
    shl eax, 1
    mov [power2], al

    cmp ebx, 0
    je zero
    jne one
one:
    xor ebx, ebx
    mov bl, byte [result]
    mov al, byte [power2]
    add ebx, eax
    ;PRINTF32 `res: %u\n\x0`, ebx
    mov [result], bl

zero:
    xor ebx, ebx
    mov bl, [contor2]
    add ebx, 1
    mov [contor2], bl
    cmp ebx, 4
    jl setsof4
    xor ecx, ecx
    mov cl, byte [contor1]
    sub ecx, 4
    mov [contor1], ecx
    jmp process_result

lastset:
    ;PRINTF32 `%s\n\x0`, string1
    xor eax, eax
    
    mov al, byte [remain]
    ;PRINTF32 `remain %u    \x0`, eax
    
    mov bl, [contor2]
    ;PRINTF32 `contor2 %u\n\x0`, ebx

    cmp ebx, eax
    jge process_result
    xor eax, eax
    
    mov al, byte [contor1]
    ;PRINTF32 `contor1 %u\n\x0`, eax


    cmp ebx, 0
    je last_dont_multiply
    jg last_multiply


last_dont_multiply:
    ;;;;;;;;;;;;;;;;;;;;sub eax, ebx
    xor ebx, ebx
    mov bl, byte [esi + eax - 1]
    sub ebx, 48
    cmp ebx, 0
    je last_zero
    jne last_one

last_multiply:
    ;;;;;;;;;;;;;;;;sub eax, ebx
    xor ebx, ebx
    mov bl, byte [esi + eax -1]
    sub ebx, 48
    xor eax, eax
    mov al, byte [power2]
    shl eax, 1
    mov [power2], al

    cmp ebx, 0
    je last_zero
    jne last_one

last_one:
    xor ebx, ebx
    mov bl, byte [result]
    mov al, byte [power2]
    add ebx, eax
    mov [result], bl

last_zero:
    xor ebx, ebx
    mov bl, [contor2]
    add bl, 1
    mov [contor2], bl
    ;PRINTF32 `ASASASA %u\n\x0`, [contor2]
    xor ebx, ebx
    xor ecx, ecx
    mov cl, byte [contor1]
    sub ecx, 1
    mov [contor1], cl
    jmp lastset

;25
;1000111100000011111010101


process_result:
    xor eax, eax
    xor ebx, ebx
    mov al, byte [result]
    


    cmp eax, 10
    jge letter
    jl not_letter

letter:
    add eax, 55
    mov [result], al
    mov bl, byte [hexlen]
    ;PRINTF32 `MATA HEXLEN %u\n\x0`, ebx
    mov [edx + ebx - 1], al
    sub ebx, 1
    mov [hexlen], bl
    jmp after

not_letter:
    add al, '0'
    mov bl, byte [hexlen]
    ;PRINTF32 `MATA HEXLEN %u\n\x0`, ebx
    mov [edx + ebx - 1], al
    sub ebx, 1
    mov [hexlen], bl


    xor ebx, ebx
after:

    xor ebx, ebx
    mov bl, 0
    mov [result], bl
    mov bl, 1
    mov [power2], bl
    xor ebx, ebx
    xor eax, eax
    mov al, byte [contor1]
    cmp ecx, 0
    jg start

exit:

    ;PRINTF32 `%s\n\x0`, stringHEX
    
    xor eax, eax

    mov al, [hexlenendl]
    inc al
    mov byte [edx + eax - 1], 0x0A
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY