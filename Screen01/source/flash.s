.globl FlashLED
FlashLED:

cmp r0,#20
movhi pc,lr


push {lr}
push {r4}
mov r4,r0

mov r0,#47
mov r1,#1
bl SetGpioFunction

ldr r0,=1000000
bl Wait

loop$:
  ldr r0,=100000
  bl Wait
  mov r0,#47
  mov r1,#1
  bl SetGpio
  ldr r0,=100000
  bl Wait
  mov r0,#47
  mov r1,#0
  bl SetGpio
  cmp r4,#0
  subhi r4,#1
    bhi loop$

pop {r4}
pop {pc}
