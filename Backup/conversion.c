#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "conversion.h"

// covert to hex from binary : https://cboard.cprogramming.com/cplusplus-programming/81292-converting-binary-string-hex.html
char * convertToHex(char *binstr) { 
    // We expect binstr to be 8 bits or more (so 2 hex characters)
    int len = strlen(binstr);
    if (len % 4 != 0) {
        printf("Binary string length should be a multiple of 4.\n");
        return NULL;
    }

    int hex_len = len / 4;
    char *hexstr = (char *)malloc((hex_len + 1) * sizeof(char)); // +1 for null-terminator
    if (!hexstr) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    for (int i = 0; i < hex_len; i++) {
        char four[5];
        strncpy(four, binstr + (i * 4), 4);
        four[4] = '\0'; // Null-terminate the string

        unsigned int hexnum = 0;
        for (int j = 0; j < 4; ++j) {
            hexnum += (four[j] - '0') << (3 - j); // Convert binary to decimal
        }

        sprintf(hexstr + i, "%X", hexnum); // Convert to hex
    }

    hexstr[hex_len] = '\0'; // Null-terminate the hex string
    return hexstr;
}

// Reverse the string : https://www.geeksforgeeks.org/program-decimal-binary-conversion/
void reverse(char *bin, int left, int right) {
    while (left < right) {
        char temp = bin[left];
        bin[left] = bin[right];
        bin[right] = temp;
        left++;
        right--;
    }
}

// function to convert decimal to binary : https://www.geeksforgeeks.org/program-decimal-binary-conversion/
char* decToBinary(int n) {
    int index = 0;
    char* bin = (char*) malloc(33 * sizeof(char));  // Allocate space for 32-bit binary + '\0'
    if (!bin) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    while (n > 0) {
        int bit = n % 2;
        bin[index++] = '0' + bit;
        n /= 2;
    }
    bin[index] = '\0';

    // Reverse the binary string
    reverse(bin, 0, index - 1);

    // Add leading zeros to make sure we have at least 8 bits
    int length = strlen(bin);
    while (length < 8) {
        for (int i = length; i >= 0; i--) {
            bin[i + 1] = bin[i];
        }
        bin[0] = '0';  // Insert '0' at the beginning
        length++;
    }

    return bin;
}

char * convertOpcode(char* opcode) {
    // on 4 bits
    char *opcode_binary = NULL;

    // on 4 bits (Bench_W, Data_Memory_RW, 2 free bits) == high to low bit
    char *prefix = "1000";  // Default prefix

    if (strcmp(opcode, "AFC") == 0) {
        opcode_binary = AFC_OP;
    } else if (strcmp(opcode, "COP") == 0) {
        opcode_binary = COP_OP;
    } else if (strcmp(opcode, "LOAD") == 0) {
        opcode_binary = LOAD_OP;
    } else if (strcmp(opcode, "STORE") == 0) {
        opcode_binary = STORE_OP;
        prefix = "0100";
    } else if (strcmp(opcode, "ADD") == 0) {
        opcode_binary = ADD_OP;
    } else if (strcmp(opcode, "SUB") == 0) {
        opcode_binary = SUB_OP;
    } else if (strcmp(opcode, "MUL") == 0) {
        opcode_binary = MUL_OP;
    } else if (strcmp(opcode, "DIV") == 0) {
        opcode_binary = DIV_OP;
    } else if (strcmp(opcode, "XOR") == 0) {
        opcode_binary = XOR_OP;
    } else if (strcmp(opcode, "AND") == 0) {
        opcode_binary = AND_OP;
    } else if (strcmp(opcode, "OR") == 0) {
        opcode_binary = OR_OP;
    } else if (strcmp(opcode, "NOTA") == 0) {
        opcode_binary = NOTA_OP;
    } else if (strcmp(opcode, "NOTB") == 0) {
        opcode_binary = NOTB_OP;
    } else if (strcmp(opcode, "NOP") == 0) {
        opcode_binary = NOP_OP;
    } else {
        printf("Invalid opcode.\n");
        return NULL;
    }

    // Allocate enough memory for the concatenated string
    char *result = (char *)malloc(strlen(prefix) + strlen(opcode_binary) + 1);
    if (result == NULL) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    // Concatenate the prefix and the opcode_binary
    strcpy(result, prefix);
    strcat(result, opcode_binary);

    return result;  // Return the binary representation
}

char * convertOperand(char *operand) {
    // Convert operand to binary (8 bits)
    return decToBinary(atoi(operand));
}

char * readInstruction(char *instruction) {
    // INSTRUCTION FORMAT BINARY 
    // A[31:24] OP[23:16] B[15:8] C[7:0]

    // OPCODE 
    char *opcode = strtok(instruction, " \n");
    if (opcode == NULL) {
        printf("Invalid instruction format.\n");
        return NULL;
    }
    printf("Opcode: %s\n", opcode);
    char *OP_binary = convertOpcode(opcode);

    printf("Check OP (Binary): %s\n", OP_binary);

    char *OP_hex = convertToHex(OP_binary);

    // A OPERAND
    char *A_operand = strtok(NULL, " \n");
    if (A_operand == NULL) {
        if (strcmp(opcode, "NOP") == 0 ) {
            A_operand = "0"; // Default to "0" if no operand A
        }
        else{
            printf("Invalid instruction format.\n");
            return NULL;
        }
    }
    printf("A: %s\n", A_operand);
    char *A_binary = convertOperand(A_operand);
    
    // If Opcode is LOAD or STORE, enable Data Memory
    if (strcmp(opcode, "LOAD") == 0 || strcmp(opcode, "STORE") == 0) {
        A_binary[1] = '1'; // Modify A operand binary for Data Memory bit
    }

    printf("Check A (Binary): %s\n", A_binary);

    char *A_hex = convertToHex(A_binary);

    // B OPERAND
    char *B_operand = strtok(NULL, " \n");
    if (B_operand == NULL) {
        if (strcmp(opcode, "NOP") == 0 ) {
            B_operand = "0"; // Default to "0" if no operand B
        }
        else{
            printf("Invalid instruction format.\n");
            return NULL;
        }
    }
    printf("B: %s\n", B_operand);
    char *B_binary = convertOperand(B_operand);

    printf("Check B (Binary): %s\n", B_binary);

    char *B_hex = convertToHex(B_binary);

    // Operand C
    char *C_operand = strtok(NULL, " \n");
    if (C_operand == NULL) {
        C_operand = "0"; // Default to "0" if no operand C
    }
    printf("C: %s\n", C_operand);
    char *C_binary = convertOperand(C_operand);

    printf("Check C (Binary): %s\n", C_binary);

    char *C_hex = convertToHex(C_binary);

    // Concatenate the final binary instruction
    int final_len = strlen(A_hex) + strlen(OP_hex) + strlen(B_hex) + strlen(C_hex) + 1;
    char *final_instruction = (char *)malloc(final_len);
    if (!final_instruction) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    strcpy(final_instruction, A_hex);
    strcat(final_instruction, OP_hex);
    strcat(final_instruction, B_hex);
    strcat(final_instruction, C_hex);

    return final_instruction;  // Return the full binary instruction
}

int main() {
    // Enter an instruction
    printf("Enter an instruction: ");
    char instruction[100];
    fgets(instruction, sizeof(instruction), stdin);

    // Process the instruction and output the binary instruction
    char *instruction_binary = readInstruction(instruction);
    if (instruction_binary != NULL) {
        printf("Binary instruction: %s\n", instruction_binary);
        free(instruction_binary);  // Free allocated memory for final instruction
    }

    return 0;
}
