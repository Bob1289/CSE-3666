

#include "stdio.h"

int main(int argc, char *argv[]) {
    long r = 0;
    long a = 3;
    for (int i = 1; i < a; i++){
        for (int j = 0; j < i; j++){
            r += (j ^ 0xAABBCCDD);
        }
    }
    printf("%ld", r + 1);
       
}