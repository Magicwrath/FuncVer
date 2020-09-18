`ifndef TEST_SIMPLE_SV
 `define TEST_SIMPLE_SV

//this test will be used to test the basic functionality
//of the environment, it will not be used for verifying the DUV
class test_simple extends test_base;

   //UVM factory registration
   `uvm_component_utils(test_simple)

   //the sequences that will be used
   acc_calc_master_test_seq master_test_seq;
   acc_calc_slave_test_seq master_test_seq;

   //constructor
   function new(string name = "test_simple", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   //build phase, create the sequences
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      master_test_seq = acc_calc_master_test_seq::type_id::create("master_test_seq");
      slave_test_seq = acc_calc_slave_test_seq::type_id::create("slave_test_seq");
   endfunction : build_phase

   //main phase, raise objections, run the sequences, drop objections
   task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      //two threads, since the slave sequence has a forever loop
      //the simulation would never end, so we make a fork - join_any
      //construction, and wait for the master sequence to finish
      fork
         master_test_seq.start(env.master_agent.seqr);
         slave_test_seq.start(env.slave_agent.seqr);
      join_any
      phase.drop_objection(this);
   endtask : main_phase
endclass : test_simple

`endif
