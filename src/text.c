
#include "text.h"

uint32_t parseHex(char *str) {
    uint32_t ret = 0;

    int i = 0;
    while (i < 8) {
        ret <<= 4;

        i++;
    }

    return ret;
}

bool parsehex32(char *str, uint32_t *out, bool doRead0, bool doReadX) {
    // 0x starter
    if (doRead0) {
        if (*str != '0') return false;
        str += 1;
    }
    if (doReadX) {
        if (*str != 'x') return false;
        str += 1;
    }

    // iterate through 8 characters
    uint32_t val = 0;
    for (int i = 0; i < 8; ++i) {
        val <<= 4;
        char c = *str;
        if (c >= '0' && c <= '9') {
            val |= (c - '0') & 0xf;
        }
        else if (c >= 'a' && c <= 'f') {
            val |= (c - 'a' + 10) & 0xf;
        }
        else if (c >= 'A' && c <= 'F') {
            val |= (c - 'A' + 10) & 0xf;
        }
        else {
            return false;
        }
        str += 1;
    }

    *out = val;
    return true;
}
