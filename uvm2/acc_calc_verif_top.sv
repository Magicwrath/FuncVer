module acc_calc_verif_top;

   import uvm_pkg::*;           // import the UVM library
`include "uvm_macros.svh";      // include the UVM macros

   import acc_calc_test_pkg::*; // include the test package

   //define the aclk and aresetn signals
   logic aclk;
   logic aresetn;

   //DUV interface
   acc_calc_if acc_calc_vif(aclk, aresetn);

   //DUV
   /*INSTANTIATE HERE*/

   //set the virtual interface in config_db and run test
   initial begin
      uvm_config_db#(virtual acc_calc_if)::set(null, "uvm_test_top.env", "acc_calc_if", acc_calc_vif);
      run_test();
   end

   //clock and reset initialization
   initial begin
      aclk <= 0;
      aresetn <= 0;
      #50 aresetn <= 1;
   end

   //clock generation
   always #10 aclk = ~aclk;
   
endmodule : acc_calc_verif_top
