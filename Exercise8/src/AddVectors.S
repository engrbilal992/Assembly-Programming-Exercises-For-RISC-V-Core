    .section .data
N:      .word 12

A:  .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
B:  .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
C:  .space 48
fmt1: .asciz "C = {"
fmt2: .asciz "%d "
fmt3: .asciz "}\n"

    .section .text
    .global main
main:
    # initialize base addresses
    la x5, A               # x5 = &A
    la x6, B               # x6 = &B
    la x7, C               # x7 = &C
    li x8, 0               # i = 0
    li x9, 12              # N = 12

loop_i:
    bge  x8, x9, loop_done     # if (i >= N) break

    # compute address of A[i]
    slli x10, x8, 2            # offset = i * 4
    add  x11, x5, x10
    lw   x12, 0(x11)           # x12 = A[i]

    # compute N - i - 1
    addi x13, x8, 1
    sub  x14, x9, x13          # x14 = N - i - 1

    # address of B[N - i - 1]
    slli x15, x14, 2
    add  x16, x6, x15
    lw   x17, 0(x16)           # x17 = B[N - i - 1]

    # sum = A[i] + B[N - i - 1]
    add  x18, x12, x17

    # abs(sum)
    blt  x18, x0, neg
    j store_c
neg:
    sub  x18, x0, x18          # x18 = -x18
store_c:
    # store C[i]
    slli x19, x8, 2
    add  x20, x7, x19
    sw   x18, 0(x20)

    addi x8, x8, 1
    j loop_i

loop_done:
    # Initialize UART
    call uartInit

    # print "C = {"
    la a0, fmt1
    call printfNexys

    # print each C[i]
    li x8, 0
print_loop:
    bge x8, x9, print_done

    slli x10, x8, 2
    add  x11, x7, x10
    lw   a1, 0(x11)
    la   a0, fmt2
    call printfNexys

    addi x8, x8, 1
    j print_loop

print_done:
    la a0, fmt3
    call printfNexys

    ret
