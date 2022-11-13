from myhdl import block, always_comb, instances

#tag: 05eb34c212e66135b3439924f3b04399

@block
def ALU1bit(a, b, carryin, binvert, operation, result, carryout):

    # internal signals
    notb = Signal(bool(0))
    mux1_out, and_out, or_out, adder_sum = (Signal(bool(0)), 
                            Signal(bool(0)), Signal(bool(0)), Signal(bool(0)))

    # we can read/set these signals (input, output, and internal) in submodules

    # the 'always_comb' decorator indicates a combinational circuit 
    # funciton name is not important. we could name it 'a_circuit' 
    # MyHDL analyzes code and adds Signals (of MyHDL Signal type) that appear
    # on the right hand side of any statements to a sentitivity list. 
    # In this example, if b's value changed, this function com_not is called
    # and notb will get a new value, which will trigger other submodules.
    @always_comb
    def comb_not():
        # all signals in this lab have only 1 bit. 
        # we can use 'and', 'or', 'not' operators
        notb.next = not b

        # if we use &, |, or ~, use a mask, e.g., "& 1" to keep the LSB only
        # notb.next = (~ b) & 1

    # the 2-1 MUX that generates mux1_out
    @always_comb
    def comb_mux_2_1():
        # Use if-elif. Remember to do "result.next = ..."
        # Remember to use mux1_out.next = ...
        mux1_out.next = (not binvert and b) or (binvert and notb)


    # the AND gate
    @always_comb
    def comb_and():
        and_out.next = a and mux1_out

    # the OR gate
    @always_comb
    def comb_or():
        or_out.next = a or mux1_out

    # adder.
    # there are two outputs: adder_sum and carryout
    # the lecture slides have the logic equations.
    # If you use bitwise operators, remember to clear 
    # other bits except for the LSB
    @always_comb
    def comb_adder():
        adder_sum.next = a ^ mux1_out ^ carryin
        carryout.next = (carryin and a ^ mux1_out) or (a and mux1_out)


    # 4-1 mux to generate result
    @always_comb
    def comb_mux_4_1():
        # Use if-elif-else. Remember to do "result.next = ..."
        if operation == 0:
            result.next = and_out
        elif operation == 1:
            result.next = or_out
        elif operation == 2:
            result.next = adder_sum
        else:
            result.next = 0

    # return all the functions/submodules 
    # we could list them explicitly, like
    #     return comb_not, comb_and, ...

    return instances()

if __name__ == "__main__":
    from myhdl import intbv, delay, instance, Signal, StopSimulation, bin
    import argparse

    # testbench itself is a block
    @block
    def test_comb(args):

        # create signals
        result = Signal(bool(0))
        carryout = Signal(bool(0))

        a, b, carryin, binvert = [Signal(bool(0)) for i in range(4)]

        # operation has two bits
        operation = Signal(intbv(0)[2:])

        # instantiating a block
        alu1 = ALU1bit(a, b, carryin, binvert, operation, result, carryout)

        @instance
        def stimulus():
            print("op a b cin bneg | cout res")
            for op in args.op:
                assert 0 <= op <= 3
                for i in range(16):
                    # use MyHDL intbv to split bits, instead of shift and AND
                    bi = intbv(i)
                    a.next, b.next, carryin.next, binvert.next = \
                        bi[0], bi[1], bi[2], bi[3]
                    operation.next = op
                    yield delay(10)
                    print("{} {} {} {}   {}    | {}    {}".format(
                        bin(op, 2), 
                        int(a), int(b), int(carryin), int(binvert), 
                        int(carryout), int(result)))

            # stop simulation
            raise StopSimulation()

        return alu1, stimulus

    parser = argparse.ArgumentParser(description='Testing 1-bit ALU')
    parser.add_argument('op', type=int, nargs='*', 
            default=[0, 1, 2], help='operation')
    parser.add_argument('--trace', action='store_true', help='generate trace')
    parser.add_argument('--verbose', '-v', action='store_true', help='verbose')

    args = parser.parse_args()
    if args.verbose:
        print(args)

    tb = test_comb(args)
    tb.config_sim(trace=args.trace)
    tb.run_sim()