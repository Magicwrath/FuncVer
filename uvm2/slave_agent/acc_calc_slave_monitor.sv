`ifndef ACC_CALC_SLAVE_MONITOR_SV
 `define ACC_CALC_SLAVE_MONITOR_SV

class acc_calc_slave_monitor extends uvm_monitor;

   //control fields
   bit checks_enable = 1;
   bit coverage_enable = 1;

   //TLM port for monitor - scoreboard communication
   uvm_analysis_port#(acc_calc_slave_seq_item) item_collected_port;

   //factory registation
   `uvm_component_utils_begin(acc_calc_slave_monitor)
      `uvm_field_int(checks_enable, UVM_DEFAULT)
      `uvm_field_int(coverage_enable, UVM_DEFAULT)
   `uvm_component_utils_end

   //virtual interface of the DUV
   virtual interface acc_calc_if vif;

   //constructor
   function new(string name = "acc_calc_slave_monitor", uvm_component parent = null);
      super.new(name, parent);

      //create the TLM port
      item_collected_port = new("item_collected_port", this);
   endfunction : new

   //connect phase, fetch virtual interface from config. database here
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      if(!uvm_config_db#(virtual acc_calc_if)::get(this, "", "acc_calc_if", vif))
        `uvm_fatal("NO_VIF", {"virtual interface must be set: ", get_full_name(), ".vif"})
   endfunction : connect_phase

   //main phase, monitor DUV signals here
   task main_phase(uvm_phase phase);
      //sequence items, for storing signal values in a transaction form
      acc_calc_slave_seq_item tr_collected, tr_clone;
      tr_collected = acc_calc_slave_seq_item::type_id::create("tr_collected");

      //monitor DUV signals and store in a transaction
      forever begin
         //wait for aresetn to go high
         @(posedge vif.aclk iff vif.aresetn = 1);

         //wait for the DUV to assert the tvalid signal
         @(posedge vif.aclk iff vif.m00_axis_tvalid = 1);
         #1;

         //record the data and tlast signal
         tr_collected.m00_axis_tdata = vif.m00_axis_tdata;
         tr_collected.m00_axis_tlast = vif.m00_axis_tlast;

         //detect if a handshake has happened
         @(posedge vif.aclk iff vif.m00_axis_tready = 1);
         @(posedge vif.aclk iff vif.m00_axis_tready = 0);
         `uvm_info(get_full_name(), "Handshake finished", UVM_HIGH)
         //clone the transaction and send it through the TLM port
         $cast(tr_clone, tr_collected.clone());
         item_collected_port.write(tr_clone);
      end

   endtask : main_phase

endclass : acc_calc_slave_monitor

`endif
