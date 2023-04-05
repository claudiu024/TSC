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

<<<<<<< HEAD

// endinterface //interfacename
module instr_register
import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
(tb_ifc.DUT i_tb_ifc
=======
endinterface //interfacename
module instr_register
import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
(interface_n interface_i
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
);
  timeunit 1ns/1ns;

  instruction_t  iw_reg [0:31];  // an array of instruction_word structures

  // write to the register
<<<<<<< HEAD
  always@(posedge i_tb_ifc.clk, negedge i_tb_ifc.reset_n)   // write into register
    if (!i_tb_ifc.reset_n) begin
      foreach (iw_reg[i])
      iw_reg[i] = '{opc:ZERO,default:0};  // reset to all zeros
    end
    else if (i_tb_ifc.load_en) begin

      case (i_tb_ifc.opcode) 

    ZERO : i_tb_ifc.r = 0 ;
    PASSA :i_tb_ifc.r =i_tb_ifc.operand_a;
    PASSB: i_tb_ifc.r=i_tb_ifc.operand_b;
    ADD: i_tb_ifc.r=i_tb_ifc.operand_a + i_tb_ifc.operand_b;
    SUB:i_tb_ifc.r=i_tb_ifc.operand_a - i_tb_ifc.operand_b;
    MULT:i_tb_ifc.r=i_tb_ifc.operand_a * i_tb_ifc.operand_b;
    DIV:i_tb_ifc.r=i_tb_ifc.operand_a / i_tb_ifc.operand_b;
    MOD:i_tb_ifc.r=i_tb_ifc.operand_a % i_tb_ifc.operand_b;
endcase

      iw_reg[i_tb_ifc.write_pointer] = '{i_tb_ifc.opcode,i_tb_ifc.operand_a,i_tb_ifc.operand_b,i_tb_ifc.r};
    end

  // read from the register
  assign i_tb_ifc.instruction_word = iw_reg[i_tb_ifc.read_pointer];  // continuously read from register
=======
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
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb

  

// compile with +define+FORCE_LOAD_ERROR to inject a functional bug for verification to catch
`ifdef FORCE_LOAD_ERROR
initial begin
<<<<<<< HEAD
  force i_tb_ifc.operand_b = i_tb_ifc.operand_a; // cause wrong value to be loaded into operand_b
=======
  force interface_i.operand_b = interface_i.operand_a; // cause wrong value to be loaded into operand_b
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
end
`endif

endmodule: instr_register
