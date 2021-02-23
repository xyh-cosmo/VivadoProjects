//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: meisq                                                               //
//          msq@qq.com                                                          //
//          ALINX(shanghai) Technology Co.,Ltd                                  //
//          heijin                                                              //
//     WEB: http://www.alinx.cn/                                                //
//     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//================================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//  2018/2/24     meisq         1.0         Original
//*******************************************************************************/
module top(
    //sys
    input                     sys_clk,
    
	output                    adc1_clk_ref,
	output                    adc2_clk_ref,
	
	output                    adc1_spi_ce,
	output                    adc1_spi_sclk,
	inout                     adc1_spi_io,
	input                     adc1_clk_p,
	input                     adc1_clk_n,	
	input[11:0]               adc1_data_p,
	input[11:0]               adc1_data_n,
	
	output                    adc2_spi_ce,
	output                    adc2_spi_sclk,
	inout                     adc2_spi_io,
    input                     adc2_clk_p,
	input                     adc2_clk_n,
	input[11:0]               adc2_data_p,
	input[11:0]               adc2_data_n,

//	DDR test part
	inout [14:0]DDR_addr,
	inout [2:0]DDR_ba,
	inout DDR_cas_n,
	inout DDR_ck_n,
	inout DDR_ck_p,
	inout DDR_cke,
	inout DDR_cs_n,
	inout [3:0]DDR_dm,
	inout [31:0]DDR_dq,
	inout [3:0]DDR_dqs_n,
	inout [3:0]DDR_dqs_p,
	inout DDR_odt,
	inout DDR_ras_n,
	inout DDR_reset_n,
	inout DDR_we_n,
	inout FIXED_IO_ddr_vrn,
	inout FIXED_IO_ddr_vrp,
	inout [53:0]FIXED_IO_mio,
	inout FIXED_IO_ps_clk,
	inout FIXED_IO_ps_porb,
	inout FIXED_IO_ps_srstb,

	(*mark_debug="true"*)input PL_KEY,
//	output [127:0] dout,

    output [2:0] leds_tri_o,
	output error
    );
                                 
wire clk_50m;
wire clk_125m;
wire locked;
wire[9:0]                       adc1_lut_index;
wire[24:0]                      adc1_lut_data;
wire[9:0]                       adc2_lut_index;
wire[24:0]                      adc2_lut_data;
wire                            adc1_clk;
wire                            adc2_clk;
wire[11:0]                      adc1_data;
wire[11:0]                      adc1_data_a;
wire[11:0]                      adc1_data_b;
wire[11:0]                      adc2_data;
wire[11:0]                      adc2_data_a;
wire[11:0]                      adc2_data_b;
(* MARK_DEBUG="true" *)reg[11:0] adc1_data_a_d0;
(* MARK_DEBUG="true" *)reg[11:0] adc1_data_b_d0;
(* MARK_DEBUG="true" *)reg[11:0] adc2_data_a_d0;
(* MARK_DEBUG="true" *)reg[11:0] adc2_data_b_d0;

assign adc2_clk_ref = clk_125m;
assign adc1_clk_ref = clk_125m;


IBUFDS #(
	.DIFF_TERM("TRUE"),       // Differential Termination
	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
	.IOSTANDARD("LVDS_25")     // Specify the input I/O standard
) IBUFDS_adc1_clk (
	.O(adc1_clk),  // Buffer output
	.I(adc1_clk_p),  // Diff_p buffer input (connect directly to top-level port)
	.IB(adc1_clk_n) // Diff_n buffer input (connect directly to top-level port)
);

IBUFDS #(
	.DIFF_TERM("TRUE"),       // Differential Termination
	.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
	.IOSTANDARD("LVDS_25")     // Specify the input I/O standard
) IBUFDS_adc2_clk (
	.O(adc2_clk),  // Buffer output
	.I(adc2_clk_p),  // Diff_p buffer input (connect directly to top-level port)
	.IB(adc2_clk_n) // Diff_n buffer input (connect directly to top-level port)
);

