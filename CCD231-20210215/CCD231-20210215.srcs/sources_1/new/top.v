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
    //	clk_sys,
        clk_50M,
        // rst_sys,
    
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
        
        AD9106_TRIG,
        CLKP,
        SDO,
        ENC,
        PD,
        IV_5K_CTR,
        ADG772_CTR,
        DUMPOUT,
        EOUT_P,
        EOUT_N,
        FOUT_P,
        FOUT_N,
        GOUT_P,
        GOUT_N,
        HOUT_P,
        HOUT_N,
        EF_FR_P,
        EF_FR_N,
        GH_FR_P,
        GH_FR_N,
        EF_DCO_P,
        EF_DCO_N,
        GH_DCO_P,
        GH_DCO_N
	);

// ==========================================================================
//    input clk_sys;
    input clk_50M;
//	SPI outputs
	output sclk;
	output mosi;
	output A0;
	output A1;

    output RST_SIG_CTR;
    output RPHI1_CTR;
    output RPHI2_CTR;
    output RPHI3_CTR;
    
    output AD9106_TRIG;
    output CLKP;
    output SDO;
    output ENC;
    output PD;
    output IV_5K_CTR;
    output ADG772_CTR;
    output DUMPOUT;
    output EOUT_P;
    output EOUT_N;
    output FOUT_P;
    output FOUT_N;
    output GOUT_P;
    output GOUT_N;
    output HOUT_P;
    output HOUT_N;
    output EF_FR_P;
    output EF_FR_N;
    output GH_FR_P;
    output GH_FR_N;
    output EF_DCO_P;
    output EF_DCO_N;
    output GH_DCO_P;
    output GH_DCO_N;

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
    
    wire fclk_clk0;
    
    // PS与PL交互的信号
    wire gpio_A0, gpio_A1, gpio_CPOL, gpio_CPHA, gpio_RST;
    wire [31:0] gpio2_spi_data;
    wire pl_status;
    
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
        .FCLK_CLK0(fclk_clk0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .gpio_in_tri_i(pl_status),
        .gpio2_tri_o(gpio2_spi_data),
        .gpio_tri_o({AD9106_TRIG, gpio_A0, gpio_A1, gpio_CPOL, gpio_CPHA, gpio_RST})
        );

// ==========================================================================

//  生成50MHz的时钟（也包括其他频率的时钟） 
//    wire clk_150M;
//    wire clk_50M;
//    wire clk_25M;
//    wire clk_10M;
//    wire clk_5M;
//    wire clk_locked;

//    my_clk_generator  my_clock (
//        // Clock out ports  
//        .clk_150M(clk_150M),
//        .clk_50M(clk_50M),
//        .clk_25M(clk_25M),
//        .clk_10M(clk_10M),
//        .clk_5M(clk_5M),
//        // Status and control signals               
//        .locked(clk_locked),
//        // Clock in ports
//        .clk_in1(clk_sys)
//        );


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

    ILA_XYH (
        .clk(clk_50M),
        .probe0(gpio_RST),
        .probe1(gpio2_spi_data),
        .probe2(gpio_CPOL),
        .probe3(gpio_CPHA),
        .probe4(gpio_A0),
        .probe5(gpio_A1),
        .probe6(A0),
        .probe7(A1),
        .probe8(sclk),
        .probe9(mosi),
        .probe10(pl_status),
        .probe11(AD9106_TRIG)
        
//        .probe12(CLKP),
//        .probe13(SDO),
//        .probe14(ENC),
//        .probe15(PD),
//        .probe16(IV_5K_CTR),
//        .probe17(ADG772_CTR),
//        .probe18(DUMPOUT),
//        .probe19(EOUT_P),
//        .probe20(EOUT_N),
//        .probe21(FOUT_P),
//        .probe22(FOUT_N),
//        .probe23(GOUT_P),
//        .probe24(GOUT_N),
//        .probe25(HOUT_P),
//        .probe26(HOUT_N),
//        .probe27(EF_FR_P),
//        .probe28(EF_FR_N),
//        .probe29(GH_FR_P),
//        .probe30(GH_FR_N),
//        .probe31(EF_DCO_P),
//        .probe32(EF_DCO_N),
//        .probe33(GH_DCO_P),
//        .probe34(GH_DCO_N)
        );

endmodule