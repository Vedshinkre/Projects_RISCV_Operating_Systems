# RISC-V Operating Systems
This project involves system programming and exception handling in a RISC-V environment for an operating system. The project focuses on developing system calls, memory-mapped I/O handling, and process management, all executed within a simulated RISC-V processor environment.

## Project Overview
## Task 1: System Calls and I/O 
Implemented two system calls:

### System Call 11:
Prints an ASCII character passed in register a0 to the external display.
### System Call 4:
Prints a null-terminated string at the address passed in register a0 on the external display.

## Task 2: Memory-Mapped I/O 
Implemented a program that interacts with both external devices (keyboard and display) using polling:

### Polling-Based I/O:
Reads characters from the keyboard and outputs them on the display in the same order. If the keyboard inputs are faster than the display can process, additional inputs are discarded.

## Task 3: Process Switch and Round-Robin Scheduling 
Implemented a periodic process switch between two non-cooperative processes using round-robin scheduling:

### Process Switching: 
Each process runs for about 300 cycles before switching to the other. The implementation involves saving and restoring the process state to ensure seamless switching.

## Prerequisites
Java and Scala: Ensure you have Java and Scala installed, along with sbt (Simple Build Tool).
Docker: Required for running the RISC-V simulator. Install Docker following the instructions at Get Docker.
