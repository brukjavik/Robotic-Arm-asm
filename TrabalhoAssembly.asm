
.486

.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm
    

.data
    x1 REAL8 0.0
    x2 REAL8 0.0
    y1 REAL8 0.0
    y2 REAL8 0.0
    incrementox REAL8 0.0
    incrementoy REAL8 0.0
    furos REAL8 0.0
    i DWORD 1
    furosInt DWORD 0
    aux REAL8 1.0

    Variavelstr db 100 dup(?)
    write_count dd 0
    tamanho DWORD 0

    print1 db "(", 0h
    print2 db ",", 0h
    print3 db ")", 0ah, 0h
    
    msg1 db " Digite o x1 referente a (x1, y1) do ponto inicial: ", 0h
    msg2 db " Digite o y1 referente a (x1, y1) do ponto inicial: ", 0h
    msg3 db " Digite o x2 referente a (x2, y2) do ponto final: ", 0h
    msg4 db " Digite o y2 referente a (x2, y2) do ponto final: ", 0h
    msgpontos db " Digite a quantidade de furos que serao realizados: ", 0h
    msgcontinua db "Deseja realizar outra operacao? (s/n): ", 0h
    msgerro db "Por favor, digite uma letra valida! ", 0ah, 0h
    msgfim db "O programa foi encerrado com sucesso!!! ", 0h
    
    x db 50 dup(?)
    y db 50 dup(?)
    

.code

start:

   mov i, 1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg1, sizeof msg1, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL
   
   invoke StrToFloat,addr Variavelstr,addr x1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg2, sizeof msg2, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr y1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg3, sizeof msg3, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL
   
   invoke StrToFloat,addr Variavelstr,addr x2

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg4, sizeof msg4, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr y2

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msgpontos, sizeof msgpontos, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr furos

   fld furos
   fld aux
   fsub
   fstp furos

   fld x2
   fld x1
   fsub
   fld furos
   fdiv
   fstp incrementox

   fld y2
   fld y1
   fsub
   fld furos
   fdiv
   fstp incrementoy

   fld furos
   fistp furosInt

   invoke FloatToStr, x1,addr x
   invoke FloatToStr, y1,addr y

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print1, sizeof print1, addr write_count, NULL

    invoke StrLen, addr x
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr x, tamanho, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print2, sizeof print2, addr write_count, NULL

    invoke StrLen, addr y
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr y, tamanho, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print3, sizeof print3, addr write_count, NULL

   _loop:
     fld x1
     fld incrementox
     fadd
     fstp x1

     fld y1
     fld incrementoy
     fadd
     fstp y1

    invoke FloatToStr, x1,addr x
    invoke FloatToStr, y1,addr y

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print1, sizeof print1, addr write_count, NULL

    invoke StrLen, addr x
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr x, tamanho, addr write_count, NULL
   

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print2, sizeof print2, addr write_count, NULL   

    invoke StrLen, addr y
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr y, tamanho, addr write_count, NULL
    
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print3, sizeof print3, addr write_count, NULL

     mov eax, i
     add i, 1
     
   CMP eax, furosInt
   JL _loop
     
   ask:
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgcontinua, sizeof msgcontinua, addr write_count, NULL
   
    push STD_INPUT_HANDLE
    call GetStdHandle
    invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

    CMP Variavelstr, 's'
    JE start

    CMP Variavelstr, 'n'
    JE quit    

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgerro, sizeof msgerro, addr write_count, NULL

    JMP ask

   quit:
   
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgfim, sizeof msgfim, addr write_count, NULL

    exit

end start
.486

.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm
    

.data
    x1 REAL8 0.0
    x2 REAL8 0.0
    y1 REAL8 0.0
    y2 REAL8 0.0
    incrementox REAL8 0.0
    incrementoy REAL8 0.0
    furos REAL8 0.0
    i DWORD 1
    furosInt DWORD 0
    aux REAL8 1.0

    Variavelstr db 100 dup(?)
    write_count dd 0
    tamanho DWORD 0

    print1 db "(", 0h
    print2 db ",", 0h
    print3 db ")", 0ah, 0h
    
    msg1 db " Digite o x1 referente a (x1, y1) do ponto inicial: ", 0h
    msg2 db " Digite o y1 referente a (x1, y1) do ponto inicial: ", 0h
    msg3 db " Digite o x2 referente a (x2, y2) do ponto final: ", 0h
    msg4 db " Digite o y2 referente a (x2, y2) do ponto final: ", 0h
    msgpontos db " Digite a quantidade de furos que serao realizados: ", 0h
    msgcontinua db "Deseja realizar outra operacao? (s/n): ", 0h
    msgerro db "Por favor, digite uma letra valida! ", 0ah, 0h
    msgfim db "O programa foi encerrado com sucesso!!! ", 0h
    
    x db 50 dup(?)
    y db 50 dup(?)
    

.code

start:

   mov i, 1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg1, sizeof msg1, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL
   
   invoke StrToFloat,addr Variavelstr,addr x1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg2, sizeof msg2, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr y1

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg3, sizeof msg3, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL
   
   invoke StrToFloat,addr Variavelstr,addr x2

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msg4, sizeof msg4, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr y2

   push STD_OUTPUT_HANDLE
   call GetStdHandle
   invoke WriteConsole, eax, addr msgpontos, sizeof msgpontos, addr write_count, NULL

   push STD_INPUT_HANDLE
   call GetStdHandle
   invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

   invoke StrToFloat,addr Variavelstr,addr furos

   fld furos
   fld aux
   fsub
   fstp furos

   fld x2
   fld x1
   fsub
   fld furos
   fdiv
   fstp incrementox

   fld y2
   fld y1
   fsub
   fld furos
   fdiv
   fstp incrementoy

   fld furos
   fistp furosInt

   invoke FloatToStr, x1,addr x
   invoke FloatToStr, y1,addr y

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print1, sizeof print1, addr write_count, NULL

    invoke StrLen, addr x
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr x, tamanho, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print2, sizeof print2, addr write_count, NULL

    invoke StrLen, addr y
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr y, tamanho, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print3, sizeof print3, addr write_count, NULL

   _loop:
     fld x1
     fld incrementox
     fadd
     fstp x1

     fld y1
     fld incrementoy
     fadd
     fstp y1

    invoke FloatToStr, x1,addr x
    invoke FloatToStr, y1,addr y

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print1, sizeof print1, addr write_count, NULL

    invoke StrLen, addr x
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr x, tamanho, addr write_count, NULL
   

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print2, sizeof print2, addr write_count, NULL   

    invoke StrLen, addr y
    mov tamanho, EAX

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr y, tamanho, addr write_count, NULL
    
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr print3, sizeof print3, addr write_count, NULL

     mov eax, i
     add i, 1
     
   CMP eax, furosInt
   JL _loop
     
   ask:
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgcontinua, sizeof msgcontinua, addr write_count, NULL
   
    push STD_INPUT_HANDLE
    call GetStdHandle
    invoke ReadConsole, eax, addr Variavelstr, sizeof Variavelstr, addr write_count, NULL

    CMP Variavelstr, 's'
    JE start

    CMP Variavelstr, 'n'
    JE quit    

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgerro, sizeof msgerro, addr write_count, NULL

    JMP ask

   quit:
   
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    invoke WriteConsole, eax, addr msgfim, sizeof msgfim, addr write_count, NULL

    exit

end start