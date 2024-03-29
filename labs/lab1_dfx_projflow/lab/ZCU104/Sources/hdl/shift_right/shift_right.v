//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2005-2012 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, Inc.
// All Rights Reserved.
///////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor: Xilinx
// \   \   \/    Version: 1.0
//  \   \        Application: Partial Reconfiguration using GSR
//  /   /        Filename: shift_right.v
// /___/   /\    Date Last Modified: 05 April 2012
// \   \  /  \
//  \___\/\___\
// Board:  KCU105 Rev B with 
// Device: xcku040-ffva1156-2-e
// Design Name: module_shift
// Purpose: Partial Reconfiguration Tutorial
///////////////////////////////////////////////////////////////////////////////
// Reconfigurable Module: module_shift
// LED shift left visable on 4 LEDs

module shift (
	en,
	clk,
	addr,
	data_out);

   input en;                // Active high reset
   input clk;               // 300MHz input clock
   input  [11:0] addr;      // Address
   output [3:0]  data_out;  // Output to LEDs

// RAMB36E2: 32k+4k Parity Paramatizable True Dual-Port BlockRAM
// Virtex-5
// Xilinx HDL Libraries Guide, version 10.1.2
RAMB36E2 #(
      // CASCADE_ORDER_A, CASCADE_ORDER_B: "FIRST", "MIDDLE", "LAST", "NONE" 
      .CASCADE_ORDER_A("NONE"),
      .CASCADE_ORDER_B("NONE"),
      // CLOCK_DOMAINS: "COMMON", "INDEPENDENT" 
      .CLOCK_DOMAINS("INDEPENDENT"),
      .DOB_REG(1),
      // Collision check: "ALL", "GENERATE_X_ONLY", "NONE", "WARNING_ONLY" 
      .SIM_COLLISION_CHECK("ALL"),
      // DOA_REG, DOB_REG: Optional output register (0, 1)
      .DOA_REG(1),
      // ENADDRENA/ENADDRENB: Address enable pin enable, "TRUE", "FALSE" 
      .ENADDRENA("FALSE"),
      .ENADDRENB("FALSE"),
      // EN_ECC_PIPE: ECC pipeline register, "TRUE"/"FALSE" 
      .EN_ECC_PIPE("FALSE"),
      // EN_ECC_READ: Enable ECC decoder, "TRUE"/"FALSE" 
      .EN_ECC_READ("FALSE"),
      // EN_ECC_WRITE: Enable ECC encoder, "TRUE"/"FALSE" 
      .EN_ECC_WRITE("FALSE"),
      // INITP_00 to INITP_0F: Initial contents of parity memory array
      .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
      .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
      // INIT_00 to INIT_7F: Initial contents of data memory array
      
