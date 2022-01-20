
# (C) 2001-2022 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 18.1 625 linux 2022.01.13.13:08:29
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     soc_system
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "aldec.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/aldec/rivierapro_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog -sv2k5 <your compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If soc_system is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "soc_system"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "/home/kris/intelFPGA/18.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ociram_default_contents.hex ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ociram_default_contents.dat ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ociram_default_contents.mif ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_b.hex ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_b.dat ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_b.mif ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_a.hex ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_a.dat ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_rf_ram_a.mif ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_bht_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_bht_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_bht_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ic_tag_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ic_tag_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_ic_tag_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/soc_system_onchip_memory2_0.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                                                                    ./libraries/altera_common_sv_packages                                         
vmap       altera_common_sv_packages                                          ./libraries/altera_common_sv_packages                                         
ensure_lib                                                                    ./libraries/error_adapter_0                                                   
vmap       error_adapter_0                                                    ./libraries/error_adapter_0                                                   
ensure_lib                                                                    ./libraries/border                                                            
vmap       border                                                             ./libraries/border                                                            
ensure_lib                                                                    ./libraries/avalon_st_adapter_006                                             
vmap       avalon_st_adapter_006                                              ./libraries/avalon_st_adapter_006                                             
ensure_lib                                                                    ./libraries/avalon_st_adapter_001                                             
vmap       avalon_st_adapter_001                                              ./libraries/avalon_st_adapter_001                                             
ensure_lib                                                                    ./libraries/avalon_st_adapter                                                 
vmap       avalon_st_adapter                                                  ./libraries/avalon_st_adapter                                                 
ensure_lib                                                                    ./libraries/crosser                                                           
vmap       crosser                                                            ./libraries/crosser                                                           
ensure_lib                                                                    ./libraries/lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter
vmap       lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter ./libraries/lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter
ensure_lib                                                                    ./libraries/rsp_mux_003                                                       
vmap       rsp_mux_003                                                        ./libraries/rsp_mux_003                                                       
ensure_lib                                                                    ./libraries/rsp_mux_002                                                       
vmap       rsp_mux_002                                                        ./libraries/rsp_mux_002                                                       
ensure_lib                                                                    ./libraries/rsp_mux_001                                                       
vmap       rsp_mux_001                                                        ./libraries/rsp_mux_001                                                       
ensure_lib                                                                    ./libraries/rsp_mux                                                           
vmap       rsp_mux                                                            ./libraries/rsp_mux                                                           
ensure_lib                                                                    ./libraries/rsp_demux_006                                                     
vmap       rsp_demux_006                                                      ./libraries/rsp_demux_006                                                     
ensure_lib                                                                    ./libraries/rsp_demux_005                                                     
vmap       rsp_demux_005                                                      ./libraries/rsp_demux_005                                                     
ensure_lib                                                                    ./libraries/rsp_demux_002                                                     
vmap       rsp_demux_002                                                      ./libraries/rsp_demux_002                                                     
ensure_lib                                                                    ./libraries/rsp_demux_001                                                     
vmap       rsp_demux_001                                                      ./libraries/rsp_demux_001                                                     
ensure_lib                                                                    ./libraries/rsp_demux                                                         
vmap       rsp_demux                                                          ./libraries/rsp_demux                                                         
ensure_lib                                                                    ./libraries/cmd_mux_006                                                       
vmap       cmd_mux_006                                                        ./libraries/cmd_mux_006                                                       
ensure_lib                                                                    ./libraries/cmd_mux_005                                                       
vmap       cmd_mux_005                                                        ./libraries/cmd_mux_005                                                       
ensure_lib                                                                    ./libraries/cmd_mux_003                                                       
vmap       cmd_mux_003                                                        ./libraries/cmd_mux_003                                                       
ensure_lib                                                                    ./libraries/cmd_mux_002                                                       
vmap       cmd_mux_002                                                        ./libraries/cmd_mux_002                                                       
ensure_lib                                                                    ./libraries/cmd_mux_001                                                       
vmap       cmd_mux_001                                                        ./libraries/cmd_mux_001                                                       
ensure_lib                                                                    ./libraries/cmd_mux                                                           
vmap       cmd_mux                                                            ./libraries/cmd_mux                                                           
ensure_lib                                                                    ./libraries/cmd_demux_003                                                     
vmap       cmd_demux_003                                                      ./libraries/cmd_demux_003                                                     
ensure_lib                                                                    ./libraries/cmd_demux_002                                                     
vmap       cmd_demux_002                                                      ./libraries/cmd_demux_002                                                     
ensure_lib                                                                    ./libraries/cmd_demux_001                                                     
vmap       cmd_demux_001                                                      ./libraries/cmd_demux_001                                                     
ensure_lib                                                                    ./libraries/cmd_demux                                                         
vmap       cmd_demux                                                          ./libraries/cmd_demux                                                         
ensure_lib                                                                    ./libraries/sdram_controller_0_s1_burst_adapter                               
vmap       sdram_controller_0_s1_burst_adapter                                ./libraries/sdram_controller_0_s1_burst_adapter                               
ensure_lib                                                                    ./libraries/nios2_gen2_0_instruction_master_limiter                           
vmap       nios2_gen2_0_instruction_master_limiter                            ./libraries/nios2_gen2_0_instruction_master_limiter                           
ensure_lib                                                                    ./libraries/router_013                                                        
vmap       router_013                                                         ./libraries/router_013                                                        
ensure_lib                                                                    ./libraries/router_012                                                        
vmap       router_012                                                         ./libraries/router_012                                                        
ensure_lib                                                                    ./libraries/router_010                                                        
vmap       router_010                                                         ./libraries/router_010                                                        
ensure_lib                                                                    ./libraries/router_009                                                        
vmap       router_009                                                         ./libraries/router_009                                                        
ensure_lib                                                                    ./libraries/router_008                                                        
vmap       router_008                                                         ./libraries/router_008                                                        
ensure_lib                                                                    ./libraries/router_007                                                        
vmap       router_007                                                         ./libraries/router_007                                                        
ensure_lib                                                                    ./libraries/router_005                                                        
vmap       router_005                                                         ./libraries/router_005                                                        
ensure_lib                                                                    ./libraries/router_003                                                        
vmap       router_003                                                         ./libraries/router_003                                                        
ensure_lib                                                                    ./libraries/router_002                                                        
vmap       router_002                                                         ./libraries/router_002                                                        
ensure_lib                                                                    ./libraries/router_001                                                        
vmap       router_001                                                         ./libraries/router_001                                                        
ensure_lib                                                                    ./libraries/router                                                            
vmap       router                                                             ./libraries/router                                                            
ensure_lib                                                                    ./libraries/sdram_controller_0_s1_agent_rsp_fifo                              
vmap       sdram_controller_0_s1_agent_rsp_fifo                               ./libraries/sdram_controller_0_s1_agent_rsp_fifo                              
ensure_lib                                                                    ./libraries/sdram_controller_0_s1_agent                                       
vmap       sdram_controller_0_s1_agent                                        ./libraries/sdram_controller_0_s1_agent                                       
ensure_lib                                                                    ./libraries/hps_0_h2f_axi_master_agent                                        
vmap       hps_0_h2f_axi_master_agent                                         ./libraries/hps_0_h2f_axi_master_agent                                        
ensure_lib                                                                    ./libraries/lua_cpu_0_avalon_master_agent                                     
vmap       lua_cpu_0_avalon_master_agent                                      ./libraries/lua_cpu_0_avalon_master_agent                                     
ensure_lib                                                                    ./libraries/sdram_controller_0_s1_translator                                  
vmap       sdram_controller_0_s1_translator                                   ./libraries/sdram_controller_0_s1_translator                                  
ensure_lib                                                                    ./libraries/lua_cpu_0_avalon_master_translator                                
vmap       lua_cpu_0_avalon_master_translator                                 ./libraries/lua_cpu_0_avalon_master_translator                                
ensure_lib                                                                    ./libraries/cpu                                                               
vmap       cpu                                                                ./libraries/cpu                                                               
ensure_lib                                                                    ./libraries/hps_io                                                            
vmap       hps_io                                                             ./libraries/hps_io                                                            
ensure_lib                                                                    ./libraries/fpga_interfaces                                                   
vmap       fpga_interfaces                                                    ./libraries/fpga_interfaces                                                   
ensure_lib                                                                    ./libraries/rst_controller                                                    
vmap       rst_controller                                                     ./libraries/rst_controller                                                    
ensure_lib                                                                    ./libraries/irq_mapper_002                                                    
vmap       irq_mapper_002                                                     ./libraries/irq_mapper_002                                                    
ensure_lib                                                                    ./libraries/irq_mapper_001                                                    
vmap       irq_mapper_001                                                     ./libraries/irq_mapper_001                                                    
ensure_lib                                                                    ./libraries/irq_mapper                                                        
vmap       irq_mapper                                                         ./libraries/irq_mapper                                                        
ensure_lib                                                                    ./libraries/mm_interconnect_0                                                 
vmap       mm_interconnect_0                                                  ./libraries/mm_interconnect_0                                                 
ensure_lib                                                                    ./libraries/nios2_gen2_0_custom_instruction_master_multi_slave_translator0    
vmap       nios2_gen2_0_custom_instruction_master_multi_slave_translator0     ./libraries/nios2_gen2_0_custom_instruction_master_multi_slave_translator0    
ensure_lib                                                                    ./libraries/nios2_gen2_0_custom_instruction_master_multi_xconnect             
vmap       nios2_gen2_0_custom_instruction_master_multi_xconnect              ./libraries/nios2_gen2_0_custom_instruction_master_multi_xconnect             
ensure_lib                                                                    ./libraries/nios2_gen2_0_custom_instruction_master_translator                 
vmap       nios2_gen2_0_custom_instruction_master_translator                  ./libraries/nios2_gen2_0_custom_instruction_master_translator                 
ensure_lib                                                                    ./libraries/sysid_qsys_0                                                      
vmap       sysid_qsys_0                                                       ./libraries/sysid_qsys_0                                                      
ensure_lib                                                                    ./libraries/sysid                                                             
vmap       sysid                                                              ./libraries/sysid                                                             
ensure_lib                                                                    ./libraries/sdram_controller_0                                                
vmap       sdram_controller_0                                                 ./libraries/sdram_controller_0                                                
ensure_lib                                                                    ./libraries/pll_0                                                             
vmap       pll_0                                                              ./libraries/pll_0                                                             
ensure_lib                                                                    ./libraries/onchip_memory2_0                                                  
vmap       onchip_memory2_0                                                   ./libraries/onchip_memory2_0                                                  
ensure_lib                                                                    ./libraries/nios2_gen2_0                                                      
vmap       nios2_gen2_0                                                       ./libraries/nios2_gen2_0                                                      
ensure_lib                                                                    ./libraries/lua_cpu_0                                                         
vmap       lua_cpu_0                                                          ./libraries/lua_cpu_0                                                         
ensure_lib                                                                    ./libraries/leds_0                                                            
vmap       leds_0                                                             ./libraries/leds_0                                                            
ensure_lib                                                                    ./libraries/jtag_uart                                                         
vmap       jtag_uart                                                          ./libraries/jtag_uart                                                         
ensure_lib                                                                    ./libraries/hps_0                                                             
vmap       hps_0                                                              ./libraries/hps_0                                                             

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                   -work altera_common_sv_packages                                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                            -work altera_common_sv_packages                                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                   -work altera_common_sv_packages                                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_006_error_adapter_0.sv" -l altera_common_sv_packages -work error_adapter_0                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv" -l altera_common_sv_packages -work error_adapter_0                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -l altera_common_sv_packages -work error_adapter_0                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                         -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                       -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                         -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                         -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_memory.sv"                              -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border_hps_io.sv"                              -l altera_common_sv_packages -work border                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io_border.sv"                                     -l altera_common_sv_packages -work border                                                            
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_006.v"                                               -work avalon_st_adapter_006                                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter_001.v"                                               -work avalon_st_adapter_001                                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_avalon_st_adapter.v"                                                   -work avalon_st_adapter                                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"                            -l altera_common_sv_packages -work crosser                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                      -l altera_common_sv_packages -work crosser                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                      -l altera_common_sv_packages -work crosser                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                       -l altera_common_sv_packages -work crosser                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                        -l altera_common_sv_packages -work lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                    -l altera_common_sv_packages -work lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                   -l altera_common_sv_packages -work lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_mux_003.sv"                           -l altera_common_sv_packages -work rsp_mux_003                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work rsp_mux_003                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_mux_002.sv"                           -l altera_common_sv_packages -work rsp_mux_002                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work rsp_mux_002                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_mux_001.sv"                           -l altera_common_sv_packages -work rsp_mux_001                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work rsp_mux_001                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_mux.sv"                               -l altera_common_sv_packages -work rsp_mux                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work rsp_mux                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux_006.sv"                         -l altera_common_sv_packages -work rsp_demux_006                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux_005.sv"                         -l altera_common_sv_packages -work rsp_demux_005                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux_002.sv"                         -l altera_common_sv_packages -work rsp_demux_002                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux_001.sv"                         -l altera_common_sv_packages -work rsp_demux_001                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_rsp_demux.sv"                             -l altera_common_sv_packages -work rsp_demux                                                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux_006.sv"                           -l altera_common_sv_packages -work cmd_mux_006                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux_006                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux_005.sv"                           -l altera_common_sv_packages -work cmd_mux_005                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux_005                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux_003.sv"                           -l altera_common_sv_packages -work cmd_mux_003                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux_003                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux_002.sv"                           -l altera_common_sv_packages -work cmd_mux_002                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux_002                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux_001.sv"                           -l altera_common_sv_packages -work cmd_mux_001                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux_001                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_mux.sv"                               -l altera_common_sv_packages -work cmd_mux                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                           -l altera_common_sv_packages -work cmd_mux                                                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_demux_003.sv"                         -l altera_common_sv_packages -work cmd_demux_003                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_demux_002.sv"                         -l altera_common_sv_packages -work cmd_demux_002                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_demux_001.sv"                         -l altera_common_sv_packages -work cmd_demux_001                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_cmd_demux.sv"                             -l altera_common_sv_packages -work cmd_demux                                                         
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                        -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                 -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                   -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                    -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                        -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                        -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                     -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                    -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                    -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                      -l altera_common_sv_packages -work sdram_controller_0_s1_burst_adapter                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                      -l altera_common_sv_packages -work nios2_gen2_0_instruction_master_limiter                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                       -l altera_common_sv_packages -work nios2_gen2_0_instruction_master_limiter                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                               -l altera_common_sv_packages -work nios2_gen2_0_instruction_master_limiter                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                      -l altera_common_sv_packages -work nios2_gen2_0_instruction_master_limiter                           
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_013.sv"                            -l altera_common_sv_packages -work router_013                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_012.sv"                            -l altera_common_sv_packages -work router_012                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_010.sv"                            -l altera_common_sv_packages -work router_010                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_009.sv"                            -l altera_common_sv_packages -work router_009                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_008.sv"                            -l altera_common_sv_packages -work router_008                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_007.sv"                            -l altera_common_sv_packages -work router_007                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_005.sv"                            -l altera_common_sv_packages -work router_005                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_003.sv"                            -l altera_common_sv_packages -work router_003                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_002.sv"                            -l altera_common_sv_packages -work router_002                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router_001.sv"                            -l altera_common_sv_packages -work router_001                                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0_router.sv"                                -l altera_common_sv_packages -work router                                                            
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                            -work sdram_controller_0_s1_agent_rsp_fifo                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                          -l altera_common_sv_packages -work sdram_controller_0_s1_agent                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                   -l altera_common_sv_packages -work sdram_controller_0_s1_agent                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                        -l altera_common_sv_packages -work hps_0_h2f_axi_master_agent                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                    -l altera_common_sv_packages -work hps_0_h2f_axi_master_agent                                        
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                         -l altera_common_sv_packages -work lua_cpu_0_avalon_master_agent                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                     -l altera_common_sv_packages -work sdram_controller_0_s1_translator                                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                    -l altera_common_sv_packages -work lua_cpu_0_avalon_master_translator                                
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu.vo"                                                                     -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_debug_slave_wrapper.v"                                                  -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_debug_slave_sysclk.v"                                                   -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_debug_slave_tck.v"                                                      -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_mult_cell.v"                                                            -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_cpu_test_bench.v"                                                           -work cpu                                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0_hps_io.v"                                                                          -work hps_io                                                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                         -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                                  -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                     -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                     -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                      -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                       -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                         -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                         -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_hps_0_fpga_interfaces.sv"                                   -l altera_common_sv_packages -work fpga_interfaces                                                   
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                          -work rst_controller                                                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                        -work rst_controller                                                    
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_irq_mapper_002.sv"                                          -l altera_common_sv_packages -work irq_mapper_002                                                    
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_irq_mapper_001.sv"                                          -l altera_common_sv_packages -work irq_mapper_001                                                    
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_irq_mapper.sv"                                              -l altera_common_sv_packages -work irq_mapper                                                        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0.v"                                                                     -work mm_interconnect_0                                                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_customins_slave_translator.sv"                                  -l altera_common_sv_packages -work nios2_gen2_0_custom_instruction_master_multi_slave_translator0    
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0_custom_instruction_master_multi_xconnect.sv"   -l altera_common_sv_packages -work nios2_gen2_0_custom_instruction_master_multi_xconnect             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_customins_master_translator.v"                                                               -work nios2_gen2_0_custom_instruction_master_translator                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_sysid_qsys_0.v"                                                                          -work sysid_qsys_0                                                      
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_sysid.v"                                                                                 -work sysid                                                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_sdram_controller_0.v"                                                                    -work sdram_controller_0                                                
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_pll_0.vo"                                                                                -work pll_0                                                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_onchip_memory2_0.v"                                                                      -work onchip_memory2_0                                                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_nios2_gen2_0.v"                                                                          -work nios2_gen2_0                                                      
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/lua_cpu.v"                                                                                          -work lua_cpu_0                                                         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_leds_0.v"                                                                                -work leds_0                                                            
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_jtag_uart.v"                                                                             -work jtag_uart                                                         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_hps_0.v"                                                                                 -work hps_0                                                             
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/soc_system.v"                                                                                                                                                                          
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter_006 -L avalon_st_adapter_001 -L avalon_st_adapter -L crosser -L lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter -L rsp_mux_003 -L rsp_mux_002 -L rsp_mux_001 -L rsp_mux -L rsp_demux_006 -L rsp_demux_005 -L rsp_demux_002 -L rsp_demux_001 -L rsp_demux -L cmd_mux_006 -L cmd_mux_005 -L cmd_mux_003 -L cmd_mux_002 -L cmd_mux_001 -L cmd_mux -L cmd_demux_003 -L cmd_demux_002 -L cmd_demux_001 -L cmd_demux -L sdram_controller_0_s1_burst_adapter -L nios2_gen2_0_instruction_master_limiter -L router_013 -L router_012 -L router_010 -L router_009 -L router_008 -L router_007 -L router_005 -L router_003 -L router_002 -L router_001 -L router -L sdram_controller_0_s1_agent_rsp_fifo -L sdram_controller_0_s1_agent -L hps_0_h2f_axi_master_agent -L lua_cpu_0_avalon_master_agent -L sdram_controller_0_s1_translator -L lua_cpu_0_avalon_master_translator -L cpu -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_002 -L irq_mapper_001 -L irq_mapper -L mm_interconnect_0 -L nios2_gen2_0_custom_instruction_master_multi_slave_translator0 -L nios2_gen2_0_custom_instruction_master_multi_xconnect -L nios2_gen2_0_custom_instruction_master_translator -L sysid_qsys_0 -L sysid -L sdram_controller_0 -L pll_0 -L onchip_memory2_0 -L nios2_gen2_0 -L lua_cpu_0 -L leds_0 -L jtag_uart -L hps_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter_006 -L avalon_st_adapter_001 -L avalon_st_adapter -L crosser -L lua_cpu_0_avalon_master_to_sdram_controller_0_s1_cmd_width_adapter -L rsp_mux_003 -L rsp_mux_002 -L rsp_mux_001 -L rsp_mux -L rsp_demux_006 -L rsp_demux_005 -L rsp_demux_002 -L rsp_demux_001 -L rsp_demux -L cmd_mux_006 -L cmd_mux_005 -L cmd_mux_003 -L cmd_mux_002 -L cmd_mux_001 -L cmd_mux -L cmd_demux_003 -L cmd_demux_002 -L cmd_demux_001 -L cmd_demux -L sdram_controller_0_s1_burst_adapter -L nios2_gen2_0_instruction_master_limiter -L router_013 -L router_012 -L router_010 -L router_009 -L router_008 -L router_007 -L router_005 -L router_003 -L router_002 -L router_001 -L router -L sdram_controller_0_s1_agent_rsp_fifo -L sdram_controller_0_s1_agent -L hps_0_h2f_axi_master_agent -L lua_cpu_0_avalon_master_agent -L sdram_controller_0_s1_translator -L lua_cpu_0_avalon_master_translator -L cpu -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_002 -L irq_mapper_001 -L irq_mapper -L mm_interconnect_0 -L nios2_gen2_0_custom_instruction_master_multi_slave_translator0 -L nios2_gen2_0_custom_instruction_master_multi_xconnect -L nios2_gen2_0_custom_instruction_master_translator -L sysid_qsys_0 -L sysid -L sdram_controller_0 -L pll_0 -L onchip_memory2_0 -L nios2_gen2_0 -L lua_cpu_0 -L leds_0 -L jtag_uart -L hps_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
