.text
.globl _start

_start:
    # Set up exception handler
    la t0, exception_handler
    csrw mtvec, t0

    # Set mepc to point to the first instruction of Fibonacci
    la t0, fibonacci
    csrw mepc, t0

    # Store base addresses in registers
    li t0, 0x0       # Base address for Fibonacci PCB
    li t1, 0x100     # Base address for Factorial PCB
    li t2, 0x200     # Address for Task Flag
    li t5, 0x088    # Address to store mepc for Fibonacci
    li t6, 0x184     # Address to store mepc for Factorial
    csrw mscratch, t2  

    li t3, 1
    sw t3, 0(t2)     # Store the initial task flag as 1 (Factorial)

    la t5, fibonacci  # Loading address to store mepc for Fibonacci
    la t6, factorial  # Loading address to store mepc for Factorial


    # Enable machine timer interrupt 
    li t3, 0x80
    csrs mie, t3

    # Initialize mtimecmp 
    li t3, 300  # Set initial timer interrupt interval 
    la t4, mtimecmp  # MTIMECMP address
    sw t3, 0(t4)     # Store lower 32 bits of t3 into mtimecmp
    sw zero, 4(t4)   # Store upper 32 bits of t3 (zero for RV32)

    # Execute the Fibonacci function until you get an interrupt
    mret

exception_handler:
    li t0, 0x0       # Base address for Fibonacci PCB
    li t1, 0x100     # Base address for Factorial PCB

      # Set up new timer interrupt
    la t3, mtime        # MTIME address
    lw x5, 0(t3)        # Load lower 32 bits of mtime
    addi x5, x5, 300    # Update timer interrupt interval
    la t4, mtimecmp     # MTIMECMP address
    sw x5, 0(t4)        # Store lower 32 bits of x5 into mtimecmp
    sw zero, 4(t4)      # Store upper 32 bits of x5 into mtimecmp
    li t3, 0x00         # Load a value with the MTIP bit cleared
    csrrw x0, mip, t3   # Clear the MTIP bit in mip

    # Check which task to switch to
    csrr x5, mscratch
    beqz x5, switch_to_fibonacci 
    j switch_to_factorial     

switch_to_fibonacci:
    li t0, 0x0       # Base address for Fibonacci PCB
    li t1, 0x100     # Base address for Factorial PCB

    # Save current task context (Factorial)
    csrr t6, mepc
    sw x1, 0(t1)
    sw x2, 4(t1)
    sw x3, 8(t1)
    sw x4, 12(t1)
    sw x5, 16(t1)
    sw x6, 20(t1)
    sw x7, 24(t1)
    sw x8, 28(t1)
    sw x9, 32(t1)
    sw x10, 36(t1)
    sw x11, 40(t1)
    sw x12, 44(t1)
    sw x13, 48(t1)
    sw x14, 52(t1)
    sw x15, 56(t1)
    sw x16, 60(t1)
    sw x17, 64(t1)
    sw x18, 68(t1)
    sw x19, 72(t1)
    sw x20, 76(t1)
    sw x21, 80(t1)
    sw x22, 84(t1)
    sw x23, 88(t1)
    sw x24, 92(t1)
    sw x25, 96(t1)
    sw x26, 100(t1)
    sw x27, 104(t1)
    sw x28, 108(t1)
    sw x29, 112(t1)
    sw x30, 116(t1)
    sw x31, 120(t1)
  


    # Load Fibonacci task context
    csrw mepc, t5
    lw x1, 0(t0)
    lw x2, 4(t0)
    lw x3, 8(t0)
    lw x4, 12(t0)
    lw x5, 16(t0)
    lw x6, 20(t0)
    lw x7, 24(t0)
    lw x8, 28(t0)
    lw x9, 32(t0)
    lw x10, 36(t0)
    lw x11, 40(t0)
    lw x12, 44(t0)
    lw x13, 48(t0)
    lw x14, 52(t0)
    lw x15, 56(t0)
    lw x16, 60(t0)
    lw x17, 64(t0)
    lw x18, 68(t0)
    lw x19, 72(t0)
    lw x20, 76(t0)
    lw x21, 80(t0)
    lw x22, 84(t0)
    lw x23, 88(t0)
    lw x24, 92(t0)
    lw x25, 96(t0)
    lw x26, 100(t0)
    lw x27, 104(t0)
    lw x28, 108(t0)
    lw x29, 112(t0)
    lw x30, 116(t0)
    lw x31, 120(t0)
    
    # Update task flag to 1 (Factorial)
    li a5, 1
    csrw mscratch, a5

    mret

switch_to_factorial:
    li t0, 0x0       # Base address for Fibonacci PCB
    li t1, 0x100     # Base address for Factorial PCB

    # Save current task context (C)
    csrr t5, mepc
    sw x1, 0(t0)
    sw x2, 4(t0)
    sw x3, 8(t0)
    sw x4, 12(t0)
    sw x5, 16(t0)
    sw x6, 20(t0)
    sw x7, 24(t0)
    sw x8, 28(t0)
    sw x9, 32(t0)
    sw x10, 36(t0)
    sw x11, 40(t0)
    sw x12, 44(t0)
    sw x13, 48(t0)
    sw x14, 52(t0)
    sw x15, 56(t0)
    sw x16, 60(t0)
    sw x17, 64(t0)
    sw x18, 68(t0)
    sw x19, 72(t0)
    sw x20, 76(t0)
    sw x21, 80(t0)
    sw x22, 84(t0)
    sw x23, 88(t0)
    sw x24, 92(t0)
    sw x25, 96(t0)
    sw x26, 100(t0)
    sw x27, 104(t0)
    sw x28, 108(t0)
    sw x29, 112(t0)
    sw x30, 116(t0)
    sw x31, 120(t0)
  


    # Load Factorial task context
    
    lw x1, 0(t1)
    lw x2, 4(t1)
    lw x3, 8(t1)
    lw x4, 12(t1)
    lw x5, 16(t1)
    lw x6, 20(t1)
    lw x7, 24(t1)
    lw x8, 28(t1)
    lw x9, 32(t1)
    lw x10, 36(t1)
    lw x11, 40(t1)
    lw x12, 44(t1)
    lw x13, 48(t1)
    lw x14, 52(t1)
    lw x15, 56(t1)
    lw x16, 60(t1)
    lw x17, 64(t1)
    lw x18, 68(t1)
    lw x19, 72(t1)
    lw x20, 76(t1)
    lw x21, 80(t1)
    lw x22, 84(t1)
    lw x23, 88(t1)
    lw x24, 92(t1)
    lw x25, 96(t1)
    lw x26, 100(t1)
    lw x27, 104(t1)
    lw x28, 108(t1)
    lw x29, 112(t1)
    lw x30, 116(t1)
    lw x31, 120(t1)
    csrw mepc, t6

    # Update task flag to 0 ( Fibonacci)
    li a5, 0
    csrw mscratch, a5

    mret
