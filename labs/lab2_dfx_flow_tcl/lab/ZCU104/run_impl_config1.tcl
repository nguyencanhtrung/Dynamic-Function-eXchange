
set device       "xczu7ev"
set package      "-ffvc1156"
set speed        "-2-e"
set part         $device$package$speed
set srcDir     "./Sources"
set SynOutputDir  "./SynOutputDir"
set OutputDir "./Checkpoints"

# Configuration 1:

# Open synthesized checkpoint for static logic
open_checkpoint $SynOutputDir/post_synth_top/post_synth_top.dcp

# Read synthesized checkpoints for RM logic with one set of variations
read_checkpoint -cell inst_count $SynOutputDir/post_synth_count_up/post_synth_count_up.dcp
read_checkpoint -cell inst_shift $SynOutputDir/post_synth_shift_left/post_synth_shift_left.dcp

# Turn on HD.RECONFIGURABLE property on RM
set_property HD.RECONFIGURABLE true [get_cells inst_count]
set_property HD.RECONFIGURABLE true [get_cells inst_shift]

# Floorplanning XDC file
read_xdc $srcDir/xdc/pblocks.xdc

# Run implementation 
opt_design
place_design
route_design

# Write routed checkpoints
write_checkpoint -force $OutputDir/config1_routed_count_up_shift_left.dcp
write_checkpoint -cell inst_count -force $OutputDir/config1_inst_count_a_route_design.dcp
write_checkpoint -cell inst_shift -force $OutputDir/config1_inst_shift_a_route_design.dcp

# Prepare static routed design checkpoint
update_design -cell inst_count -black_box
update_design -cell inst_shift -black_box
lock_design -level routing

# Write static routed design checkpoint
write_checkpoint -force $OutputDir/config1_static_routed.dcp
#<copyright-disclaimer-start>
#  ************************************************************************************************************
#  * © Copyright 2023 Xilinx, Inc. All rights reserved.                                                       *
#  * This file contains confidential and proprietary information of Xilinx, Inc. and                          *
#  * is protected under U.S. and international copyright and other intellectual property laws.                *
#  * DISCLAIMER                                                                                               *
#  * This disclaimer is not a license and does not grant any rights to the materials distributed              *
#  * herewith. Except as otherwise provided in a valid license issued to you by Xilinx, and to the            *
#  * maximum extent permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS"               *
#  * AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,                 *
#  * IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,     *
#  * OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract or tort,  *
#  * including negligence, or under any other theory of liability) for any loss or damage of any kind or      *
#  * nature related to, arising under or in connection with these materials, including for any direct, or     *
#  * any indirect, special, incidental, or consequential loss or damage (including loss of data, profits,     *
#  * goodwill, or any type of loss or damage suffered as a result of any action brought by a third party)     *
#  * even if such damage or loss was reasonably foreseeable or Xilinx had been advised of the possibility     *
#  * of the same.                                                                                             *
#  * CRITICAL APPLICATIONS                                                                                    *
#  * Xilinx products are not designed or intended to be fail-safe, or for use in any application requiring    *
#  * fail-safe performance, such as life-support or safety devices or systems, Class III medical devices,     *
#  * nuclear facilities, applications related to the deployment of airbags, or any other applications that    *
#  * could lead to death, personal injury, or severe property or environmental damage (individually and       *
#  * collectively, "Critical Applications"). Customer assumes the sole risk and liability of any use of       *
#  * Xilinx products in Critical Applications, subject only to applicable laws and regulations governing      *
#  * limitations on product liability.                                                                        *
#  * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.                 *
#  *                                                                                                          *
#  ************************************************************************************************************
#<copyright-disclaimer-end>
