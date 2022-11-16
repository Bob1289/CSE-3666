# convert a number into a single precision floating point number
# and print it out in binary

import sys

def main():
    number = int(input("Enter a number: "))

    # get the sign bit
    if number < 0:
        sign = 1
    else:
        sign = 0

    # get the exponent
    exponent = 0
    while number >= 2:
        number /= 2
        exponent += 1
    while number < 1:
        number *= 2
        exponent -= 1

    # get the mantissa
    mantissa = number - 1

    # print out the sign bit
    print ("Sign bit: %d" % sign)

    # print out the exponent
    print ("Exponent: %d" % exponent)

    # print out the mantissa
    print ("Mantissa: %f" % mantissa)

    # print out the number in binary
    print ("Binary: %d %d %f" % (sign, exponent, mantissa))

main()

