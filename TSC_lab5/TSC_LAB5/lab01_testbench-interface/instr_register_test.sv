/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * The course labs will convert this to an object-oriented testbench
 * with constrained random test generation, functional coverage, and
 * a scoreboard for self-verification.
 **********************************************************************/

module instr_register_test
  import instr_register_pkg::*;  // user-defined types are defined in instr_register_pkg.sv
<<<<<<< HEAD
<<<<<<< HEAD
  (tb_ifc.TEST i_tb_ifc);
=======
  (interface_n interface_i);
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
  (tb_ifc.TEST i_tb_ifc);
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3

  timeunit 1ns/1ns;

  parameter NUMBEROFTRANSACTIONS =11 ;
  int seed = 555;

  initial begin
    $display("\n\n***********************************************************");
    $display(    "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
    $display(    "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
    $display(    "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
    $display(    "***********************************************************");

    $display("\nReseting the instruction register...");
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
    i_tb_ifc.write_pointer  = 5'h00;         // initialize write pointer
    i_tb_ifc.read_pointer   = 5'h1F;         // initialize read pointer
    i_tb_ifc.load_en        = 1'b0;          // initialize load control line
    i_tb_ifc.reset_n       <= 1'b0;          // assert reset_n (active low)
    repeat (2) @(posedge i_tb_ifc.test_clk) ;     // hold in reset for 2 clock cycles
    i_tb_ifc.reset_n        = 1'b1;          // deassert reset_n (active low)
<<<<<<< HEAD

    $display("\nWriting values to register stack...");
    @(posedge i_tb_ifc.test_clk) i_tb_ifc.load_en = 1'b1;  // enable writing to register
    repeat (NUMBEROFTRANSACTIONS) begin
      @(posedge i_tb_ifc.test_clk) randomize_transaction;
      @(negedge i_tb_ifc.test_clk) print_transaction;
    end
    @(posedge i_tb_ifc.test_clk) i_tb_ifc.load_en = 1'b0;  // turn-off writing to register
=======
    interface_i.write_pointer  = 5'h00;         // initialize write pointer
    interface_i.read_pointer   = 5'h1F;         // initialize read pointer
    interface_i.load_en        = 1'b0;          // initialize load control line
    interface_i.reset_n       <= 1'b0;          // assert reset_n (active low)
    repeat (2) @(posedge interface_i.clk) ;     // hold in reset for 2 clock cycles
    interface_i.reset_n        = 1'b1;          // deassert reset_n (active low)
=======
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3

    $display("\nWriting values to register stack...");
    @(posedge i_tb_ifc.test_clk) i_tb_ifc.load_en = 1'b1;  // enable writing to register
    repeat (NUMBEROFTRANSACTIONS) begin
      @(posedge i_tb_ifc.test_clk) randomize_transaction;
      @(negedge i_tb_ifc.test_clk) print_transaction;
    end
<<<<<<< HEAD
    @(posedge interface_i.clk) interface_i.load_en = 1'b0;  // turn-off writing to register
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
    @(posedge i_tb_ifc.test_clk) i_tb_ifc.load_en = 1'b0;  // turn-off writing to register
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3

    // read back and display same three register locations
    $display("\nReading back the same register locations written...");
    for (int i=0; i<NUMBEROFTRANSACTIONS; i++) begin
      // later labs will replace this loop with iterating through a
      // scoreboard to determine which addresses were written and
      // the expected values to be read back
<<<<<<< HEAD
<<<<<<< HEAD
      @(posedge i_tb_ifc.test_clk) i_tb_ifc.read_pointer = i;
      // i_tb_ifc.read_pointer <= $unsigned($random)%32;
      @(negedge i_tb_ifc.test_clk) print_results;
    end

    @(posedge i_tb_ifc.test_clk) ;
=======
      @(posedge interface_i.clk) interface_i.read_pointer = i;
      // interface_i.read_pointer <= $unsigned($random)%32;
      @(negedge interface_i.clk) print_results;
    end

    @(posedge interface_i.clk) ;
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
      @(posedge i_tb_ifc.test_clk) i_tb_ifc.read_pointer = i;
      // i_tb_ifc.read_pointer <= $unsigned($random)%32;
      @(negedge i_tb_ifc.test_clk) print_results;
    end

    @(posedge i_tb_ifc.test_clk) ;
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
    $display("\n***********************************************************");
    $display(  "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
    $display(  "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
    $display(  "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
    $display(  "***********************************************************\n");
    $finish;
  end

  function void randomize_transaction;
    // A later lab will replace this function with SystemVerilog
    // constrained random values
    //
    // The stactic temp variable is required in order to write to fixed
    // addresses of 0, 1 and 2.  This will be replaceed with randomizeed
    // write_pointer values in a later lab
    //
    static int temp = 0;
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
    i_tb_ifc.operand_a     <= $random(seed)%16;                 // between -15 and 15
    i_tb_ifc.operand_b     <= $unsigned($random)%16;            // between 0 and 15
    i_tb_ifc.opcode        <= opcode_t'($unsigned($random)%8);  // between 0 and 7, cast to opcode_t type
    i_tb_ifc.write_pointer <= temp++;
    // i_tb_ifc.write_pointer <= $unsigned($random)%32;
<<<<<<< HEAD
  endfunction: randomize_transaction

  function void print_transaction;
    $display("Writing to register location %0d: ", i_tb_ifc.write_pointer);
    $display("  opcode = %0d (%s)", i_tb_ifc.opcode, i_tb_ifc.opcode.name);
    $display("  operand_a = %0d",  i_tb_ifc. operand_a);
    $display("  operand_b = %0d\n", i_tb_ifc.operand_b);
  endfunction: print_transaction

  function void print_results;
    $display("Read from register location %0d: ", i_tb_ifc.read_pointer);
    $display("  opcode = %0d (%s)", i_tb_ifc.instruction_word.opc, i_tb_ifc.instruction_word.opc.name);
    $display("  operand_a = %0d",   i_tb_ifc.instruction_word.op_a);
    $display("  operand_b = %0d\n", i_tb_ifc.instruction_word.op_b);
=======
    interface_i.operand_a     <= $random(seed)%16;                 // between -15 and 15
    interface_i.operand_b     <= $unsigned($random)%16;            // between 0 and 15
    interface_i.opcode        <= opcode_t'($unsigned($random)%8);  // between 0 and 7, cast to opcode_t type
    interface_i.write_pointer <= temp++;
    // interface_i.write_pointer <= $unsigned($random)%32;
=======
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
  endfunction: randomize_transaction

  function void print_transaction;
    $display("Writing to register location %0d: ", i_tb_ifc.write_pointer);
    $display("  opcode = %0d (%s)", i_tb_ifc.opcode, i_tb_ifc.opcode.name);
    $display("  operand_a = %0d",  i_tb_ifc. operand_a);
    $display("  operand_b = %0d\n", i_tb_ifc.operand_b);
  endfunction: print_transaction

  function void print_results;
<<<<<<< HEAD
    $display("Read from register location %0d: ", interface_i.read_pointer);
    $display("  opcode = %0d (%s)", interface_i.instruction_word.opc, interface_i.instruction_word.opc.name);
    $display("  operand_a = %0d",   interface_i.instruction_word.op_a);
    $display("  operand_b = %0d\n", interface_i.instruction_word.op_b);
>>>>>>> e80a2e3efdb4b0fae7e852c9018401f7b75dfccb
=======
    $display("Read from register location %0d: ", i_tb_ifc.read_pointer);
    $display("  opcode = %0d (%s)", i_tb_ifc.instruction_word.opc, i_tb_ifc.instruction_word.opc.name);
    $display("  operand_a = %0d",   i_tb_ifc.instruction_word.op_a);
    $display("  operand_b = %0d\n", i_tb_ifc.instruction_word.op_b);
>>>>>>> a7329b9407f7557bcf9af1b9eb8f096b4619c2d3
  endfunction: print_results

endmodule: instr_register_test
