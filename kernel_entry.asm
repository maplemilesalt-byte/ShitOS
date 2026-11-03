[bits 32]
[extern kernel]   

global start
start:
    call kernel   
    jmp $         
