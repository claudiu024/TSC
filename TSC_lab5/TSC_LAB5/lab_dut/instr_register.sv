/***********************************************************************
 * A SystemVerilog RTL model of an instruction regisgter
 *
 * An error can be injected into the design by invoking compilation with
 * the option:  +define+FORCE_LOAD_ERROR
 *
 **********************************************************************/

<<<<<<< HEAD
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
=======

// endinterface //interfacename
module instr_register
import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
(tb_ifc.DUT i_tb_ifc
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
);
  timeunit 1ns/1ns;

  instruction_t  iw_reg [0:31];  // an array of instruction_word structures

  // write to the register
<<<<<<< HEAD
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
=======
  always@(posedge i_tb_ifc.clk, negedge i_tb_ifc.reset_n)   // write into register
    if (!i_tb_ifc.reset_n) begin
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
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
<<<<<<< HEAD
  assign interface_i.instruction_word = iw_reg[interface_i.read_pointer];  // continuously read from register
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
  assign i_tb_ifc.instruction_word = iw_reg[i_tb_ifc.read_pointer];  // continuously read from register
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3

  

// compile with +define+FORCE_LOAD_ERROR to inject a functional bug for verification to catch
`ifdef FORCE_LOAD_ERROR
initial begin
<<<<<<< HEAD
<<<<<<< HEAD
  force i_tb_ifc.operand_b = i_tb_ifc.operand_a; // cause wrong value to be loaded into operand_b
=======
  force interface_i.operand_b = interface_i.operand_a; // cause wrong value to be loaded into operand_b
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
  force i_tb_ifc.operand_b = i_tb_ifc.operand_a; // cause wrong value to be loaded into operand_b
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
end
`endif

endmodule: instr_register
