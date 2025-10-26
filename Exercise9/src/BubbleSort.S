    .section .data
N:      .word 12
A:      .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
fmt1:   .asciz "A_Sorted = {"
fmt2:   .asciz "%d "
fmt3:   .asciz "}\n"

    .section .text
    .global main
main:
    # Load base address of A and N
    la x5, A               # x5 = &A
    li x6, 12              # x6 = N
    addi x6, x6, -1        # x6 = N - 1
    li x7, 0               # i = 0

outer_loop:
    bge  x7, x6, sort_done # if (i >= N-1) done
    li x8, 0               # j = 0

inner_loop:
    bge  x8, x6, next_i    # if (j >= N-1) next i

    # Load A[j] into x9
    slli x10, x8, 2        # offset = j * 4
    add  x11, x5, x10
    lw   x9, 0(x11)        # x9 = A[j]

    # Load A[j+1] into x12
    addi x13, x8, 1
    slli x14, x13, 2
    add  x15, x5, x14
    lw   x12, 0(x15)       # x12 = A[j+1]

    # Compare A[j] > A[j+1]
    ble  x9, x12, no_swap

    # swap A[j] and A[j+1]
    sw   x12, 0(x11)
    sw   x9,  0(x15)

no_swap:
    addi x8, x8, 1
    j inner_loop

next_i:
    addi x7, x7, 1
    j outer_loop

sort_done:
    # Initialize UART
    call uartInit

    # Print "A_Sorted = {"
    la a0, fmt1
    call printfNexys

    # Print sorted array
    li x7, 0
print_loop:
    li x8, 12
    bge x7, x8, print_done

    slli x9, x7, 2
    add  x10, x5, x9
    lw   a1, 0(x10)
    la   a0, fmt2
    call printfNexys

    addi x7, x7, 1
    j print_loop

print_done:
    la a0, fmt3
    call printfNexys

    ret
