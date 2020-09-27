#fetch script file directory
variable dispScriptFile [file normalize [info script]]
proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}

#create a variable for the file directory in which the tcl script is located
set targetFolder [getScriptDirectory]

#create project in the directory, set the board to Zybo Z7-10
create_project acc_calc_verif_project $targetFolder\/acc_calc_verif_project -part xc7z010clg400-1
set_property board_part digilentinc.com:zybo-z7-10:part0:1.0 [current_project]

#add rtl files
add_files -norecurse $targetFolder\/hdl\/rtl\/acc_calc_ip_5.vhd
add_files -norecurse $targetFolder\/hdl/rtl\/cos_sine_samples_pkg.vhd
add_files -norecurse $targetFolder\/hdl\/top\/acc_calc_ip_top.vhd
update_compile_order -fileset sources_1

#variable which contains the file names

#add uvm files
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_slave_test_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_master_base_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/acc_calc_test_pkg.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_driver.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_sequencer.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/test_group2.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_monitor.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_sequencer.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_slave_base_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_master_group2_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/test_base.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_master_test_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_master_group1_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/acc_calc_verif_top.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/acc_calc_scoreboard.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_seq_item.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_seq_item.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_monitor.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/test_simple.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/acc_calc_if.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/test_group1.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/acc_calc_env.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_driver.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_seq_pkg.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_agent.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/master_agent\/acc_calc_master_agent_pkg.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_slave_group2_seq.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/slave_agent\/acc_calc_slave_agent_pkg.sv
set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse $targetFolder\/uvm\/sequences\/acc_calc_slave_group1_seq.sv

update_compile_order -fileset sim_1
update_compile_order -fileset sim_1

#set manual compile order
set_property source_mgmt_mode DisplayOnly [current_project]
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/slave_agent\/acc_calc_slave_agent_pkg.sv $targetFolder\/uvm\/acc_calc_env.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv $targetFolder\/uvm\/master_agent\/acc_calc_master_agent_pkg.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv $targetFolder\/uvm\/master_agent\/acc_calc_master_seq_item.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv $targetFolder\/uvm\/master_agent\/acc_calc_master_sequencer.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv $targetFolder\/uvm\/master_agent\/acc_calc_master_driver.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/master_agent\/acc_calc_master_agent.sv $targetFolder\/uvm\/master_agent\/acc_calc_master_monitor.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/slave_agent\/acc_calc_slave_monitor.sv $targetFolder\/uvm\/slave_agent\/acc_calc_slave_agent_pkg.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/slave_agent\/acc_calc_slave_monitor.sv $targetFolder\/uvm\/slave_agent\/acc_calc_slave_seq_item.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/slave_agent\/acc_calc_slave_monitor.sv $targetFolder\/uvm\/slave_agent\/acc_calc_slave_sequencer.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/slave_agent\/acc_calc_slave_monitor.sv $targetFolder\/uvm\/slave_agent\/acc_calc_slave_driver.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_seq_pkg.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_master_base_seq.sv
reorder_files -fileset sim_1 -after $targetFolder\/uvm\/sequences\/acc_calc_master_base_seq.sv $targetFolder\/uvm\/sequences\/acc_calc_slave_base_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_master_test_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_slave_test_seq.sv
reorder_files -fileset sim_1 -after $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_slave_group1_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_master_group1_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_slave_group1_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_master_group2_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/sequences\/acc_calc_slave_group2_seq.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/acc_calc_test_pkg.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/acc_calc_if.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/acc_calc_env.sv $targetFolder\/uvm\/acc_calc_scoreboard.sv
reorder_files -fileset sim_1 -before $targetFolder\/uvm\/test_base.sv $targetFolder\/uvm\/test_base.sv

#set the project properties to support uvm, set the test to group1
set_property -name {xsim.compile.xvlog.more_options} -value {-L uvm} -objects [get_filesets sim_1]
set_property -name {xsim.elaborate.xelab.more_options} -value {-L uvm} -objects [get_filesets sim_1]
set_property -name {xsim.simulate.xsim.more_options} -value {-testplusarg UVM_TESTNAME=test_group1 -testplusarg UVM_VERBOSITY=UVM_LOW -sv_seed random} -objects [get_filesets sim_1]
