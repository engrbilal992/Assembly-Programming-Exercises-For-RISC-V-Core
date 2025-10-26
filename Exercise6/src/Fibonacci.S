    .global main
main:
    li t0, 0x80001400          # GPIO base address
    li t1, 0x0000FFFF          # lower 16 bits output
    sw t1, 8(t0)               # WRITE_GPIO(GPIO_INOUT, En_Value)

    # Initialize first two Fibonacci numbers
    li t1, 0                   # V[0] = 0
    li t2, 1                   # V[1] = 1

    li t3, 12                  # N = 12 (total Fibonacci numbers)

fib_loop:
    # Display t1 (current Fibonacci value)
    li t4, 0xFFFF              # mask lower 16 bits
    and t4, t1, t4
    sw t4, 4(t0)               # WRITE_GPIO(GPIO_LEDs, value)

    # --- delay loop ---
    li t5, 100
delay_loop:
    addi t5, t5, -1
    bnez t5, delay_loop
    # ------------------

    # Compute next Fibonacci number
    add t6, t1, t2             # t6 = t1 + t2
    mv t1, t2                  # shift forward
    mv t2, t6

    addi t3, t3, -1
    bnez t3, fib_loop          # repeat until 12 numbers done

    j main                     # restart forever
