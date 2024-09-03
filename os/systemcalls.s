# bootup
_start: 
    la t0, exception_handler        # Setting up exception handler address
    csrw mtvec, t0                  # Set machine mode trap handler base address
    sw t5,0x28(sp)                  # Save t5 register to stack
    # TODO: set mepc to user_systemcalls
    la t5, user_systemcalls         # Load address of user_systemcalls
    csrw mepc, t5                   # Set mepc to user_systemcalls
   
    mret                            # Return to user mode

exception_handler:
    
    sw t3, 0x0(sp)                  
    sw t4, 0x4(sp)                  
    sw t1, 0x8(sp)                  
    sw t6, 0x12(sp)                 
    sw a4, 0x16(sp)                 
    sw t2, 0x20(sp)                 
    sw a3, 0x24(sp)                 
    sw a0, 0x28(sp)                 
    sw s1, 0x32(sp)                 
    sw a6, 0x36(sp)                 
    sw a7, 0x40(sp)                 
    sw s2, 0x44(sp)                 
    sw s3, 0x48(sp)                 

    li s1, 1                        # Set s1 to 1
    la a6, display_data             # Load address of display_data into a6

    csrr t3, mcause                 
    csrr t5, mstatus                # Read mstatus register into t5
    li t1, 0x7FFFFFFF               # Load mask value into t1
    and t3, t3, t1                  # Mask out the interrupt bit in t3
    li a3, 8                        # Load exception code for system call into a3
    beq t3, a3, compute             # If exception is a system call, jump to compute
    
    mret                          

compute:
    addi t6, a7, 0                 
    li s2, 11                      # handling syscall 4 and 11
    li s3, 4                        
    beq t6, s2, loop3              
    beq t6, s3, printstring         # If a7 is 4, jump to printstring
    
    mret                            # Return from exception handler

printchar:

loop3:
    la a4, display_ready            
    lw t2, 0(a4)                    
    beqz t2, loop3                  # Wait until display
    sb a0, 0(a6)                    # Store character from a0 to display
    j exit                          

printstring:
    la a4, display_ready            # Load address of display_ready into a4
loop2:
    lw t2, 0(a4)                    # Load display_ready value into t2
    beq t2, s1, printfullstring     # If display_ready is set, jump to printfullstring
    j loop2                         # Loop until display_ready is set

printfullstring:
    lb t3, 0(a0)                    
    sb t3, 0(a6)                   
    beqz t3, exit                   # If byte is zero (end of string), jump to exit
    addi a0, a0, 1                  
    
    j printfullstring               # Continue printing the string

exit:
   
    lw t3, 0x0(sp)                  
    lw t4, 0x4(sp)                  
    lw t1, 0x8(sp)                  
    lw t6, 0x12(sp)                 
    lw a4, 0x16(sp)                 
    lw t2, 0x20(sp)                 
    lw a3, 0x24(sp)                 
    lw a0, 0x28(sp)                 
    lw t5, 0x28(sp)                 
    lw s1, 0x32(sp)                 
    lw a6, 0x36(sp)                 
    lw a7, 0x40(sp)                 
    lw s2, 0x44(sp)                 
    lw s3, 0x48(sp)                 
    sw a2, 0x52(sp)                

    # Handle the system call
 
    csrr a2, mepc                   # Read mepc into a2
    addi a2, a2, 4                  # Increment mepc by 4
    csrw mepc, a2                   
    lw a2, 0x52(sp)                 
    mret                            # Return to user mode
