# memory-mapped I/O addresses
# GPIO_SWs   = 0x80001400
# GPIO_LEDs  = 0x80001404
# GPIO_INOUT = 0x80001408

.global main
main:
    li t0, 0x80001400      # base address of GPIO
    li t1, 0x0000FFFF      # direction: upper 16 input, lower 16 output
    sw t1, 8(t0)           # write to GPIO_INOUT

repeat:
    #  turn LEDs ON based on switches 
    lw t1, 0(t0)           # read switches
    srli t1, t1, 16        # shift switch bits to lower 16 bits
    sw t1, 4(t0)           # write to LEDs

    # delay
    li t2, 100000          # delay counter
delay_on:
    addi t2, t2, -1
    bnez t2, delay_on      # loop until t2 == 0

    # LED OFF
    li t3, 0x00000000
    sw t3, 4(t0)

    # delay off
    li t2, 100000
delay_off:
    addi t2, t2, -1
    bnez t2, delay_off

    j repeat  
