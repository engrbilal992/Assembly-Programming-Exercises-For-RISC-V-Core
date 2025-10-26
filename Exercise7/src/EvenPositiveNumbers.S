    .section .data
N:      .word 12

A:  .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
B:  .space 48
fmt: .asciz "Number of elements in B = %d "

    .section .text
    .global main
main:
    # Base addresses
    la x5, A               # x5 = &A
    la x6, B               # x6 = &B
    li x7, 0               # x7 = i = 0
    li x8, 0               # x8 = count = 0
    li x9, 12              # x9 = N

loop_i:
    bge  x7, x9, loop_done     # if (i >= N) break

    slli x10, x7, 2            # offset = i * 4
    add  x11, x5, x10
    lw   x12, 0(x11)           # x12 = A[i]
    
    ble  x12, x0, skip_store

    # check even: if (A[i] % 2 != 0) skip
    andi x13, x12, 1
    bne  x13, x0, skip_store

    # B[count] = A[i]
    slli x14, x8, 2
    add  x15, x6, x14
    sw   x12, 0(x15)

    addi x8, x8, 1             # count++

skip_store:
    addi x7, x7, 1
    j loop_i

# UART + printf
loop_done:
    call uartInit

    la a0, fmt                 # format string
    mv a1, x8                  # count
    call printfNexys

    ret
