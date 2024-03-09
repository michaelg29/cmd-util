
#include <stdio.h>
#include <stdlib.h>

#include "cmd_util.h"
#include "text.h"

void usage(char **argv) {
    printf("USAGE: %s (x<hex32>)|(<float>)\n", argv[0]);
    printf("  hex32: 32-bit hexadecimal value (8 digits)\n");
    printf("  float: floating point value\n");
}

int main(int argc, char **argv) {
    if (argc != 2) {
        usage(argv);
        return 1;
    }

    // parsed values
    uint32_t uval;
    float fval;

    if (argv[1][0] == 'x') {
        // parse hexadecimal value
        parsehex32(argv[1], &uval, false, true);
        printf("Entered 0x%08x\n", uval);

        // convert
        fval = *(float*)&uval;
    }
    else {
        // parse float
        fval = strtof(argv[1], NULL);

        // convert
        uval = *(uint32_t*)&fval;
    }

    // print components
    printf("Hex32: 0x%08x\n", uval);
    printf("Float: %f\n", fval);
    printf("Sign: %d\n", uval >> 31);
    printf("Exponent: %02x\n", (uval >> 23) & 0xff, (uval >> 23) & 0xff);
    printf("Mantissa: %06x\n", uval & 0x007fffff, uval & 0x007fffff);

    return 0;
}