//	批量实现模块（IBUFDS_DATAS）的例化
genvar i;
generate
	for (i = 0; i < 12; i = i + 1) begin:IBUFDS_DATAS
		IBUFDS #(
		.DIFF_TERM("TRUE"),       // Differential Termination
		.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD("LVDS_25")     // Specify the input I/O standard
		) IBUFDS_adc1_data (
		.O(adc1_data[i]),  // Buffer output
		.I(adc1_data_p[i]),  // Diff_p buffer input (connect directly to top-level port)
		.IB(adc1_data_n[i]) // Diff_n buffer input (connect directly to top-level port)
		);
		
		// IDDR  **Input Dual Data-Rate Register**
		
		IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
										//    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) IDDR_adc1_data (
		.Q1(adc1_data_b[i]), // 1-bit output for positive edge of clock 
		.Q2(adc1_data_a[i]), // 1-bit output for negative edge of clock
		.C(adc1_clk),   // 1-bit clock input
		.CE(1'b1), // 1-bit clock enable input
		.D(adc1_data[i]),   // 1-bit DDR data input
		.R(1'b0),   // 1-bit reset
		.S(1'b0)    // 1-bit set
        );
		
		// IBUFDS **Differential Signaling Input Buffer with Selectable I/O Interface
		IBUFDS #(
		.DIFF_TERM("TRUE"),       // Differential Termination
		.IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
		.IOSTANDARD("LVDS_25")     // Specify the input I/O standard
		) IBUFDS_adc2_data (
		.O(adc2_data[i]),  // Buffer output
		.I(adc2_data_p[i]),  // Diff_p buffer input (connect directly to top-level port)
		.IB(adc2_data_n[i]) // Diff_n buffer input (connect directly to top-level port)
		);
		
		IDDR #(
		.DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
										//    or "SAME_EDGE_PIPELINED" 
		.INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
		.INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
		.SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) IDDR_adc2_data (
		.Q1(adc2_data_b[i]), // 1-bit output for positive edge of clock 
		.Q2(adc2_data_a[i]), // 1-bit output for negative edge of clock
		.C(adc2_clk),   // 1-bit clock input
		.CE(1'b1), // 1-bit clock enable input
		.D(adc2_data[i]),   // 1-bit DDR data input
		.R(1'b0),   // 1-bit reset
		.S(1'b0)    // 1-bit set
        );		
	end
endgenerate

always@(posedge adc1_clk)
begin
	adc1_data_a_d0 <= adc1_data_a;
	adc1_data_b_d0 <= adc1_data_b;
end
always@(posedge adc2_clk)
begin
	adc2_data_a_d0 <= adc2_data_a;
	adc2_data_b_d0 <= adc2_data_b;
end

sys_pll sys_pll_m0
(
	.clk_in1(sys_clk),
	.clk_out1(clk_50m),
	.clk_out2(clk_125m),	
	.locked(locked)
);

//configure look-up table
lut_config lut_config_adc1(
	.lut_index                  (adc1_lut_index           ),
	.lut_data                   (adc1_lut_data            )
);

spi_config spi_config_adc1(
	.rst                        (~locked                  ),
	.clk                        (clk_50m                  ),
	.clk_div_cnt                (16'd500                  ),
	.lut_index                  (adc1_lut_index           ),
	.lut_reg_addr               (adc1_lut_data[23:8]      ),
	.lut_reg_data               (adc1_lut_data[7:0]       ),
	.error                      (                         ),
	.done                       (                         ),	
	.spi_ce                     (adc1_spi_ce              ),
	.spi_sclk                   (adc1_spi_sclk            ),
	.spi_io                     (adc1_spi_io              )
);

//configure look-up table
lut_config lut_config_adc2(
	.lut_index                  (adc2_lut_index           ),
	.lut_data                   (adc2_lut_data            )
);
spi_config spi_config_adc2(
	.rst                        (~locked                  ),
	.clk                        (clk_50m                  ),
	.clk_div_cnt                (16'd500                  ),
	.lut_index                  (adc2_lut_index           ),
	.lut_reg_addr               (adc2_lut_data[23:8]      ),
	.lut_reg_data               (adc2_lut_data[7:0]       ),
	.error                      (                         ),
	.done                       (                         ),	
	.spi_ce                     (adc2_spi_ce              ),
	.spi_sclk                   (adc2_spi_sclk            ),
	.spi_io                     (adc2_spi_io              )
);

////////////////////////////////////////////////////////////////////////
//	ZYNQ PS:

wire rst_n;	
wire M_AXI_ACLK;
// Master Write Address
wire [0:0]  M_AXI_AWID;
wire [31:0] M_AXI_AWADDR;
wire [7:0]  M_AXI_AWLEN;    // Burst Length: 0-255
wire [2:0]  M_AXI_AWSIZE;   // Burst Size: Fixed 2'b011
wire [1:0]  M_AXI_AWBURST;  // Burst Type: Fixed 2'b01(Incremental Burst)
wire        M_AXI_AWLOCK;   // Lock: Fixed 2'b00
wire [3:0]  M_AXI_AWCACHE;  // Cache: Fiex 2'b0011
wire [2:0]  M_AXI_AWPROT;   // Protect: Fixed 2'b000
wire [3:0]  M_AXI_AWQOS;    // QoS: Fixed 2'b0000
wire [0:0]  M_AXI_AWUSER;   // User: Fixed 32'd0
wire        M_AXI_AWVALID;
wire        M_AXI_AWREADY;

// Master Write Data
wire [63:0] M_AXI_WDATA;
wire [7:0]  M_AXI_WSTRB;
wire        M_AXI_WLAST;
wire [0:0]  M_AXI_WUSER;
wire        M_AXI_WVALID;
wire        M_AXI_WREADY;

// Master Write Response
wire [0:0]   M_AXI_BID;
wire [1:0]   M_AXI_BRESP;
wire [0:0]   M_AXI_BUSER;
wire         M_AXI_BVALID;
wire         M_AXI_BREADY;
    
// Master Read Address
wire [0:0]  M_AXI_ARID;
wire [31:0] M_AXI_ARADDR;
wire [7:0]  M_AXI_ARLEN;
wire [2:0]  M_AXI_ARSIZE;
wire [1:0]  M_AXI_ARBURST;
wire [1:0]  M_AXI_ARLOCK;
wire [3:0]  M_AXI_ARCACHE;
wire [2:0]  M_AXI_ARPROT;
wire [3:0]  M_AXI_ARQOS;
wire [0:0]  M_AXI_ARUSER;
wire        M_AXI_ARVALID;
wire        M_AXI_ARREADY;
    
// Master Read Data 
wire [0:0]   M_AXI_RID;
wire [63:0]  M_AXI_RDATA;
wire [1:0]   M_AXI_RRESP;
wire         M_AXI_RLAST;
wire [0:0]   M_AXI_RUSER;
wire         M_AXI_RVALID;
wire         M_AXI_RREADY;

//(*mark_debug="true"*)wire wr_burst_data_req;
//(*mark_debug="true"*)wire wr_burst_finish;
//(*mark_debug="true"*)wire rd_burst_finish;
//(*mark_debug="true"*)wire rd_burst_req;
//(*mark_debug="true"*)wire wr_burst_req;
//(*mark_debug="true"*)wire[9:0] rd_burst_len;
//(*mark_debug="true"*)wire[9:0] wr_burst_len;
//(*mark_debug="true"*)wire[31:0] rd_burst_addr;
//(*mark_debug="true"*)wire[31:0] wr_burst_addr;
//(*mark_debug="true"*)wire rd_burst_data_valid;
//(*mark_debug="true"*)wire[63 : 0] rd_burst_data;
//(*mark_debug="true"*)wire[63 : 0] wr_burst_data;

(*mark_debug="true"*)wire wr_burst_data_req;
(*mark_debug="true"*)wire wr_burst_finish;
wire rd_burst_finish;
wire rd_burst_req;
(*mark_debug="true"*)wire wr_burst_req;
wire[9:0] rd_burst_len;
(*mark_debug="true"*)wire[9:0] wr_burst_len;
wire[31:0] rd_burst_addr;
(*mark_debug="true"*)wire[31:0] wr_burst_addr;
wire rd_burst_data_valid;
wire[63 : 0] rd_burst_data;
(*mark_debug="true"*)wire[63 : 0] wr_burst_data;

//	==================================================================================
//	需要修改此处，将AD9627采集的数据传入此模块，然后在模块内稍微组织处理，最后将组织好的数据写入DDR
//	2020/12/24凌晨：先直接用AD9627采集到的数据“模拟”一下LTC2271采集到的数据，将4个通道的12位数据
//	的“最低位”取出，然后拼成4×16=64bit的数据，随后burst到DDR中去。这个过程中采用AD9627的数据时钟，
//	并且需要通过两个64bit的reg来交替保存和发送数据

// reg[3:0] ltc2271;

wire adc_ltc2271_0;
wire adc_ltc2271_1;
wire adc_ltc2271_2;
wire adc_ltc2271_3;
assign adc_ltc2271_0 = adc1_data_a[0];
assign adc_ltc2271_1 = adc1_data_b[0];
assign adc_ltc2271_2 = adc2_data_a[0];
assign adc_ltc2271_3 = adc2_data_b[0];

mem_test
#(
	.MEM_DATA_BITS(64),
	// .MEM_DATA_BITS(128),
	.ADDR_BITS(28)	// AX7010:27; AX7350:28
)
mem_test_m0
(
	.rst(~rst_n),                                 
	.mem_clk(M_AXI_ACLK),                       
	.rd_burst_req(rd_burst_req),               
	.wr_burst_req(wr_burst_req),               
	.rd_burst_len(rd_burst_len),               
	.wr_burst_len(wr_burst_len),               
	.rd_burst_addr(rd_burst_addr),        
	.wr_burst_addr(wr_burst_addr),        
	.rd_burst_data_valid(rd_burst_data_valid),  
	.wr_burst_data_req(wr_burst_data_req),  
	.rd_burst_data(rd_burst_data),  
	.wr_burst_data(wr_burst_data),    
	.rd_burst_finish(rd_burst_finish),   
	.wr_burst_finish(wr_burst_finish),

	.pl_key(PL_KEY),
	.adc_clk(adc2_clk),
	// .adc_ltc2271(adc_ltc2271),
//	.adc_ltc2271_0(adc_ltc2271_0),
//	.adc_ltc2271_1(adc_ltc2271_1),
//	.adc_ltc2271_2(adc_ltc2271_2),
//	.adc_ltc2271_3(adc_ltc2271_3),

	.adc_ltc2271_0(adc1_data_a),
	.adc_ltc2271_1(adc1_data_b),
    .adc_ltc2271_2(adc2_data_a),
	.adc_ltc2271_3(adc2_data_b),
//	.dout(dout),
	
	.error(error)
); 

aq_axi_master u_aq_axi_master
(
	.ARESETN(rst_n),
//	.ACLK(M_AXI_ACLK),
	.ACLK(adc2_clk),
	
	.M_AXI_AWID(M_AXI_AWID),
	.M_AXI_AWADDR(M_AXI_AWADDR),     
	.M_AXI_AWLEN(M_AXI_AWLEN),
	.M_AXI_AWSIZE(M_AXI_AWSIZE),
	.M_AXI_AWBURST(M_AXI_AWBURST),
	.M_AXI_AWLOCK(M_AXI_AWLOCK),
	.M_AXI_AWCACHE(M_AXI_AWCACHE),
	.M_AXI_AWPROT(M_AXI_AWPROT),
	.M_AXI_AWQOS(M_AXI_AWQOS),
	.M_AXI_AWUSER(M_AXI_AWUSER),
	.M_AXI_AWVALID(M_AXI_AWVALID),
	.M_AXI_AWREADY(M_AXI_AWREADY),
	
	.M_AXI_WDATA(M_AXI_WDATA),
	.M_AXI_WSTRB(M_AXI_WSTRB),
	.M_AXI_WLAST(M_AXI_WLAST),
	.M_AXI_WUSER(M_AXI_WUSER),
	.M_AXI_WVALID(M_AXI_WVALID),
	.M_AXI_WREADY(M_AXI_WREADY),
	
	.M_AXI_BID(M_AXI_BID),
	.M_AXI_BRESP(M_AXI_BRESP),
	.M_AXI_BUSER(M_AXI_BUSER),
	.M_AXI_BVALID(M_AXI_BVALID),
	.M_AXI_BREADY(M_AXI_BREADY),
	
	.M_AXI_ARID(M_AXI_ARID),
	.M_AXI_ARADDR(M_AXI_ARADDR),
	.M_AXI_ARLEN(M_AXI_ARLEN),
	.M_AXI_ARSIZE(M_AXI_ARSIZE),
	.M_AXI_ARBURST(M_AXI_ARBURST),
	.M_AXI_ARLOCK(M_AXI_ARLOCK),
	.M_AXI_ARCACHE(M_AXI_ARCACHE),
	.M_AXI_ARPROT(M_AXI_ARPROT),
	.M_AXI_ARQOS(M_AXI_ARQOS),
	.M_AXI_ARUSER(M_AXI_ARUSER),
	.M_AXI_ARVALID(M_AXI_ARVALID),
	.M_AXI_ARREADY(M_AXI_ARREADY),
	
	.M_AXI_RID(M_AXI_RID),
	.M_AXI_RDATA(M_AXI_RDATA),
	.M_AXI_RRESP(M_AXI_RRESP),
	.M_AXI_RLAST(M_AXI_RLAST),
	.M_AXI_RUSER(M_AXI_RUSER),
	.M_AXI_RVALID(M_AXI_RVALID),
	.M_AXI_RREADY(M_AXI_RREADY),
	
	.MASTER_RST(~rst_n),
	
	.WR_START(wr_burst_req),
	.WR_ADRS({wr_burst_addr[28:0],3'd0}),	//注意这里的低三位
	.WR_LEN({wr_burst_len,3'd0}), 			//注意这里的低三位
	.WR_READY(),
	.WR_FIFO_RE(wr_burst_data_req),
	.WR_FIFO_EMPTY(1'b0),
	.WR_FIFO_AEMPTY(1'b0),
	.WR_FIFO_DATA(wr_burst_data),
	.WR_DONE(wr_burst_finish),
	
	.RD_START(rd_burst_req),
	.RD_ADRS({rd_burst_addr[28:0],3'd0}),	//注意这里的低三位
	.RD_LEN({rd_burst_len,3'd0}), 			//注意这里的低三位
	.RD_READY(),
	.RD_FIFO_WE(rd_burst_data_valid),
	.RD_FIFO_FULL(1'b0),
	.RD_FIFO_AFULL(1'b0),
	.RD_FIFO_DATA(rd_burst_data),
	.RD_DONE(rd_burst_finish),
	.DEBUG()                                         
);

//	与PS资源的交互
system_wrapper ps_block
(
	.DDR_addr(DDR_addr),
	.DDR_ba(DDR_ba),
	.DDR_cas_n(DDR_cas_n),
	.DDR_ck_n(DDR_ck_n),
	.DDR_ck_p(DDR_ck_p),
	.DDR_cke(DDR_cke),
	.DDR_cs_n(DDR_cs_n),
	.DDR_dm(DDR_dm),
	.DDR_dq(DDR_dq),
	.DDR_dqs_n(DDR_dqs_n),
	.DDR_dqs_p(DDR_dqs_p),
	.DDR_odt(DDR_odt),
	.DDR_ras_n(DDR_ras_n),
	.DDR_reset_n(DDR_reset_n),
	.DDR_we_n(DDR_we_n),
	.FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
	.FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
	.FIXED_IO_mio(FIXED_IO_mio),
	.FIXED_IO_ps_clk(FIXED_IO_ps_clk),
	.FIXED_IO_ps_porb(FIXED_IO_ps_porb),
	.FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
    	
	.S00_AXI_araddr       (M_AXI_ARADDR          ),
	.S00_AXI_arburst      (M_AXI_ARBURST         ),
	.S00_AXI_arcache      (M_AXI_ARCACHE         ),
	.S00_AXI_arid         (M_AXI_ARID            ),
	.S00_AXI_arlen        (M_AXI_ARLEN           ),
	.S00_AXI_arlock       (M_AXI_ARLOCK          ),
	.S00_AXI_arprot       (M_AXI_ARPROT          ),
	.S00_AXI_arqos        (M_AXI_ARQOS           ),
	.S00_AXI_arready      (M_AXI_ARREADY         ),
	.S00_AXI_arregion     (4'b0000               ),
	.S00_AXI_arsize       (M_AXI_ARSIZE          ),
	.S00_AXI_arvalid      (M_AXI_ARVALID         ),
	.S00_AXI_rdata        (M_AXI_RDATA           ),
	.S00_AXI_rid          (M_AXI_RID             ),
	.S00_AXI_rlast        (M_AXI_RLAST           ),
	.S00_AXI_rready       (M_AXI_RREADY          ),
	.S00_AXI_rresp        (M_AXI_RRESP           ),
	.S00_AXI_rvalid       (M_AXI_RVALID          ),
		
	.S00_AXI_awaddr       (M_AXI_AWADDR          ),
	.S00_AXI_awburst      (M_AXI_AWBURST         ),
	.S00_AXI_awcache      (M_AXI_AWCACHE         ),
	.S00_AXI_awid         (M_AXI_AWID            ),
	.S00_AXI_awlen        (M_AXI_AWLEN           ),
	.S00_AXI_awlock       (M_AXI_AWLOCK          ),
	.S00_AXI_awprot       (M_AXI_AWPROT          ),
	.S00_AXI_awqos        (M_AXI_AWQOS           ),
	.S00_AXI_awready      (M_AXI_AWREADY         ),
	.S00_AXI_awregion     (4'b0000               ),
	.S00_AXI_awsize       (M_AXI_AWSIZE          ),
	.S00_AXI_awvalid      (M_AXI_AWVALID         ),
	.S00_AXI_bid          (M_AXI_BID             ),
	.S00_AXI_bready       (M_AXI_BREADY          ),
	.S00_AXI_bresp        (M_AXI_BRESP           ),
	.S00_AXI_bvalid       (M_AXI_BVALID          ),
	.S00_AXI_wdata        (M_AXI_WDATA           ),
	.S00_AXI_wlast        (M_AXI_WLAST           ),
	.S00_AXI_wready       (M_AXI_WREADY          ),
	.S00_AXI_wstrb        (M_AXI_WSTRB           ),
	.S00_AXI_wvalid       (M_AXI_WVALID          ),
	
	.axim_rst_n(rst_n),
	.FCLK_CLK0(M_AXI_ACLK),	//这里的时钟可能也需要修改
//	.FCLK_CLK0(   ),	//这里的时钟可能也需要修改
	// .axi_hp_clk(M_AXI_ACLK)	//这里的时钟可能也需要修改
	.axi_hp_clk(adc2_clk)
);

//	===============================================================================
//	PL加载后LED灯开始闪烁。这只是为了确认PL是否正常工作，等到debug结束之后就将这一块删除掉
// 	LED test part
reg[2:0] leds_tri_o_r;	// 用于测试Arm Linux启动后PL端是否成功加载
reg[31:0] timer_cnt;

assign leds_tri_o = leds_tri_o_r;

always@(posedge M_AXI_ACLK or negedge rst_n)
begin
    if (!rst_n)
    begin
        leds_tri_o_r <= 4'd0 ;
        timer_cnt <= 32'd0 ;
    end
    else if(timer_cnt >= 32'd49_999_999)
    begin
        leds_tri_o_r <= ~leds_tri_o_r;
        timer_cnt <= 32'd0;
    end
    else
    begin
        leds_tri_o_r <= leds_tri_o_r;
        timer_cnt <= timer_cnt + 32'd1;
    end
end


endmodule 
    
    
