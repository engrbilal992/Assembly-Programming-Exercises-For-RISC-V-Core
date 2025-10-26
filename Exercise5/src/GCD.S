.global main
main:
    li t0, 0x80001400      # GPIO base
    li t1, 0x0000FFFF      # lower 16 bits output, upper 16 input
    sw t1, 8(t0)           # write to GPIO_INOUT

loop:
    lw t1, 0(t0)           # read switches
    srli t1, t1, 16        # shift bits 16-23 to lower 8 bits
    andi t1, t1, 0xFF      # sws_value_lsb = t1

    lw t2, 0(t0)
    srli t2, t2, 24        # shift bits 24-31 to lower 8 bits
    andi t2, t2, 0xFF      # sws_value_msb = t2

gcd_loop:
    beq t2, zero, gcd_done # while (sws_value_msb != 0)
    rem t3, t1, t2         # remainder = t1 % t2
    mv t1, t2              # sws_value_lsb = sws_value_msb
    mv t2, t3              # sws_value_msb = remainder
    j gcd_loop

gcd_done:
    sw t1, 4(t0)           # WRITE_GPIO(GPIO_LEDs, sws_value_lsb)
    j loop                 # repeat forever