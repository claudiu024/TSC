/***********************************************************************
 * A SystemVerilog RTL model of an instruction regisgter
 *
 * An error can be injected into the design by invoking compilation with
 * the option:  +define+FORCE_LOAD_ERROR
 *
 **********************************************************************/


// endinterface //interfacename
module instr_register
import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
(tb_ifc.DUT i_tb_ifc
);
  timeunit 1ns/1ns;

  instruction_t  iw_reg [0:31];  // an array of instruction_word structures

  // write to the register
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

  

// compile with +define+FORCE_LOAD_ERROR to inject a functional bug for verification to catch
`ifdef FORCE_LOAD_ERROR
initial begin
  force i_tb_ifc.operand_b = i_tb_ifc.operand_a; // cause wrong value to be loaded into operand_b
end
`endif

endmodule: instr_register
