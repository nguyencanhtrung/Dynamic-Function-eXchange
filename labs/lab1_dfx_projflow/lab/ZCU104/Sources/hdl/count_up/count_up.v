//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 15.3
//  \   \        Application: Partial Reconfiguration
//  /   /        Filename: CountUp.v
// /___/   /\    Date Last Modified: 05 April 2012
// \   \  /  \
//  \___\/\___\
// Board:  KCU105  
// Device: xcku040-ffva1156-2-e
// Design Name: module_count
// Purpose: Partial Reconfiguration Tutorial
///////////////////////////////////////////////////////////////////////////////
// Reconfigurable Module: module_count
// Binary count up visable on 4 LEDs

module count (
   rst,
   clk,
   count_out
);

   input rst;                // Active high reset
   input clk;                // 300MHz input clock
   output [3:0] count_out;   // Output to LEDs

   reg [24:0] count = 25'b0000000000000000000000000;
   reg [3:0]  count_out = 4'b0000;
   //reg [3:0]  count_en = 4'b0101;  // Special init register to test REST_AFTER_RECONFIG(aka GSR)

   //Counter to reduce speed of output
   always @(posedge clk)
      if (rst) begin
         count <= 0;
      end
      else begin
         count <= count + 1;
      end

    always @(posedge clk)
      if (rst)
         count_out <= 4'b0000;
      else begin
         if (count == 25'b1111111111111111111111111) begin
            count_out <= count_out + 1;
         end
      end
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