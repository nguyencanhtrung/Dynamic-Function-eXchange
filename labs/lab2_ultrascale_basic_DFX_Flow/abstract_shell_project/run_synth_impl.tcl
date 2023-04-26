# #########################################################################
#© Copyright 2021 Xilinx, Inc.

#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at

#    http://www.apache.org/licenses/LICENSE-2.0

#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
# ###########################################################################

#Create a wrapper for Top BD
make_wrapper -files [get_files design_1.bd] -top
add_files -norecurse ./dfx_debug_abs/dfx_debug_abs.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v 
update_compile_order -fileset sources_1

###Add the pblock constraints
add_files -fileset constrs_1 -norecurse ./pblocks.xdc
import_files -fileset constrs_1 [get_files ./pblocks.xdc]

#Generate the targets
generate_target all [get_files design_1.bd]


###DFX Wizard to configure parent/child implementation
create_pr_configuration -name config_up_ila -partitions [list design_1_i/rp1:rp1rm1_inst_0 ]
create_pr_configuration -name config_down_vio -partitions [list design_1_i/rp1:rp1rm2_inst_0 ]
create_pr_configuration -name config_2count_ila -partitions [list design_1_i/rp1:rp1rm3_inst_0 ]
create_run impl_std -parent_run synth_1 -flow {Vivado Implementation 2022} -pr_config config_up_ila -dfx_mode STANDARD
create_run impl_std_child_1 -parent_run impl_std -flow {Vivado Implementation 2022} -pr_config config_down_vio
create_run impl_std_child_2 -parent_run impl_std -flow {Vivado Implementation 2022} -pr_config config_2count_ila
create_run impl_abs -parent_run synth_1 -flow {Vivado Implementation 2022} -pr_config config_up_ila -dfx_mode {ABSTRACT SHELL}
create_run impl_abs_child_1 -parent_run impl_abs -flow {Vivado Implementation 2022} -rm_instance design_1_i/rp1:rp1rm2_inst_0
create_run impl_abs_child_2 -parent_run impl_abs -flow {Vivado Implementation 2022} -rm_instance design_1_i/rp1:rp1rm3_inst_0


###Launch OOC synthesis of RMs, Parent Synthesis, Parent Implementation and Child Implementation
current_run [get_runs impl_std]
delete_runs "impl_1"
launch_runs impl_std impl_std_child_1 impl_std_child_2 impl_abs impl_abs_child_1 impl_abs_child_2 -to_step write_bitstream -jobs 8
wait_on_run impl_std_child_2
#
##Static XSA is written out only for internal verification to make sure they are identical.(static_impl_std.xsa and static_impl_std_child_1.xsa)
##Export the XSA from parent implementation
open_run impl_std
write_hw_platform -fixed -force ../xsa/design_1_wrapper_impl_std.xsa
close_design

##Export the XSA from impl_std_child_1 implementation
open_run impl_std_child_1
write_hw_platform -fixed -force ../xsa/child_xsa/design_1_wrapper_impl_std_child_1.xsa
close_design

##Export the XSA from impl_std_child_2 implementation
open_run impl_std_child_2
write_hw_platform -fixed -force ../xsa/child_xsa/design_1_wrapper_impl_std_child_2.xsa
close_design

