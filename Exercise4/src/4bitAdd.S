.global main
main:
    li t0, 0x80001400
    li t1, 0x0000FFFF
    sw t1, 8(t0)

loop:
    lw t1, 0(t0)
    srli t1, t1, 16      # LSB switches (bits 16-19)
    andi t1, t1, 0x0F

    lw t2, 0(t0)
    srli t2, t2, 28      # MSB switches (bits 28-31)
    andi t2, t2, 0x0F

    add t3, t1, t2       # sum

    li t4, 16
    li t5, 0x10
    blt t3, t4, no_overflow
    or t3, t3, t5        # set overflow
no_overflow:

    andi t3, t3, 0x1F     # mask LEDs 0-3 + overflow
    sw t3, 4(t0)

    j loop
