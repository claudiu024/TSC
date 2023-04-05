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

tb_ifc i_tb_ifc(clk,test_clk);
// interface_n interface_i2(test_clk);
  // instantiate testbench and connect ports
  instr_register_test test (
    i_tb_ifc
   );

  // instantiate design and connect ports
  instr_register dut (
  i_tb_ifc
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
