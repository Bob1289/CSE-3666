from myhdl import block, always_comb, instances, intbv, Signal
from alu1 import ALU1bit

@block
def ALU4bits(a, b, alu_operation, result, zero):

    """ 4-bit ALU

        See the diagram for details. 

    """
    bnegate = alu_operation(2)      # bit 2 in alu_operation
    # like any range in Python, upper bound is open and lower is closed. 
    operation = alu_operation(2,0)  # bits 1 and 0

    c1 = Signal(intbv(0)[1:]) 
    c2 = Signal(intbv(0)[1:])
    c3 = Signal(intbv(0)[1:])
    c4 = Signal(intbv(0)[1:])

    result0 = Signal(intbv(0)[1:]) 
    result1 = Signal(intbv(0)[1:])
    result2 = Signal(intbv(0)[1:])
    result3 = Signal(intbv(0)[1:])

    alu1_0 = ALU1bit(a(0), b(0), bnegate, bnegate, operation, result0, c1)
    alu1_1 = ALU1bit(a(1), b(1), c1, bnegate, operation, result1, c2)
    alu1_2 = ALU1bit(a(2), b(2), c2, bnegate, operation, result2, c3)
    alu1_3 = ALU1bit(a(3), b(3), c3, bnegate, operation, result3, c4)

    @always_comb
    def comb_output():
        result.next[0] = result0
        result.next[1] = result1
        result.next[2] = result2
        result.next[3] = result3
        zero.next = not (result0 or result1 or result2 or result3)

    # return all logic  
    return instances()

if __name__ == "__main__":
    from myhdl import delay, instance, StopSimulation, bin
    import argparse

    # testbench itself is a block
    @block
    def test_comb(args):

        # create signals
        # use intbv for multiple bits
        a = Signal(intbv(0)[4:])
        b = Signal(intbv(0)[4:])
        result = Signal(intbv(0)[4:0])
        alu_operation = Signal(intbv(0)[4:])
        zero = Signal(bool(0))

        # instantiating a block
        alu = ALU4bits(a, b, alu_operation, result, zero)

        @instance
        def stimulus():
            print("ALU_operation a     b    | result zero")
            for op in args.operation_list:
                alu_operation.next = op
                for i in range(16):
                    bi = intbv(i)
                    a.next = args.a
                    b.next = bi[4:]
                    yield delay(10)
                    print("{:12}  {}  {} | {}   {}".format(
                        bin(op, 4), bin(a, 4), bin(b, 4),
                        bin(result, 4), int(zero)))

            # stop simulation
            raise StopSimulation()

        return alu, stimulus

    operation_list = [-1, 0, 1, 2, 6]
    parser = argparse.ArgumentParser(description='4-bit ALU')
    parser.add_argument('op', nargs='?', type=int, default=-1, choices=operation_list, 
            help='alu operation in decimal. -1 for all operations')

    parser.add_argument('-a', type=int, default=0b1010, help='input a in decimal')
    parser.add_argument('--trace', action='store_true', help='generate trace file')

    args = parser.parse_args()
    # print(args)

    if args.op < 0:
        args.operation_list = operation_list[1:]
    else:
        args.operation_list = [args.op]

    tb = test_comb(args)
    tb.config_sim(trace=args.trace)
    tb.run_sim()
