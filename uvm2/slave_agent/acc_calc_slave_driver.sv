`ifndef ACC_CALC_SLAVE_DRIVER_SV
 `define ACC_CALC_SLAVE_DRIVER_SV

//this driver will only drive the m00_axis_tready signal
//the rest of the signals are driven by acc_calc_ip
class acc_calc_slave_driver extends uvm_driver#(acc_calc_slave_seq_item);

   //UVM factory registration
   `uvm_component_utils(acc_calc_slave_driver);

   //virtual interface of the DUV
   virtual interface acc_calc_if vif;

   //constructor
   function new(string name = "acc_calc_slave_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   //connect phase, get the interface from the configuration database
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      if(!uvm_config_db#(virtual acc_calc_if)::get(this, "", "acc_calc_if", vif))
        `uvm_fatal("NO_VIF", {"virtual interface must be set for: ", get_full_name(), ".vif"})
   endfunction : connect_phase

   //main phase, signal driving happens here
   task main_phase(uvm_phase phase);
      //forever repeat the handshake protocol with the sequencer
      forever begin
         //fetch sequence item from the sequencer
         seq_item_port.get_next_item(req);

         //drive the transaction
         drive_tr(req);

         //finish the handshake
         seq_item_port.item_done();
      end
   endtask : main_phase
endclass : acc_calc_slave_driver

//task for driving transactions
task drive_tr(ref acc_calc_slave_seq_item tr);
   //wait for reset to go high
   @(posedge vif.aclk iff vif.aresetn = 1);

   //assert the tready signal
   vif.m00_axis_tready <= 1'b1;

   //wait for tvalid, and count the delay in cycles
   while(vif.m00_axis_tvalid != 1) begin
      @(posedge vif.aclk);
      tr.delay++;
   end

   //we have a response, record the data
   tr.m00_axis_tdata = vif.m00_axis_tdata;

   //record the m00_axis_tlast signal asserted by the DUV
   tr.m00_axis_tlast = vif.m00_axis_tlast;

   //deassert the ready signal
   vif.m00_axis_tready <= 1'b0;

   //wait for one clock cycle
   @(posedge vif.aclk);
endtask : drive_tr

`endif
