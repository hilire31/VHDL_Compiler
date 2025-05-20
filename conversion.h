#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define AFC_OP "1010"
#define COP_OP "1110"
#define LOAD_OP "1101"
#define STORE_OP "0101"

#define ADD_OP "0001"
#define SUB_OP "0011"
#define MUL_OP "0010"
#define DIV_OP "0100"
#define XOR_OP "1000"
#define AND_OP "1001"
#define OR_OP "1100"
#define NOTA_OP "1011"
#define NOTB_OP "1111"

char *convertToHex(int decimal);
char *convertOpcode(char *opcode);
char *convertOperand(char *operand);