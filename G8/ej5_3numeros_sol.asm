section .data
  numero1: db -10
  numero2: dw -9
  numero3: dd -120
  msgPositivos: DB 'Son todos positivos', 10
  long1: EQU $ - msgPositivos
  msgNegativos: DB 'Son todos negativos', 10
  long2: EQU $ - msgNegativos
  msgMixto: DB 'Hay positivos y negativos', 10
  long3: EQU $ - msgMixto
                               
global _start
section .text

  _start:                

    ; En las etiquetas numero1, numero2 y numero3 se encuentran los tres numeros a comparar

    call tresNumeros

  exit:
    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

tresNumeros:
    mov al,  [numero1]
    mov bx,  [numero2]
    mov ecx, [numero3]
    cmp al, 0
    jge primeroPositivo
    cmp bx, 0 ; al < 0
    jge mixto
    cmp ecx, 0 ; al < 0 y bx < 0
    jge mixto

  todosNegativos:
    mov rax, 4            ; funcion 4: write
    mov rbx, 1            ; stdout
    mov rcx, msgNegativos ; mensaje
    mov rdx, long2        ; longitud
    int 0x80
    JMP exit
   
  primeroPositivo: ; al >= 0
    cmp bx, 0
    jl mixto
    cmp ecx, 0 ; al >= 0 y bx >= 0
    jl mixto
  
  todosPositivos:
    mov rax, 4            ; funcion 4: write
    mov rbx, 1            ; stdout
    mov rcx, msgPositivos ; mensaje
    mov rdx, long1        ; longitud
    int 0x80
    JMP exit   
    
  mixto:
    mov rax, 4            ; funcion 4: write
    mov rbx, 1            ; stdout
    mov rcx, msgMixto     ; mensaje
    mov rdx, long3        ; longitud
    int 0x80
    JMP exit
  ret