`timescale 1ns / 1ps

//	Created @2021-01-26
//	Author: Youhua Xu
//	
//	This testbench file contains the following simulations:
//	1) simulates the process of AD5628 configuration
//	2) after AD5628 been configured, start to send square waves (f=1MHz) to DG636
//	   

module TOP(
	input clk_sys,
	// input rst_sys,

//	SPI outputs
	output sclk,
	output mosi,
	output A0,
	output A1,
//	output cs,

	//  square waves, which can also be viewed as a clock signal
//	output sq_wave,

    output RST_SIG_CTR,
    output RPHI1_CTR,
    output RPHI2_CTR,
    output RPHI3_CTR,
	
	input PL_KEY
	);

//  生成50MHz的时钟（也包括其他频率的时钟） 
    (*mark_debug="true"*) wire clk_150M;
    (*mark_debug="true"*) wire clk_50M;
    (*mark_debug="true"*) wire clk_25M;
    (*mark_debug="true"*) wire clk_10M;
    (*mark_debug="true"*) wire clk_5M;
    wire clk_locked;

    my_clk_generator  my_clock (
        // Clock out ports  
        .clk_150M(clk_150M),
        .clk_50M(clk_50M),
        .clk_25M(clk_25M),
        .clk_10M(clk_10M),
        .clk_5M(clk_5M),
        // Status and control signals               
        .locked(clk_locked),
        // Clock in ports
        .clk_in1(clk_sys)
        );


	//	states of the STATE MACHINE
	reg[3:0] state;
	parameter S_IDLE	= 4'd0;
	parameter S_SPI	= 4'd1;
	parameter S_SQ		= 4'd2;

	reg en_spi = 1'b0;
	reg en_sq  = 1'b0;
	reg spi_done = 1'b0;
	reg sq_done  = 1'b0;

	wire spi_status;
	wire sq_status;

	SPI_CONTROL spi_control(
		.clk(clk_50M),
		.rst(rst_w),
		.en(en_spi),
		.sclk(sclk),
		.mosi(mosi),
		.cs(cs),
		.A0(A0),
		.A1(A1),
		.status(spi_status)
		);

//  分频时钟
	CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			// .CYCLES_MAX(20)
			.CYCLES_MAX(0)
		)
		clk_div_0
		(
			.clk_sys(clk_50M),
			.en(en_sq),
			.clk_div(sq_wave),
			.status(RST_SIG_CTR)
		);
		
	CLOCK_DIV
        #(
            .DIV_FACTOR(50),
            .CNT_START(0),
            // .CYCLES_MAX(20)
            .CYCLES_MAX(0)
        )
        clk_div_1
        (
            .clk_sys(clk_50M),
            .en(en_sq),
            .clk_div(sq_wave),
            .status(RPHI1_CTR)
        );

    CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			// .CYCLES_MAX(20)
			.CYCLES_MAX(0)
		)
		clk_div_2
		(
			.clk_sys(clk_50M),
			.en(en_sq),
			.clk_div(sq_wave),
			.status(RPHI2_CTR)
		);

    CLOCK_DIV
		#(
			.DIV_FACTOR(50),
			.CNT_START(0),
			// .CYCLES_MAX(20)
			.CYCLES_MAX(0)
		)
		clk_div_3
		(
			.clk_sys(clk_50M),
			.en(en_sq),
			.clk_div(sq_wave),
			.status(RPHI3_CTR)
		);
// =============================
	
// 添加逻辑分析仪
     ILA ila(
            .clk(clk_sys),
            .probe0(sclk),
            .probe1(mosi),
            .probe2(A0),
            .probe3(A1),
            .probe4(RST_SIG_CTR),
            .probe5(RPHI1_CTR),
            .probe6(RPHI2_CTR),
            .probe7(RPHI3_CTR)
        );

//	通过PL按键来触发一个复位reset
    reg state_pl_key        = 1'b0;
    reg state_pl_key_bak    = 1'b0;      
    always@( negedge PL_KEY ) begin
        state_pl_key <= ~state_pl_key;
    end
    
    (*mark_debug="true"*)reg rst_w;
    reg [31:0] rst_cn = 32'd0;
    localparam rst_start = 32'd1000000;


    always@(posedge clk_sys) begin
        if( state_pl_key != state_pl_key_bak ) begin
            if( rst_cn < rst_start ) begin
                rst_w <= 1'b0;
                rst_cn <= rst_cn + 32'd1;
            end
            else if( rst_cn < rst_start+10 ) begin
                rst_w <= 1'b1;
                rst_cn <= rst_cn + 32'd1;
            end
            else if( rst_cn >= rst_start + 10 ) begin
                rst_w <= 1'b0;
                rst_cn <= 32'd0;
                state_pl_key_bak <= ~state_pl_key_bak;
            end
        end
    end

	always@( posedge clk_sys or posedge rst_w ) begin
		if( rst_w ) begin
			state	<= S_IDLE;
			en_spi	<= 1'b0;
			en_sq	<= 1'b0;
			spi_done<= 1'b0;
			sq_done <= 1'b0;
		end
		else begin
			case( state )
				S_IDLE:
				begin
					if( spi_status == 1'b0 && spi_done == 1'b0 ) begin
						en_spi	<= 1'b1;
						state	<= S_SPI;
					end
				end

				S_SPI:
				begin
					if( spi_status == 1'b1 ) begin
						en_spi	<= 1'b0;
						spi_done <= 1'b1;

						if( sq_status == 1'b0 && sq_done == 1'b0 ) begin
							en_sq   <= 1'b1;
							state	<= S_SQ;
						end
					end
				end

				S_SQ:
				begin
					if( sq_status == 1'b1 ) begin
						en_sq	<= 1'b0;
						sq_done <= 1'b1;
						state	<= S_IDLE;
					end
				end

				default:
					state	<= S_IDLE;
			endcase
		end
	end

endmodule