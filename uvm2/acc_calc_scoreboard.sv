`ifndef ACC_CALC_SCOREBOARD_SV
 `define ACC_CALC_SCOREBOARD_SV

//declaring ports here, because there is more than one
`uvm_analysis_imp_decl(_master_tr)
`uvm_analysis_imp_decl(_slave_tr)

class acc_calc_scoreboard extends uvm_scoreboard;

   //control fields
   bit checks_enable = 1;
   bit coverage_enable = 1;

   //number of received transactions
   int unsigned num_of_master_tr = 0;
   int unsigned num_of_slave_tr = 0;

   //TLM ports for communication with Master/Slave agent
   uvm_analysis_imp_master_tr#(acc_calc_master_seq_item, acc_calc_scoreboard) master_port;
   uvm_analysis_imp_slave_tr#(acc_calc_slave_seq_item, acc_calc_scoreboard) slave_port;

   //UVM factory registration
   `uvm_component_utils_begin(acc_calc_scoreboard)
      `uvm_field_int(checks_enable, UVM_DEFAULT)
      `uvm_field_int(coverage_enable, UVM_DEFAULT)
   `uvm_component_utils_end

   //constructor
   function new(string name = "acc_calc_scoreboard", uvm_component parent = null);
      super.new(name, parent);

      //construct the TLM ports
      master_port = new("master_port", this);
      slave_port = new("slave_port", this);
   endfunction : new

   //write function of the TLM ports
   //monitor calls this function when sending transactions
   //through the TLM port
   function void write_master_tr(acc_calc_master_seq_item tr);
      //transaction clone, since we musn't edit the transaction
      //that is passed through the port
      acc_calc_master_seq_item tr_clone;
      $cast(tr_clone, tr.clone());

      //checking is done here
      if(checks_enable) begin
         //checking
      end
   endfunction : write_master_tr

   function void write_slave_tr(acc_calc_slave_seq_item tr);
      //transaction clone, since we musn't edit the transaction
      //that is passed through the port
      acc_calc_slave_seq_item tr_clone;
      $cast(tr_clone, tr.clone());

      //checking is done here
      if(checks_enable) begin
         //checking
      end
   endfunction : write_slave_tr

endclass : acc_calc_scoreboard

`endif
