//
// Created by M on 08/11/2026.
//

#ifndef UNTITLED_REGISTERS_H
#define UNTITLED_REGISTERS_H


typedef union xpto {
    u_int16_t R16[(4 + 4 + 2 + 2 + 1)] = {};
    u_int8_t  R8 [(4 + 4 + 2 + 2 + 1) * 2];
} REG_MEMORY;

REG_MEMORY regs;


#define BC 0
#define B  1
#define C  0



#define REG8(base) regs.R8[base]
#define REG16(base) regs.R16[base]








#endif //UNTITLED_REGISTERS_H
