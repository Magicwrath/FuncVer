//This sequence will be purely used as a test sequence
//to verify that the environment will successfully generate
//a sequence and monitor the answer

//It will not be included in the finished environment

`ifndef ACC_CALC_MASTER_TEST_SEQ_SV
 `define ACC_CALC_MASTER_TEST_SEQ_SV

class acc_calc_master_test_seq extends acc_calc_master_base_seq;

   `uvm_object_utils(acc_calc_master_test_seq)

   function new(string name = "acc_calc_master_test_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      //send one item
      `uvm_do(req)
   endtask : body

endclass // acc_calc_master_test_seq

`endif
