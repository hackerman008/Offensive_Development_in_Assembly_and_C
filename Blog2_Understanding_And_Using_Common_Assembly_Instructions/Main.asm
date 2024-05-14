; data section
.DATA 
    ; byte -> 8 bits (1 bytes)           
    ; word -> 16 bits (2 bytes)           
    ; dword -> 32 bits (4 bytes)      
    ; qword -> 64 bits (8 bytes) 
    string1        byte  "Hello World!", 0
    tempVar        dword  5  

; code section
.CODE 
    Main PROC

        mov rax, 0A1A2A3A4A5A6A7A8h
        mov eax, 0B1B2B3B4h
        mov ax, 0C1C2h
        mov al, 0D1h

        ; **** mov instruction ****
        mov rax, 0A1A2A3A4A5A6A7A8h             ; mov immediate hex value A1A2A3A4A5A6A7A8 to rax
        xor rax, rax                            ; clears rax register
        mov eax, dword ptr[tempVar]             ; moves the value of tempVar variable to eax
        xor eax, eax
        mov cx, 0A1A2h                          ; mov immediate hex value A1A2 to cx
        mov ax, cx
        xor ax, ax
        mov al, 0A1h                            ; mov immediate hex value A1 to al
        xor al, al

        ; **** movzx instruction ****
        ; movzx -> move zero extended
        mov al, 8
        movzx rax, al                           ; copies the value in al to rax and zero extends it 

        ; **** movsx instruction ****
        ; movsx -> move sign extended
        mov al, -8
        movsx eax, al                           ; copies the value in al to rax and sign extends it

        ; **** add intruction ****
        mov rcx, 20
        add rcx, 10                             ; add 10 to the value stored in the rcx register
        
        ; **** sub instruction ****
        mov rcx, 20
        sub rcx, 10                             ; subtract 10 from the value stored in rcx
        
        ; **** mul instruction ****
        ; mul -> unsigned multiply 
        ; Operation:    
        ; source is 64 bit - (rdx:rax = rax*r/m64)    (r/m = register/memory operand)
        ; source is 32 bit - (edx:eax = eax*r/m32)
        ; source is 16 bit - (dx:ax = ax*r/m16)
        ; source is 8 bit - (ax = al*r/m8)
        mov rax, 6                              
        mov rcx, 10
        mul rcx                                 ; rax is Source1, rcx is Source2, rdx:rax is destination operand

        ; **** div instruction ****
        ; div -> unsigned divide
        ; Operation:
        ; source is 64 bit - (rax = quotient, rdx = remainder, rdx:rax/(r/m64)) (r/m = register/memory operand)
        ; source is 32 bit - (eax = quotient, edx = remainder, edx:eax/(r/m32))
        ; source is 16 bit - (ax = quotient, dx = remainder, dx:ax/(r/m16))
        ; source is 8 bit - (al = quotient, ah = remainder, ax/(r/m8))
        xor rdx, rdx
        mov rax, 35
        mov rcx, 5
        div rcx                             ; rcx is divisor, rax is dividend, rax = Quotient, rdx = remainder

        ; **** not instruction ****
        ; not -> bitwise complement
        mov eax, 8
        not eax                             ; performs bitwise compliment (all bits are flipped) of value in eax 

        ; **** or instruction ****
        ; or -> bitwise inclusive or
        mov rax, 7
        mov rcx, 8
        or rax, rcx                         ; performs bitwise inclusive or of rax (destination) and rcx (source) 
                                            ; and stores result in rax (destination)
                                            
        ; **** xor instruction ****
        ; xor -> bitwise exclusive or
        mov rax, 7
        mov rcx, 8
        xor rax, rcx                        ; performs bitwise exclusive or of rax (destination) and rcx (source)
                                            ; and stores result in rax (destination)

        ; **** and instruction ****
        ; and -> bitwise and
        mov rax, 5
        mov rcx, 7
        and rax, rcx                          

        ; **** push and pop instruction ****
        mov rax, 8
        push rax                            ; push value in rax to the stack - only push 64 bit values to stack to maintain stack alignment
        pop rcx                             ; pop 64 bit value at top of stack and store it in rcx

        xor rax, rax                        ; zero out rax

        ; **** ror instruction ****
        ; ror -> rotate right
        mov al, 1 
        ror al, 1                           ; rotate the value in al register by 1 bit to the right 

        ; **** rol instruction ****
        ; rol -> rotate left
        mov al, 8
        rol al, 1                           ; rotate the value in al register by 1 bit to the left

        ; **** shl instruction ****
        ; shl -> shift logical left
        mov al, 8
        shl al, 2                           ; shift all bits to the left by 1, move the MSB to the carry flag and fill the LSB with 0

        ; **** shr instruction ****
        ; shr -> shift logical right
        mov al, 8
        shr al, 1                           ; shift all bits to the right by 1, move the LSB to the carry falg and fill the MSB with 0
        
        ; **** jmp and jcc instruction ****
        mov rax, 10
        mov rcx, 5
        LOOP1_START:                            
        add rax, rcx
        dec rcx                             ; decrements the value in the rcx register
        cmp rcx, 0                          ; cmp instruction subtracts the value in 1st operand (rcx), with 2nd operand (0) and sets the status flag 
        je LOOP1_DONE                       ; jump is ZF flag is set to 1
        jmp LOOP1_START                     ; direct jump (no condition is checked)

        LOOP1_DONE:
        nop                                 ; nop instruction does nothing but actually one byte nop instruction does xchg eax, eax
            
        ; **** call instruction ****
        mov ecx, 010h                       ; CONSTANT_VALUE1 is defined in .inc file and will be substituted here during assembling phase
        mov edx, 020h                
        call TempFunction                   ; when call instruction executes the address of the next instruction is pushed to stack
        cmp eax, 0
        jne EXIT_FAIL                       ; You can check if the return value of a function is what you want and continue or exit the program
      
        
        ; Note: Whenever loading a value from memory the register size should be equal to the size of the value being loaded 
        ;       from memory i.e if dword size value is being retrieved than 32 bit register should be the destination operand

        ; **** RIP relative addressing ****
        ; In both the instructions below the machine code will use relative offset and not absolute address
        mov eax, dword ptr[tempVar]         ; moves the value of tempVar to eax
        lea rcx, [string1]                  ; moves the address of string1 variable to rcx 
        
        ; **** absolute addressing ****
        mov rax, offset tempVar             ; the address of 'tempVar' is loaded in rax
        mov cl, byte ptr[rax]               ; loads the value at address stored in rax into cl


        ; **** Exit Success ****
        EXIT_SUCCESS:
        mov rax, 1                                  
        ret

        ; **** Exit Fail ****
        EXIT_FAIL:
        mov rax, 0
        ret

    Main ENDP

    TempFunction PROC
      
        mov eax, 0
        ret                                  ; when ret instruction executes the value at top of stack i.e. the return address will be poped of stack
    
    TempFunction ENDP 
END