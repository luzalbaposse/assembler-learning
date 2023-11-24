section .data
  arreglo: dd -1,2,3,4,-5,6,7,8,9,-10
                               
global _start
section .text

  _start:                

    ; En la etiqueta arreglo se encuentran los 10 numeros a sumar.
    ; dejar el resultado en eax

    call sumarArreglo

    ; Exit
    mov rax, 1     ; funcion 1 
    mov rbx, 0     ; codigo    
    int 0x80                   

sumarArreglo:
  ; COMPLETAR
  ret