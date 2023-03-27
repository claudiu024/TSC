/***********************************************************************
 * A SystemVerilog testbench for an instruction register; This file
 * contains the interface to connect the testbench to the design
 **********************************************************************/
interface tb_ifc(input logic clk,input logic test_clk );

import instr_register_pkg::*; 
    logic reset_n;
    logic          load_en;
    operand_t      operand_a, operand_b;
    opcode_t       opcode;
    address_t      write_pointer,read_pointer;
    instruction_t  instruction_word;
    result          r;

     modport TEST (
     input instruction_word,
            test_clk,
     output load_en,
            reset_n,
            operand_a, 
            operand_b,
            opcode,
            write_pointer,
            read_pointer
     );
     modport DUT(
     input clk,
          reset_n,
          load_en,  
          operand_a,
          operand_b,
          opcode,
          write_pointer,
          read_pointer,
    output instruction_word,r
     );

endinterface //interfacename

