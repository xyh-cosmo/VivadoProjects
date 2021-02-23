`timescale 1ns / 1ps

//	Created @2021-01-26
//	Author: Youhua Xu
//	
//	This testbench file contains the following simulations:
//	1) simulates the process of AD5628 configuration
//	2) after AD5628 been configured, start to send square waves (f=1MHz) to DG636
//	   

module TOP(
    //  与PS交互部分
        DDR_addr,
        DDR_ba,
        DDR_cas_n,
        DDR_ck_n,
        DDR_ck_p,
        DDR_cke,
        DDR_cs_n,
        DDR_dm,
        DDR_dq,
        DDR_dqs_n,
        DDR_dqs_p,
        DDR_odt,
        DDR_ras_n,
        DDR_reset_n,
        DDR_we_n,
    
        FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp,
        FIXED_IO_mio,
        FIXED_IO_ps_clk,
        FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb,
        
    //  =================
        clk_50M,        // 直接接到PL端的50M晶振上
    
    //  The following siginals are connected to external board via FMC connector
    //	SPI outputs
        sclk,
        mosi,
        A0,
        A1,
    
        RST_SIG_CTR,
        RPHI1_CTR,
        RPHI2_CTR,
        RPHI3_CTR,
        
        TRIG,
        CLKP,
        SDO,
        ENC,            // 板子上的晶振拆掉了，因此利用FPGA生成的时钟来驱动LTC2271工作
        PD,
        IV_5K_CTR,
        ADG772_CTR,
        DUMPOUT,
      
    //  data outputs
        EOUT_P,
        EOUT_N,
        FOUT_P,
        FOUT_N,
        GOUT_P,
        GOUT_N,
        HOUT_P,
        HOUT_N,
    
    //  frame clock
        EF_FR_P,
        EF_FR_N,
        GH_FR_P,
        GH_FR_N,
        
    //  data clock
        EF_DCO_P,
        EF_DCO_N,
        GH_DCO_P,
        GH_DCO_N
	);

//	SPI outputs
	output sclk;
	output mosi;
	output A0;
	output A1;

    output RST_SIG_CTR;
    output RPHI1_CTR;
    output RPHI2_CTR;
    output RPHI3_CTR;
    
    output TRIG;
    output CLKP;
    output SDO;
    output ENC;
    output PD;
    output IV_5K_CTR;
    output ADG772_CTR;
    
    input DUMPOUT;
    input EOUT_P;
    input EOUT_N;
    input FOUT_P;
    input FOUT_N;
    input GOUT_P;
    input GOUT_N;
    input HOUT_P;
    input HOUT_N;
    input EF_FR_P;
    input EF_FR_N;
    input GH_FR_P;
    input GH_FR_N;
    input EF_DCO_P;
    input EF_DCO_N;
    input GH_DCO_P;
    input GH_DCO_N;

// ==========================================================================
// ==========================================================================
//  与PS交互部分
    inout [14:0]DDR_addr;
    inout [2:0]DDR_ba;
    inout DDR_cas_n;
    inout DDR_ck_n;
    inout DDR_ck_p;
    inout DDR_cke;
    inout DDR_cs_n;
    inout [3:0]DDR_dm;
    inout [31:0]DDR_dq;
    inout [3:0]DDR_dqs_n;
    inout [3:0]DDR_dqs_p;
    inout DDR_odt;
    inout DDR_ras_n;
    inout DDR_reset_n;
    inout DDR_we_n;
    inout FIXED_IO_ddr_vrn;
    inout FIXED_IO_ddr_vrp;
    inout [53:0]FIXED_IO_mio;
    inout FIXED_IO_ps_clk;
    inout FIXED_IO_ps_porb;
    inout FIXED_IO_ps_srstb;
    
    
    wire [14:0]DDR_addr;
    wire [2:0]DDR_ba;
    wire DDR_cas_n;
    wire DDR_ck_n;
    wire DDR_ck_p;
    wire DDR_cke;
    wire DDR_cs_n;
    wire [3:0]DDR_dm;
    wire [31:0]DDR_dq;
    wire [3:0]DDR_dqs_n;
    wire [3:0]DDR_dqs_p;
    wire DDR_odt;
    wire DDR_ras_n;
    wire DDR_reset_n;
    wire DDR_we_n;
    wire FIXED_IO_ddr_vrn;
    wire FIXED_IO_ddr_vrp;
    wire [53:0]FIXED_IO_mio;
    wire FIXED_IO_ps_clk;
    wire FIXED_IO_ps_porb;
    wire FIXED_IO_ps_srstb;
    wire [31:0] gpio2_tri_o;
    wire [4:0] gpio_tri_o;
    
//    wire fclk_clk0;

//  与DDR写数据模块交互
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


// ==========================================================================
//    input clk_sys;
    input clk_50M;

//  生成50MHz的时钟（也包括其他频率的时钟） 
    wire clk_locked;
    wire clk_1M, clk_5M;
    wire clk_10M, clk_20M, clk_150M;

    my_clk_generator  my_clock (
       // Clock out ports 
       .clk_10M(clk_10M),
       .clk_20M(clk_20M),
       .clk_150M(clk_150M),
       // Status and control signals               
       .locked(clk_locked),
       // Clock in ports
       .clk_in(clk_50M)
       );

    reg[7:0] cnt_1M=8'b0, cnt_5M=8'b0;
    reg clk_1M_r = 1'b0, clk_5M_r = 1'b0;
    
    always@( posedge clk_10M ) begin
        if( cnt_1M >= 5 ) begin
            cnt_1M <= 8'b0;
            clk_1M_r <= ~clk_1M_r;
        end
        else
            cnt_1M <= cnt_1M + 8'b1;
    end

    always@( posedge clk_20M ) begin
        if( cnt_5M >= 2 ) begin
            cnt_5M <= 8'b0;
            clk_5M_r <= ~clk_5M_r;
        end
        else
            cnt_5M <= cnt_5M + 8'b1;
    end

    assign ENC = clk_1M_r;
//    assign ENC = clk_5M_r;
//    assign ENC = clk_10M;

    //  ==============
    //  PS与PL交互的信号
    //  ==============
    //  GPIO
    //  SPI的控制需要一些额外信号，因此增加以下几个信号
    wire gpio_A0, gpio_A1, gpio_CPOL, gpio_CPHA, gpio_RST;
    wire ENC_fake,TRIG_fake; // 之前接到PS端的控制信号   
    //  GPIO2
    wire [31:0] gpio2_spi_data;
    //  GPIO_IN
    wire pl_status;

    wire wr_burst_data_req;
    wire wr_burst_finish;
    wire rd_burst_finish;
    wire rd_burst_req;
    wire wr_burst_req;
    wire[9:0] rd_burst_len;
    wire[9:0] wr_burst_len;
    wire[31:0] rd_burst_addr;
    wire[31:0] wr_burst_addr;
    wire rd_burst_data_valid;
    wire[63 : 0] rd_burst_data;
    wire[63 : 0] wr_burst_data;

    wire EF_FR, GH_FR;
    wire EF_DCO, GH_DCO;
    wire EOUT, FOUT, GOUT, HOUT;

    wire[15:0] data_E, data_F, data_G, data_H;
    assign data_E[15:0] = wr_burst_data[63:48];
    assign data_F[15:0] = wr_burst_data[47:32];
    assign data_G[15:0] = wr_burst_data[31:16];
    assign data_H[15:0] = wr_burst_data[15:0];

//  将LTC2271输出的差分信号转换成单端信号
    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_EF_FR (
        .O(EF_FR),           // Buffer output
        .I(EF_FR_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(EF_FR_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_GH_FR (
        .O(GH_FR),           // Buffer output
        .I(GH_FR_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(GH_FR_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_EF_DCO (
        .O(EF_DCO),           // Buffer output
        .I(EF_DCO_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(EF_DCO_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_GH_DCO (
        .O(GH_DCO),           // Buffer output
        .I(GH_DCO_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(GH_DCO_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_EOUT (
        .O(EOUT),           // Buffer output
        .I(EOUT_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(EOUT_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_FOUT (
        .O(FOUT),           // Buffer output
        .I(FOUT_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(FOUT_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_GOUT (
        .O(GOUT),           // Buffer output
        .I(GOUT_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(GOUT_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    IBUFDS #(
        .DIFF_TERM("TRUE"),     // Differential Termination
        .IBUF_LOW_PWR("TRUE"),  // Low power="TRUE", Highest performance="FALSE" 
        .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
    ) IBUFDS_HOUT (
        .O(HOUT),           // Buffer output
        .I(HOUT_P),         // Diff_p buffer input (connect directly to top-level port)
        .IB(HOUT_N)         // Diff_n buffer input (connect directly to top-level port)
    );

    wire PL_KEY;
    mem_test
    #(
        .MEM_DATA_BITS(64),
        // .MEM_DATA_BITS(128),
        .ADDR_BITS(28)	// AX7010:27; AX7350:28
    )
    mem_test_m0
    (
        .rst(~rst_n),                             

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

        .EF_FR(EF_FR),
        .GH_FR(GH_FR),
        .EF_DCO(EF_DCO),
        .GH_DCO(GH_DCO),
        .EOUT(EOUT),
        .FOUT(FOUT),
        .GOUT(GOUT),
        .HOUT(HOUT),

        .error(error)
    ); 

    aq_axi_master u_aq_axi_master
    (
        .ARESETN(rst_n),
        .ACLK(clk_150M),
        
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


    CCD231_wrapper CCD231
       (.DDR_addr(DDR_addr),
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
//        .FCLK_CLK0(clk_150M),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        
        //  GPIO：在PS上修改寄存器，实现对PL端模块的控制
        .gpio_in_tri_i(pl_status),
        .gpio2_tri_o(gpio2_spi_data),
        .gpio_tri_o( {CLKP, 
                    //   ENC_fake, 
                      PL_KEY,   // 用该寄存器触发ADC采样
                      TRIG_fake, 
                      gpio_A0, 
                      gpio_A1, 
                      gpio_CPOL, 
                      gpio_CPHA, 
                      gpio_RST}),
        
        //  AXI接口
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
        .axi_hp_clk(clk_150M)
        );

// ==========================================================================
    // reg ENC_r = 1'b0;
    reg TRIG_r = 1'b0;
    // reg[7:0] ENC_cnt = 8'b0;
    reg[7:0] TRIG_cnt = 8'b0;
    // assign ENC = ENC_r;
    assign TRIG = TRIG_r;

    // always@(posedge clk_50M) begin
    //     if( ENC_cnt == 12 ) begin
    //         ENC_r = ~ENC_r;
    //         ENC_cnt <= 8'b0;
    //     end
    //     else
    //         ENC_cnt <= ENC_cnt + 8'b1;
    // end

    always@(posedge clk_50M) begin
        if( TRIG_cnt == 4 ) begin
            TRIG_r = ~TRIG_r;
            TRIG_cnt <= 8'b0;
        end
        else
            TRIG_cnt <= TRIG_cnt + 8'b1;
    end


//  分频时钟
//    parameter cycles_max = 20;
   parameter cycles_max = 0;  // set to zero so that the divided clocks runs forever!
//  这里的分频时钟信号用于测试
	CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			.CYCLES_MAX(cycles_max)
		)
		clk_div_0
		(
			.clk_sys(clk_50M),
			.en(en_ctr),
			.clk_div(RST_SIG_CTR),
			.status(ctr_status)
		);
		
	CLOCK_DIV
       #(
           .DIV_FACTOR(50),
           .CNT_START(0),
           .CYCLES_MAX(cycles_max)
       )
       clk_div_1
       (
           .clk_sys(clk_50M),
           .en(en_ctr),
           .clk_div(RPHI1_CTR),
           .status()
       );

   CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			.CYCLES_MAX(cycles_max)
		)
		clk_div_2
		(
			.clk_sys(clk_50M),
			.en(en_ctr),
			.clk_div(RPHI2_CTR),
			.status()
		);

   CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			.CYCLES_MAX(cycles_max)
		)
		clk_div_3
		(
			.clk_sys(clk_50M),
			.en(en_ctr),
			.clk_div(RPHI3_CTR),
			.status()
		);
// =============================
	
	SPI4ADC spi4adc(
		.clk(clk_50M),
//		.clk(clk_sys),
		.rst(gpio_RST),
		.spi_data(gpio2_spi_data),
		.spi_cpol(gpio_CPOL),
		.spi_cpha(gpio_CPHA),
		.ps_A0(gpio_A0),
		.ps_A1(gpio_A1),
		.A0(A0),
		.A1(A1),
		.sclk(sclk),
		.mosi(mosi),
		.status(pl_status)
		);

    // ILA_XYH (
    //     .clk(clk_50M),
    //     .probe0(gpio_RST),
    //     .probe1(gpio2_spi_data),
    //     .probe2(gpio_CPOL),
    //     .probe3(gpio_CPHA),
    //     .probe4(gpio_A0),
    //     .probe5(gpio_A1),
    //     .probe6(A0),
    //     .probe7(A1),
    //     .probe8(sclk),
    //     .probe9(mosi),
    //     .probe10(pl_status),
    //     .probe11(TRIG),
    //     .probe12(ENC),
    //     .probe13(CLKP)
    //     );

    ILA_LTC2271 ltc2271(
        .clk(clk_50M),
        .probe0(EF_FR),
        .probe1(EF_DCO),
        .probe2(PL_KEY),
        .probe3(data_E),
        .probe4(data_F),
        .probe5(data_G),
        .probe6(data_H)
    );

endmodule