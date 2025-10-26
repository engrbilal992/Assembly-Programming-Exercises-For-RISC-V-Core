    .section .data
n:          .word 7
fmt:        .asciz "Factorial of %d = %d\n"

    .section .text
    .global main
main:
    # Initialize UART
    call uartInit

    # Load n and initialize factorial = 1
    lw x5, n               # x5 = n
    li x6, 1               # x6 = factorial = 1
    li x7, 1               # x7 = i = 1

loop:
    bgt  x7, x5, done      # if (i > n) -> done
    mul  x6, x6, x7        # factorial *= i
    addi x7, x7, 1         # i++
    j    loop

done:
    # Print result: printfNexys("Factorial of %d = %d\n", n, factorial)
    la   a0, fmt           # format string
    lw   a1, n             # first argument: n
    mv   a2, x6            # second argument: factorial
    call printfNexys

    ret
