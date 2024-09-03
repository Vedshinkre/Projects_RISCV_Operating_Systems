# TODO: wait for keyboard input
# TODO: read keyboard input
# TODO: wait for display ready
# TODO: print keyboard input to display
# TODO: start again 

_start: 
    la t0, exception_handler        # setting up exception handler
    csrw mtvec, t0                  # ...
     # Set machine trap-vector base address to t0
   
   
                              # return to user mode

exception_handler:
    
    # TODO: save registers you need to handle the exception
    sw t3, 0x0(sp)
    sw t4 ,0x4(sp)
    sw t1, 0x8(sp)
    sw t6, 0x12(sp)
    sw a4, 0x16(sp)
    sw t2, 0x20(sp)
    sw  a3, 0x20(sp)
    sw  a0 , 0x24(sp)
    sw  s1, 0x28(sp)
    sw  a6 , 0x32(sp)
    sw  t5 , 0x36(sp)
    li s1, 1
    la a6 , display_data
    csrr t3, mcause
    csrr t5, mstatus  # check the status and getting the display to register
    j printchar
      
    mret

    

    

   
    
    printchar:
    la a4, display_ready
    lw t2,0(a4)
    beqz t2 printchar 
    keyboard:          # unsure wait until the bit turns 1
    la t3 , keyboard_ready # adding the data to keyboard if it is ready 
    lw t2,0(t3)
    beqz t2, keyboard
    la a4 , keyboard_data




    
    
                    # a0 is the value from the keyboard
    lw t3, 0(a4)
    sw   t3, 0(a6)
    j exit
    



    printstring:
    la a4, display_ready
    loop2:
    lw t2,0(a4)  # unsure wait until the bit turns 1
    beq t2, s1, printfullstring # printing one by one the whole input
    j loop2

    printfullstring:
    lb t3, 0(a0)
    sb   t3, 0(a6)
    beqz t3, exit
    addi a0, a0, 1
    
   

    
    j printfullstring

       

    





    
            
    
    exit:
    lw t3, 0x0(sp)
    lw t4 ,0x4(sp)
    lw t1, 0x8(sp)
    lw t6, 0x12(sp)
    lw a4, 0x16(sp)
    lw t2, 0x20(sp)
    lw  a3, 0x20(sp)
    lw  a0 , 0x24(sp)

    lw  s1, 0x28(sp)
    lw  a6 , 0x32(sp)
    lw  t5 , 0x36(sp)
    

   
    # TODO: handle the system call
    # TODO: restore registers you saved and return to user mode
    
    mret
 