#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "conversion.h"

int main () {


    // Enter an instruction
    printf("Enter an instruction: ");
    char instruction[100];
    fgets(instruction, sizeof(instruction), stdin);

    // find OPcode
    char *opcode = strtok(instruction, " ");
    if (opcode == NULL) {
        printf("Invalid instruction format.\n");
        return;
    }
    printf("Opcode: %s\n", opcode);

    // find operand
    char *operand = strtok(NULL, " ");
    if (operand == NULL) {
        printf("Invalid instruction format.\n");
        return;
    }
    
    printf("Operand1: %s\n", operand);

    // find operand2
    char *operand2 = strtok(NULL, " ");
    if (operand2 == NULL) {
        printf("Invalid instruction format.\n");
        return;
    }
    printf("Operand2: %s\n", operand2);

    // find operand3
    char *operand3 = strtok(NULL, " ");
    printf("Operand3: %s\n", operand3);

    return 0;
}


char* convertToHex(int decimal) {
    char hex[10];
    sprintf(hex, "%X", decimal);
    return hex;
}

char* converOpcode(char* opcode){

    if (strcmp(opcode, "AFC") == 0) {
        return AFC_OP;
    } else if (strcmp(opcode, "COP") == 0) {
        return COP_OP;
    } else if (strcmp(opcode, "LOAD") == 0) {
        return LOAD_OP;
    } else if (strcmp(opcode, "STORE") == 0) {
        return STORE_OP;
    } else if (strcmp(opcode, "ADD") == 0) {
        return ADD_OP;
    } else if (strcmp(opcode, "SUB") == 0) {
        return SUB_OP;
    } else if (strcmp(opcode, "MUL") == 0) {
        return MUL_OP;
    } else if (strcmp(opcode, "DIV") == 0) {
        return DIV_OP;
    } else if (strcmp(opcode, "XOR") == 0) {
        return XOR_OP;
    } else if (strcmp(opcode, "AND") == 0) {
        return AND_OP;
    } else if (strcmp(opcode, "OR") == 0) {
        return OR_OP;
    } else if (strcmp(opcode, "NOTA") == 0) {
        return NOTA_OP;
    } else if (strcmp(opcode, "NOTB") == 0) {
        return NOTB_OP;
    }
    else {
        printf("Invalid opcode.\n");
        return NULL;
    }
}