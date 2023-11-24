section .data                  
  msg: DB 'Luz', 3
  largo EQU $ - msg            
                               
global _start                
section .text

  _start:                

    call nombre

    mov rax, 1      
    mov rbx, 0    
    int 0x80                   

nombre:
    ; Impresión del nombre en horizontal.
    mov rax, 4     ; funcion 4: write
    mov rbx, 1     ; stdout
    mov rcx, msg   ; mensaje
    mov rdx, largo ; longitud
    int 0x80

    ; Impresión del nombre en vertical
    mov rcx, msg   ; mensaje
    mov rdi, 10    ; cantidad de letras del nombre

    loop:
    push rcx

    mov rax, 4     ; funcion 4: write
    mov rbx, 1     ; stdout
    mov rdx, 1     ; longitud
    int 0x80

    mov rax, 4     ; funcion 4: write
    mov rbx, 1     ; stdout
    mov rcx, enter ; mensaje (enter)
    mov rdx, 1     ; longitud
    int 0x80

    pop rcx
    inc rcx
    dec rdi
    JZ fin
    JMP loop

    ; Impresión del nombre en vertical (Version 2)
    mov rax, 4     ; funcion 4: write
    mov rbx, 1     ; stdout
    mov rcx, msgV  ; mensaje
    mov rdx, 1     ; longitud

    fin:
    ret


  ret
