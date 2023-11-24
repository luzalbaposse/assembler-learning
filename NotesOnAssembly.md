# Notes about Assembly 👀

## Sections

We stick to three sections:
- text - contains the actual instructions that your code will run
- bss - the place for global variables. Any static variable is placed here
- data - this section is used for constant globals

### To declare sections we say: section .name with name in {data, text, bss}

## Variables

We store variables in bss section. We can't declare their value, but tell the assembler exactly how many bytes to reserve

```
section .bss
        var     resb 4
```

This creates a var variable that reserves 4 bytes for it. To access the value of ```var```, we surround its name in square brackets: ```[var]```.

## Statements

```
mnemonic    [operands]      [; comment]
```

- mnemonic is the actual to run
- operands will be registers
- comments are comments and thats it

## Labels

This is C:
```
void main() {
	int var = 0;
	while (1) {
		var ++;
	}
}
```

In assembly, we don't have loops. So, it would be more like:

```
void main() {
    int var = 0;
    loop:
        var ++;
        goto loop;
}
```

Which is a really bad practice on C, hut let's take a look. In assembly, we will need a text section to store the program and a bss section to store some variables. And we also need to tell the program where to start our program, for that we use ```_start```, we can tell the linker where to start using ```global _start```

```
section .text
	global _start

	_start:
```

Now, we create a variable:

```
section .bss
    var resb 4
```

Now we need to initialize the variable. This is exactly what the mov instruction is for.

```
section .text
	_start:
	mov dword [var], 0 ; We have "dword" here because it's a 32 bit operation
```
dword := double word (32 bits)

Now, if we want a look, we will make a label, call it loop and jump unconditionally to it

```
_start:
	mov dword [var], 0
loop:
	jmp loop
```
And then, we increment the variable

```
section .text
	global _start

	_start:
		mov dword [var], 0
	loop:
		inc dword [var]
		jmp loop
section .bss
	var resb 4
```

### How to run? 

```
nasm -f elf nombre.asm
ld -m elf_i386 -s -o nombre nombre.o
./nombre
```

## Registers

As our CPU has a built-in memory, registers are memory itself. Registers are built into the CPU and are quicker than keep things on RAM. We will focus on four: eax, ebx, ecx, and edx.

```
section .text
	global _start

	_start:
		mov eax, 0
	loop:
		inc eax
		jmp loop
```

## System Calls

System calls tell the operating system to do something. 
- sys_exit - If eax is set to 1, then a system exit will be performed. The exit code is whatever number is stored in ebx.
- sys_write - If eax is 4 and ebx is 1, then the string with its pointer stored in ecx will be printed. The length of the string is in edx

```
section .data
	message db "Hello, world!", 10, 0 ; the message to print
    len equ $-message ; length of the message

section .text
	global _start

	start:

		; print("Hello, world!\n")
		mov eax, 4	; print
		mov ebx, 1 ; print to console
		mov ecx, message ; the message to write
		mov edx, len ; the length of the message
		int 0x80

		; exit(0)
		mov eax, 1 ; system exit
		mov ebx, 0 ; exit code 0
		int 0x80
```

- db stands for declare bytes
- 10 == \n
- len equ$-something -> len of something

# Fibonacci

Let's use this algorithm:

```
fn fibonacci() {
    let mut iteration = 40;

    let mut a = 0;
    let mut b = 1;
    let mut c : usize;

    while iteration != 0 {

        c = a + b;
        println!("{}", c);

        a = b;
        b = c;

        iteration -= 1;
    }
}
```

In Assembly:

```
section .text
	global _start

	_start:
		; initialize values
		mov dword [var_a], 0
		mov dword [var_b], 1
		mov dword [itera], 40		; generate 40 numbers

	one_num:
		; if (iteration == 0) goto end
		cmp dword [itera], 0
		je end

		; c = a + b
		mov dword [var_c], var_a	; c = a
		add dword [var_c], var_b	; c += b

		mov dword [var_a], var_b	; a = b
		mov dword [var_b], var_c	; b = c

		dec dword [itera]			; iteration --

	end:
		mov eax, 1					; system exit
		mov ebx, 0					; exit code 0
		int 0x80

section .bss
	var_a resb 4
	var_b resb 4
	var_c resb 4

	itera resb 4
```

## Bibliography
- Assembly Part 1 - Let's Learn Assembly! by Mike White [https://www.section.io/engineering-education/assembly-part-1/] 
- Assembly Part 2 - Let's Write Assembly! by Mike White [https://www.section.io/engineering-education/assembly-part-2/] 