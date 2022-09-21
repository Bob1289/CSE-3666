# Find GCD (Greatest Common Divisor)

**Deadline:** Sat, 9/10/2022

*If you work on a lab computer or UConn AnyWare Desktop, save your files to
cloud storage like OneDrive. Otherwise, you may lose your files.*

Write concise comments in code.

## Learning Objectives

* Write and run RISC-V programs in RARS. See 
  [this page](https://github.com/zhijieshi/cse3666/blob/master/misc/rars.md) on 
  how to install RARS and run RISC-V programs in RARS. 

* Program with RISC-V arithmetic and control flow instructions. 

* Learn RISC-V assembly language syntax and assembler directives like .text and 
  .globl.

* Read and learn from help files and documentation.

## Description

In this lab, we write a program in RISC-V assembly language that finds
the GCD of two positive integers.

The program reads two positive integers, and then computes and prints their
GCD.  The algorithm we use is Euclidean algorithm. Although it is common to use
division in the algorithm, we will use subtraction only, as originally
described by Euclid. The pseudocode is provided below.

```
# Given two positive integers a, b, repeatedly subtract the smaller one from the larger one
# until the two integers are the same. 

WHILE (a != b) 
    IF (a > b) 
        a = a - b
    ELSE 
        b = b - a
```

Skeleton code in `lab1.s` already has the instructions to read two integer and
save them in `s1` and `s2`. Implement the following steps with RISC-V
instructions to complete the program. 

*   Compute the GCD of the two numbers with Euclidean algorithm by subtraction.

    Do not mix while and if-else code. If-else should be enclosed by, not mixed
    with, the instructions controlling the loop.

*   Print the GCD in decimal with a system call. There is no need to print a newline character after it.

    The list of system calls is in RARS's help file. Select menu "Help/Help" and then select "Syscalls" tab. 
    Scroll up to the beginning of the page if necessary. **There is an example before the table.**

    The skeleton code has the instructions for reading integers. Check wether you can write the instructions from
    the information in the system call table.

The skeleton code includes some GCD examples. Please test your code with more
positive numbers.  

## Deliverables

Please submit lab1.s and take lab1-test in HuskyCT by the deadline.

## Tips

* It can be faster to use keyboard shortcuts to assemble/run/reset the program.

* Use breakpoints and backsteps to debug.

