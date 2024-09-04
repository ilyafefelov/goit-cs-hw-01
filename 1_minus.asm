; http://tpcg.io/_MM4JYD
section .data
    a db 5
    b db 3
    c db 2
    resultMsg db 'Result: $'
    resultChar db 0      ; Для збереження результату

section .text
global _start            ; Зробити точку входу доступною для компоновки

_start:
    ; Обчислення виразу (b - c + a)
    mov al, [b]
    sub al, [c]
    add al, [a]

    ; Перетворення результату в ASCII символ
    add al, 30h          ; Перетворюємо число в ASCII символ

    ; Збереження результату в окремий буфер
    mov [resultChar], al

    ; Виведення результату
    mov edx, resultMsg   ; Адреса повідомлення
    mov ecx, edx         ; Копіюємо адресу повідомлення в ECX
    mov ebx, 1           ; Дескриптор виводу на STDOUT
    mov eax, 4           ; Виклик sys_write
    int 0x80             ; Викликаємо переривання для виконання sys_write

    ; Виведення результату
    mov edx, 1           ; Довжина виводу 1 байт
    mov ecx, resultChar  ; Адреса результату
    mov ebx, 1           ; Дескриптор виводу на STDOUT
    mov eax, 4           ; Виклик sys_write
    int 0x80             ; Викликаємо переривання для виконання sys_write

    ; Завершення програми
    mov eax, 1           ; Виклик sys_exit (номер системного виклику)
    xor ebx, ebx         ; Код повернення 0
    int 0x80             ; Викликаємо переривання для завершення програми