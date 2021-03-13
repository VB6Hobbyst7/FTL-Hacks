{ Game   : FTLGame.exe
  Version: 
  Date   : 2021-03-11
  Author : Dan

  This script should max out scrap after transactions
}

[ENABLE]

aobscanmodule(Scrap,FTLGame.exe,89 83 D4 04 00 00 8D)
alloc(newmem,$1000)

label(code)
label(return)

newmem:

code:
  mov [ebx+000004D4],(float)9999
  jmp return

Scrap:
  jmp newmem
  nop
return:
registersymbol(Scrap)

[DISABLE]

Scrap:
  db 89 83 D4 04 00 00

unregistersymbol(Scrap)
dealloc(newmem)
