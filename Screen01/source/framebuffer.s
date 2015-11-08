.section .data
.align 8
.globl FrameBufferInfo
FrameBufferInfo:
.int 1024
.int 768
.int 1024
.int 768
.int 0
.int 16
.int 0
.int 0
.int 0
.int 0

.section .text
.globl InitialiseFrameBuffer
InitialiseFrameBuffer:
width .req r0
height .req r1
bitDepth .req r2
cmp width,#4096
cmpls height,#4096
cmpls bitDepth,#32
result .req r0
movhi result,#0
movhi pc,lr

push {r4,lr}
fbInfoAddr .req r4
ldr fbInfoAddr,=FrameBufferInfo+0x40000000
str width,[fbInfoAddr,#0]
str height,[fbInfoAddr,#4]
str width,[fbInfoAddr,#8]
str height,[fbInfoAddr,#12]
str bitDepth,[fbInfoAddr,#20]
.unreq width
.unreq height
.unreq bitDepth

mov r0,fbInfoAddr
@add r0,#0x40000000
mov r1,#1
bl MailboxWrite

mov r0,#1
bl MailboxRead

teq result,#0
movne result,#0
popne {r4,pc}

mov result,fbInfoAddr
and result,result,#0x0FFFFFFF
pop {r4,pc}
.unreq result
.unreq fbInfoAddr

