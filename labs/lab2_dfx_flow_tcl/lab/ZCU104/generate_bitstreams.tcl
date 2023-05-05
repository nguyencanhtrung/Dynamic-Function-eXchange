set OutputDir "./Checkpoints"

# Generate Bitstreams
# --------------------------------------------------

# open Config1 routed checkpoint
open_checkpoint $OutputDir/config1_routed_count_up_shift_left.dcp
# Generate Full & Partial Bitstreams for Config1
write_bitstream $OutputDir/config1_count_up_shift_left

# open Config2 routed checkpoint
open_checkpoint $OutputDir/config2_routed_count_down_shift_right.dcp
# Generate Full & Partial Bitstreams for Config2
write_bitstream $OutputDir/config2_count_down_shift_right

# open Config1 static routed checkpoint
open_checkpoint $OutputDir/config1_static_routed.dcp
# update_design inserts constant drivers for all outputs of the Reconfigurable partitions, so these outputs will not float
update_design -cell inst_count -buffer_ports
update_design -cell inst_shift -buffer_ports
# place_design and route_design to ensure they are completely implemented
place_design
route_design
write_checkpoint $OutputDir/Config3_bb.dcp
# Generate Full & Partial Bitstreams for Block Box
# It will generate blank Bitstreams for both RMs
write_bitstream $OutputDir/config3_bb

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
