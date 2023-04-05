/***********************************************************************
 * A SystemVerilog top-level netlist to connect testbench to DUT
 **********************************************************************/

module top;
  timeunit 1ns/1ns; //directiva de compilator,unitatea de timp si pasul de 1ns

  // user-defined types are defined in instr_register_pkg.sv
  import instr_register_pkg::*;
  
  // clock variables
  logic clk;
  logic test_clk;
  logic reset_n;

<<<<<<< HEAD
tb_ifc i_tb_ifc(clk,test_clk);
// interface_n interface_i2(test_clk);
  // instantiate testbench and connect ports
  instr_register_test test (
    i_tb_ifc
=======
  // // interconnecting signals
  // logic          load_en;
  // logic          reset_n;
  // opcode_t       opcode;
  // operand_t      operand_a, operand_b;
  // address_t      write_pointer, read_pointer;
  // instruction_t  instruction_word;
interface_n interface_i(clk);
// interface_n interface_i2(test_clk);
  // instantiate testbench and connect ports
  instr_register_test test (
    interface_i.TEST
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
   );

  // instantiate design and connect ports
  instr_register dut (
<<<<<<< HEAD
  i_tb_ifc
=======
  interface_i.DUT
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
   );

  // clock oscillators
  initial begin
   clk <= 0;
    forever #5  clk = ~clk;
  end

  initial begin
   test_clk <=0;
    // offset test_clk edges from clk to prevent races between
    // the testbench and the design
    #4 forever begin
      #2ns test_clk = 1'b1;
      #8ns test_clk = 1'b0;
    end
  end

endmodule: top
