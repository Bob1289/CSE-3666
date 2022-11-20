# Test programs

The test programs are in the `input` directory. The expected outputs are in
`output` directory. The output of the programs depends on the values in
argument registers. The expected output files were generated using the default
values in argument registers, for example, `a0` = 10, `a1` = 11, and so on.
Test the processor and programs with more values. The autograder may test the
submitted code with different values set in argument registers.

We can save the output of the simulator in a file, and then compare it with the
expected output with software tools. However, please examine the output
manually, too. Tools are just helping.

The command syntax for saving program output in a file depends on the OS
and the shell. Here are some examples. The provided output files were
generated by `save-output.ps1` in Powershell Core 7.2.

```
# cmd and Powershell Core on Windows
py rvsim.py input\t-add.txt > t-add-out.txt 

# Windows Powershell 5.x
py rvsim.py input\t-add.txt | out-file -encoding ascii t-add-out.txt

# Linux (Ubuntu). bash
python3 rvsim.py input/t-add.txt > t-add-out.txt 
```

Then we may use a file comparison tool to compare the output of your simulator
with the expected output files. We may need to deal with different line
endings. The provided files have Windows line endings. On Linux, we can use
`dos2unix` program to convert Windows line endings to unix line endings, or ask
the software tool to ignore ending spaces if it is supported.

```
# Linux
# add -Z option if two files have different line ending characters
diff file1 file2

# Windows, if fc.exe is available
fc.exe file1 file2

# Powershell
diff (cat file1) (cat file2)
Compare-Object (Get-Content file1) (Get-Content file2)

# Python with difflib installed
diff.py file1 file2

# if the path is not set, we can specify the full path of diff.py 
py C:\Python310\Tools\script\diff.py file1 file2

#vim
vim -d file1 file2
vimdiff file1 file2
```

##  List of RIS-V test code

Here are brief descriptons of the test programs in input directory. We can see
the instructions in the provided files under the input directory.

*   t-add tests ADD and SUB.

*   t-and tests AND and OR.

*   t-sll tests SLL, SRL, and SRA.

*   t-i tests instructions with immediate.

*   t-sw tests SW and LW.

*   t-beq tests BEQ.

*   reversebytes reverses the order of bytes in a register.

*   fib. Compute Fibonacci sequence until F(n) and save the numbers in memory.
    n is in a0.

*   fact. Compute n! and save the numbers in memory. n is in a0.