/***********************************************************************
 * A SystemVerilog RTL model of an instruction regisgter
 *
 * An error can be injected into the design by invoking compilation with
 * the option:  +define+FORCE_LOAD_ERROR
 *
 **********************************************************************/
interface interface_n
import instr_register_pkg::*; (input logic clk);
    logic load_en,reset_n;
    operand_t  operand_a, operand_b;
    opcode_t       opcode;
    address_t      write_pointer,
       read_pointer;
     instruction_t  instruction_word;
     result r;
     modport TEST (
     input clk,instruction_word,
     output load_en,reset_n,operand_a, operand_b,opcode,write_pointer,read_pointer
     );
     modport DUT(
      input           clk,
 input           load_en,
 input            reset_n,
 input        operand_a,
 input        operand_b,
 input         opcode,
 input       write_pointer,
 input       read_pointer,
 output  instruction_word,
  output  r
     );

endinterface //interfacename
module instr_register
import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
(interface_n interface_i
);
  timeunit 1ns/1ns;

  instruction_t  iw_reg [0:31];  // an array of instruction_word structures

  // write to the register
  always@(posedge interface_i.clk, negedge interface_i.reset_n)   // write into register
    if (!interface_i.reset_n) begin
      foreach (iw_reg[i])
      iw_reg[i] = '{opc:ZERO,default:0};  // reset to all zeros
    end
    else if (interface_i.load_en) begin

      case (interface_i.opcode) 

    ZERO : interface_i.r = 0 ;
    PASSA :interface_i.r =interface_i.operand_a;
    PASSB: interface_i.r=interface_i.operand_b;
    ADD: interface_i.r=interface_i.operand_a + interface_i.operand_b;
    SUB:interface_i.r=interface_i.operand_a - interface_i.operand_b;
    MULT:interface_i.r=interface_i.operand_a * interface_i.operand_b;
    DIV:interface_i.r=interface_i.operand_a / interface_i.operand_b;
    MOD:interface_i.r=interface_i.operand_a % interface_i.operand_b;
endcase

      iw_reg[interface_i.write_pointer] = '{interface_i.opcode,interface_i.operand_a,interface_i.operand_b,interface_i.r};
    end

  // read from the register
  assign interface_i.instruction_word = iw_reg[interface_i.read_pointer];  // continuously read from register

  

// compile with +define+FORCE_LOAD_ERROR to inject a functional bug for verification to catch
`ifdef FORCE_LOAD_ERROR
initial begin
  force interface_i.operand_b = interface_i.operand_a; // cause wrong value to be loaded into operand_b
end
`endif

endmodule: instr_register
