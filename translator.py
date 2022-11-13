

def r_type(instruction):
    # Get the opcode
    opcode = instruction[0:6]
    # Get the rd
    rd = instruction[6:11]
    # Get funct3
    funct3 = instruction[11:14]
    # Get rs1
    rs1 = instruction[14:19]
    # Get rs2
    rs2 = instruction[19:24]
    # Get funct7
    funct7 = instruction[24:31]
    # Print out all the values
    print("opcode: " + opcode)
    print("rd: " + rd)
    print("funct3: " + funct3)
    print("rs1: " + rs1)
    print("rs2: " + rs2)
    print("funct7: " + funct7)

def i_type(instruction):
    # Get the opcode
    opcode = instruction[0:6]
    # Get the rd
    rd = instruction[6:11]
    # Get funct3
    funct3 = instruction[11:14]
    # Get rs1
    rs1 = instruction[14:19]
    # Get immediate
    immediate = instruction[19:31]
    # Print out all the values
    print("opcode: " + opcode)
    print("rd: " + rd)
    print("funct3: " + funct3)
    print("rs1: " + rs1)
    print("immediate: " + immediate)
    