global crash_me

crash_me:
    ; div by 0
    mov eax, 0
    div eax

    ret