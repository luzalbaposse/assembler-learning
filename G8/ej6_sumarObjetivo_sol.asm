section .data
  arreglo:  dd 1,-2,3,0,-9,2,4,2,1,9
  len: EQU $ - arreglo
  objetivo: dd 8
  msgVerdadero: DB 'verdadero', 10
  long1: EQU $ - msgVerdadero
  msgFalso: DB 'falso', 10
  long2: EQU $ - msgFalso
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los numeros a sumar y comparar
    ; en Objetivo se encuentra el numero que deben sumar en el caso que exista.

    call sumarObjetivo
    
  exit:
    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarObjetivo:
  mov eax, -4
    loopExt:
      add eax, 4
      cmp eax, len
      je falso
      mov ebx, 0
      add ebx, 4
      loopInt:
        cmp ebx, len
        je loopExt
        cmp eax, ebx
        jz ignore
          mov ecx, [arreglo+eax]
          add ecx, [arreglo+ebx]
          cmp ecx, [objetivo]
          je verdadero
        ignore:
        add ebx, 4
        jmp loopInt
  
  verdadero:
    mov rax, 4            ; funcion 4: write
    mov rbx, 1            ; stdout
    mov rcx, msgVerdadero ; mensaje
    mov rdx, long1        ; longitud
    int 0x80
    JMP exit
  
  falso:
    mov rax, 4            ; funcion 4: write
    mov rbx, 1            ; stdout
    mov rcx, msgFalso     ; mensaje
    mov rdx, long2        ; longitud
    int 0x80
    JMP exit
    ret