.INIT_00(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_01(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_02(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_03(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_04(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_05(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_06(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_07(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_08(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_09(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_0F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_10(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_11(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_12(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_13(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_14(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_15(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_16(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_17(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_18(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_19(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_1F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_20(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_21(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_22(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_23(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_24(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_25(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_26(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_27(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_28(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_29(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_2F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_30(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_31(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_32(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_33(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_34(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_35(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_36(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_37(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_38(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_39(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_3F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_40(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_41(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_42(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_43(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_44(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_45(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_46(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_47(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_48(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_49(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_4F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_50(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_51(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_52(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_53(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_54(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_55(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_56(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_57(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_58(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_59(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_5F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_60(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_61(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_62(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_63(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_64(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_65(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_66(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_67(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_68(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_69(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_6F(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_70(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_71(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_72(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_73(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_74(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_75(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_76(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_77(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_78(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_79(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7A(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7B(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7C(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7D(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7E(256'h0102040801020408010204080102040801020408010204080102040801020408),
.INIT_7F(256'h0102040801020408010204080102040801020408010204080102040801020408),

      // INIT_A, INIT_B: Initial values on output ports
      .INIT_A(36'h000000000),
      .INIT_B(36'h000000000),
      // Initialization File: RAM initialization file
      .INIT_FILE("NONE"),
      // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
      .IS_CLKARDCLK_INVERTED(1'b0),
      .IS_CLKBWRCLK_INVERTED(1'b0),
      .IS_ENARDEN_INVERTED(1'b0),
      .IS_ENBWREN_INVERTED(1'b0),
      .IS_RSTRAMARSTRAM_INVERTED(1'b0),
      .IS_RSTRAMB_INVERTED(1'b0),
      .IS_RSTREGARSTREG_INVERTED(1'b0),
      .IS_RSTREGB_INVERTED(1'b0),
      // RDADDRCHANGE: Disable memory access when output value does not change ("TRUE", "FALSE")
      .RDADDRCHANGEA("FALSE"),
      .RDADDRCHANGEB("FALSE"),
      // READ_WIDTH_A/B, WRITE_WIDTH_A/B: Read/write width per port
      .READ_WIDTH_A(9),                                                                 // 0-9
      .READ_WIDTH_B(0),                                                                 // 0-9
      .WRITE_WIDTH_A(0),                                                                // 0-9
      .WRITE_WIDTH_B(0),                                                                // 0-9
      // RSTREG_PRIORITY_A, RSTREG_PRIORITY_B: Reset or enable priority ("RSTREG", "REGCE")
      .RSTREG_PRIORITY_A("RSTREG"),
      .RSTREG_PRIORITY_B("RSTREG"),
      // SRVAL_A, SRVAL_B: Set/reset value for output
      .SRVAL_A(36'h000000000),
      .SRVAL_B(36'h000000000),
      // Sleep Async: Sleep function asynchronous or synchronous ("TRUE", "FALSE")
      .SLEEP_ASYNC("FALSE"),
      // WriteMode: "WRITE_FIRST", "NO_CHANGE", "READ_FIRST" 
      .WRITE_MODE_A("WRITE_FIRST"),
      .WRITE_MODE_B("WRITE_FIRST") 
   )
   RAMB36E2_inst (
      // Cascade Signals outputs: Multi-BRAM cascade signals
      .CASDOUTA(),               // 32-bit output: Port A cascade output data
      .CASDOUTB(),               // 32-bit output: Port B cascade output data
      .CASDOUTPA(),             // 4-bit output: Port A cascade output parity data
      .CASDOUTPB(),             // 4-bit output: Port B cascade output parity data
      .CASOUTDBITERR(),     // 1-bit output: DBITERR cascade output
      .CASOUTSBITERR(),     // 1-bit output: SBITERR cascade output
      // ECC Signals outputs: Error Correction Circuitry ports
      .DBITERR(),                 // 1-bit output: Double bit error status
      .ECCPARITY(),             // 8-bit output: Generated error correction parity
      .RDADDRECC(),             // 9-bit output: ECC Read Address
      .SBITERR(),                 // 1-bit output: Single bit error status
      // Port A Data outputs: Port A data
      .DOUTADOUT(data_out),             // 32-bit output: Port A ata/LSB data
      .DOUTPADOUTP(),         // 4-bit output: Port A parity/LSB parity
      // Port B Data outputs: Port B data
      .DOUTBDOUT(),             // 32-bit output: Port B data/MSB data
      .DOUTPBDOUTP(),         // 4-bit output: Port B parity/MSB parity
      // Cascade Signals inputs: Multi-BRAM cascade signals
      .CASDIMUXA(),             // 1-bit input: Port A input data (0=DINA, 1=CASDINA)
      .CASDIMUXB(),             // 1-bit input: Port B input data (0=DINB, 1=CASDINB)
      .CASDINA(),                 // 32-bit input: Port A cascade input data
      .CASDINB(),                 // 32-bit input: Port B cascade input data
      .CASDINPA(),               // 4-bit input: Port A cascade input parity data
      .CASDINPB(),               // 4-bit input: Port B cascade input parity data
      .CASDOMUXA(),             // 1-bit input: Port A unregistered data (0=BRAM data, 1=CASDINA)
      .CASDOMUXB(),             // 1-bit input: Port B unregistered data (0=BRAM data, 1=CASDINB)
      .CASDOMUXEN_A(),       // 1-bit input: Port A unregistered output data enable
      .CASDOMUXEN_B(),       // 1-bit input: Port B unregistered output data enable
      .CASINDBITERR(),       // 1-bit input: DBITERR cascade input
      .CASINSBITERR(),       // 1-bit input: SBITERR cascade input
      .CASOREGIMUXA(),       // 1-bit input: Port A registered data (0=BRAM data, 1=CASDINA)
      .CASOREGIMUXB(),       // 1-bit input: Port B registered data (0=BRAM data, 1=CASDINB)
      .CASOREGIMUXEN_A(), // 1-bit input: Port A registered output data enable
      .CASOREGIMUXEN_B(), // 1-bit input: Port B registered output data enable
      // ECC Signals inputs: Error Correction Circuitry ports
      .ECCPIPECE(),             // 1-bit input: ECC Pipeline Register Enable
      .INJECTDBITERR(),     // 1-bit input: Inject a double bit error
      .INJECTSBITERR(),
      // Port A Address/Control Signals inputs: Port A address and control signals
      .ADDRARDADDR({addr[11:0], 3'b 000}),         // 15-bit input: A/Read port address
      .ADDRENA(),                 // 1-bit input: Active-High A/Read port address enable
      .CLKARDCLK(clk),             // 1-bit input: A/Read port clock
      .ENARDEN(~en),                 // 1-bit input: Port A enable/Read enable
      .REGCEAREGCE(~en),         // 1-bit input: Port A register enable/Register enable
      .RSTRAMARSTRAM(en),     // 1-bit input: Port A set/reset
      .RSTREGARSTREG(),     // 1-bit input: Port A register set/reset
      .SLEEP(),                     // 1-bit input: Sleep Mode
      .WEA(4'b0000),                         // 4-bit input: Port A write enable
      // Port A Data inputs: Port A data
      .DINADIN(),                 // 32-bit input: Port A data/LSB data
      .DINPADINP(),             // 4-bit input: Port A parity/LSB parity
      // Port B Address/Control Signals inputs: Port B address and control signals
      .ADDRBWRADDR(),         // 15-bit input: B/Write port address
      .ADDRENB(),                 // 1-bit input: Active-High B/Write port address enable
      .CLKBWRCLK(),             // 1-bit input: B/Write port clock
      .ENBWREN(),                 // 1-bit input: Port B enable/Write enable
      .REGCEB(),                   // 1-bit input: Port B register enable
      .RSTRAMB(),                 // 1-bit input: Port B set/reset
      .RSTREGB(),                 // 1-bit input: Port B register set/reset
      .WEBWE(),                     // 8-bit input: Port B write enable/Write enable
      // Port B Data inputs: Port B data
      .DINBDIN(),                 // 32-bit input: Port B data/MSB data
      .DINPBDINP()              // 4-bit input: Port B parity/MSB parity
   );

// End of RAMB36E2_inst instantiation

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