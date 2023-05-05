//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2009 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 12.1
//  \   \        Application: Partial Reconfiguration using GSR
//  /   /        Filename: top.v
// /___/   /\    Date Last Modified: 16 January 2013
// \   \  /  \
//  \___\/\___\
//
//
//  
//
//
// Board:  KCU105 Rev B with 
// Device: xcku040-ffva1156-2-e
// Design Name: led_shift_count_gsr
// Purpose: Partial Reconfiguration Tutorial
///////////////////////////////////////////////////////////////////////////////
//
//    Project : led_shift_count_gsr
// Description: This design outputs LED patterns based on two reconfigurable
//              modules.  The recon_block_bram module ouput depends on the
//              BRAM contents within the reconfig module.  The recon_block_counter
//              module output depends on the counter within the reconfig
//              module.  Partial bit files can be created and downloaded that
//              change the contents of the BRAM and the behavior of the counter.
//              The fisrt four leds are assigned to the BRAM RM which will rotate the
//              LEDS right or left depending on which RM is configured into the device. 
//              The Counter RM will count up or down depending on which RM in configured into the device.
//              The Center button will reset both RMs. The Counter RM operation depends on
//              the initialized contents of a register called count_en. count_en will be set
//              to 0101 in order for CountUP to work and 1010 in order to get CountDown to work.
//              Button 3 can be used to manually increment the count_en value. This button is
//              designs to manually set the en_count to the correct value. Note that button 3 has  
//              debounce logic on it to avoid getting too many button pushs which would make it
//              hard to set count_en to the correct value. This means you have to push button 3 slowly
//              to manually get the count_en set to the correct value, at which time the COUNT logic will
//              start working after being reconfigured. The GSR will allow you to program without
//              having to reset the init value manually. GSR will mask out all non COUNT_UP/DOWN frames
//              so that the Shutdown and Startup happens. Using the GSR methodology for this design with init values
//              will work without having to manually reset the count_en init value. The methodology to test this
//              in ISE 14.1 is To Program the device with full configuration one where COUNT will count down. Then
//              Program the GST.bit for masking of non count frames. Then program the partial bitstream for Count up.
//              Then run a batch script impact -batch  wei/prog_cor1 This script sets the COR1 bit number 24 so that
//              startup will happen. Then it runs a grestore. The script Prog_shutdown does not set COR1 but it does a
//              shutdown - grestore - startup
//
//////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
//  Top-level, static design
//////////////////////////////////////////////////////////////////////////////

module top(
   input        clk_p,       // 300MHz differential input clock
   input        clk_n,       // 300MHz differential input clock
   input        rst_n,       // Reset mapped to center push button
   output [3:0] data_out
);

   wire        rst;
   reg [34:0]  count;
   wire        gclk;
   wire [35:0] icon_control;
   wire [3:0] count_output;
   wire [3:0] shift_out;
   
   // Rev A board CPU reset (has active high reset button) and Rev B using board GPUI reset (has active high reset button)
   assign rst = rst_n;
   assign data_out = {count_output [1:0], shift_out [1:0]};
   
  clocks U0_clocks_ip
   (
    // Clock out ports
    .clk_out(gclk),     // output clk_out
    .clk_out_ce(1'b1),  // input clk_out_ce
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1_p(clk_p),    // input clk_in1_p
    .clk_in1_n(clk_n));    // input clk_in1_n

// instantiate module shift
   shift inst_shift (
      .en       (rst),
      .clk      (gclk),
      .addr     (count[34:23]),
      .data_out (shift_out) 
   );
 
   // instantiate module count
   count inst_count (
      .rst       (rst),
      .clk       (gclk),
      .count_out (count_output)
   );

   // MAIN

   always @(posedge gclk)
     if (rst)
       begin
         count <= 0;
       end
     else
       begin
         count <= count + 1;
       end

endmodule

// black box definition for module_shift
module shift(
   input         en,
   input         clk,
   input  [11:0] addr,
   output  [3:0] data_out);
endmodule

// black box definition for module_count
module count(
   input        rst,
   input        clk,
   output [3:0] count_out);
endmodule


//#<copyright-disclaimer-start>
//#  ************************************************************************************************************
//#  * © Copyright 2023 Xilinx, Inc. All rights reserved.                                                       *
//#  * This file contains confidential and proprietary information of Xilinx, Inc. and                          *
//#  * is protected under U.S. and international copyright and other intellectual property laws.                *
//#  * DISCLAIMER                                                                                               *
//#  * This disclaimer is not a license and does not grant any rights to the materials distributed              *
//#  * herewith. Except as otherwise provided in a valid license issued to you by Xilinx, and to the            *
//#  * maximum extent permitted by applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS"               *
//#  * AND WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS,                 *
//#  * IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT,     *
//#  * OR FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract or tort,  *
//#  * including negligence, or under any other theory of liability) for any loss or damage of any kind or      *
//#  * nature related to, arising under or in connection with these materials, including for any direct, or     *
//#  * any indirect, special, incidental, or consequential loss or damage (including loss of data, profits,     *
//#  * goodwill, or any type of loss or damage suffered as a result of any action brought by a third party)     *
//#  * even if such damage or loss was reasonably foreseeable or Xilinx had been advised of the possibility     *
//#  * of the same.                                                                                             *
//#  * CRITICAL APPLICATIONS                                                                                    *
//#  * Xilinx products are not designed or intended to be fail-safe, or for use in any application requiring    *
//#  * fail-safe performance, such as life-support or safety devices or systems, Class III medical devices,     *
//#  * nuclear facilities, applications related to the deployment of airbags, or any other applications that    *
//#  * could lead to death, personal injury, or severe property or environmental damage (individually and       *
//#  * collectively, "Critical Applications"). Customer assumes the sole risk and liability of any use of       *
//#  * Xilinx products in Critical Applications, subject only to applicable laws and regulations governing      *
//#  * limitations on product liability.                                                                        *
//#  * THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.                 *
//#  *                                                                                                          *
//#  ************************************************************************************************************
//#<copyright-disclaimer-end>