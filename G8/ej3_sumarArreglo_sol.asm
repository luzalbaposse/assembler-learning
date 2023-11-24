section .data
  arreglo: dd -1,2,3,4,-5,6,7,8,9,-10
  longitud EQU $ - arreglo
  positivo: DB 'Positivo', 10
  negativo: DB 'Negativo', 10

global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 10 numeros a sumar.
    ; dejar el resultado en eax

    call sumarArreglo

  exit:
    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80

sumarArreglo:
    mov rax, 0
    mov ebx, 0

  loop:
    cmp ebx, longitud
    jz fin
    mov ecx, [arreglo + ebx]
    add eax, ecx
    add ebx, 4
    jmp loop

  fin:
    push rax
    mov rdi, rax
    call printHex
    pop rax
    cmp eax, 0
    jge respositivo
  
  resnegativo:
    mov rax, 4        ; funcion 4: write
    mov rbx, 1        ; stdout
    mov rcx, negativo ; mensaje
    mov rdx, 9        ; longitud
    int 0x80
    JMP exit
  
  respositivo:
    mov rax, 4        ; funcion 4: write
    mov rbx, 1        ; stdout
    mov rcx, positivo ; mensaje
    mov rdx, 9        ; longitud
    int 0x80
  ret


printHex:
  push rbx
  push r12
  push r13
  push r14
  push r15
  push rbp
  mov rcx, 15
  mov rbx, hexachars
  .ciclo:
    mov rax, rdi
    and rax, 0xF
    mov dl, [rbx+rax]
    mov [number+rcx], dl
    dec rcx
    shr rdi, 4
    cmp rcx, -1
    jnz .ciclo
  mov rax, 4      ; funcion 4
  mov rbx, 1      ; stdout
  mov rcx, number ; mensaje
  mov rdx, 17     ; longitud
  int 0x80
  pop rbp
  pop r15
  pop r14
  pop r13
  pop r12
  pop rbx
ret

section .rodata
  hexachars: db "0123456789ABCDEF"

section .data
  number:    db "0000000000000000",10
