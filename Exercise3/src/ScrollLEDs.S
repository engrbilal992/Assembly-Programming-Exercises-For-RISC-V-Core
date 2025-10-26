.set GPIO_LEDs,  0x80001404
.set GPIO_INOUT, 0x80001408

.global main
main:
    li   t0, GPIO_INOUT
    li   t1, 0x0000FFFF
    sw   t1, 0(t0)

    li   t6, 16       # num_leds

main_loop:
    li   t2, 1        # leds_on
leds_on_loop:
    bgt  t2, t6, main_loop

    li   t3, 0        # scroll right
scroll_right:
    sub  t4, t6, t2
    bgt  t3, t4, scroll_left

    li   t5, 1
    sll  t5, t5, t2
    addi t5, t5, -1
    sll  t5, t5, t3

    li   t0, GPIO_LEDs
    sw   t5, 0(t0)

    li   a0, 5000
delay1:
    addi a0, a0, -1
    bnez a0, delay1

    addi t3, t3, 1
    j    scroll_right

scroll_left:
    sub  t3, t6, t2
scroll_left_loop:
    blt  t3, zero, leds_on_inc

    li   t5, 1
    sll  t5, t5, t2
    addi t5, t5, -1
    sll  t5, t5, t3

    li   t0, GPIO_LEDs
    sw   t5, 0(t0)

    li   a0, 5000
delay2:
    addi a0, a0, -1
    bnez a0, delay2

    addi t3, t3, -1
    j    scroll_left_loop

leds_on_inc:
    addi t2, t2, 1
    j    leds_on_loop
