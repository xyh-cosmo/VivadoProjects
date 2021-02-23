//////////////////////////////////////////////////////////////////////////////////
// Company: ALINX黑金
// Engineer: 老梅
// 
// Create Date: 2016/11/17 10:27:06
// Design Name: 
// Module Name: mem_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
// 2020/12/23: 	modify mem_test so that it accepts data sampled from AD9627 and save
//				the data into PS DDR, in burst mode.
// 2020/12/24：	预期实现的功能：PL按键摁下知乎，连续以burst模式发送128次数据（写入DDR），之后
//				回到IDLE状态，计数器与首地址都重置为初始值。
// 2021/01/04:  实现4通道12bit数据的最高位合并成4×16bit的数据，然后写入到PS端DDR中 
//////////////////////////////////////////////////////////////////////////////////
module mem_test
#(
	parameter MEM_DATA_BITS = 64,
	parameter ADDR_BITS = 32
)
(
	input rst,                                 /*复位*/
    input mem_clk,                               /*接口时钟*/
    output reg rd_burst_req,                          /*读请求*/
    output reg wr_burst_req,                          /*写请求*/
    output reg[9:0] rd_burst_len,                     /*读数据长度*/
    output reg[9:0] wr_burst_len,                     /*写数据长度*/
    output reg[ADDR_BITS - 1:0] rd_burst_addr,        /*读首地址*/
    output reg[ADDR_BITS - 1:0] wr_burst_addr,        /*写首地址*/
    input rd_burst_data_valid,                  /*读出数据有效*/
    input wr_burst_data_req,                    /*写数据信号*/
    input[MEM_DATA_BITS - 1:0] rd_burst_data,   /*读出的数据*/
    output[MEM_DATA_BITS - 1:0] wr_burst_data,    /*写入的数据*/
    input rd_burst_finish,                      /*读完成*/
    input wr_burst_finish,                      /*写完成*/
    
    input pl_key,	/*用于触发一次“写、读、地址递增一次”的过程*/

	(*mark_debug="true"*) input adc_clk,	//	ADC时钟
	// input [3:0] adc_ltc2271,	// 引入ADC采样的数据
//	input adc_ltc2271_0,
//	input adc_ltc2271_1,

	(*mark_debug="true"*) input[11:0] adc_ltc2271_0,
	(*mark_debug="true"*) input[11:0] adc_ltc2271_1,
	(*mark_debug="true"*) input[11:0] adc_ltc2271_2,
	(*mark_debug="true"*) input[11:0] adc_ltc2271_3,
//	output [127:0] dout,
    
    output reg error
);
parameter IDLE = 3'd0;
parameter MEM_READ = 3'd1;
parameter MEM_WRITE  = 3'd2;
//parameter MEM_WAIT = 3'd4;
parameter MEM_RESET = 3'd5;

parameter INIT_ADDR = 'h02000000;  // 这是个特殊的初始位置


// parameter BURST_LEN = 128;	//在当前的例子中，摁一下PL按键将连续采集发送128次
parameter BURST_LEN = 1;	//在当前的例子中，摁一下PL按键将连续采集发送4次

(*mark_debug="true"*)reg[2:0] state;
(*mark_debug="true"*)reg[7:0] wr_cnt;
reg[MEM_DATA_BITS - 1:0] wr_burst_data_reg;
assign wr_burst_data = wr_burst_data_reg;
//(*mark_debug="true"*)reg[7:0] rd_cnt;
reg[7:0] rd_cnt;
reg[31:0] write_read_len;
//assign error = (state == MEM_READ) && rd_burst_data_valid && (rd_burst_data != {(MEM_DATA_BITS/8){rd_cnt}});

// 记录按键状态的寄存器
reg pl_key_state = 1'b0;	// 每次按下键之后，状态翻转一次
reg pl_key_state0 = 1'b0;	// 记录上一次按键的状态，在完成一次“写、读、地址递增”操作之后，状态翻转一次
//	注：在进行一次“写、读、地址递增”操作的过程中，pl_key_state与pl_key_state0刚好相反

(*mark_debug="true"*) reg [31:0] pl_cnt;			// 记录连续“写、读、地址递增”的次数
//parameter PL_CNT_MAX = 1024*1024*96;    // 1024*1024*64=8MB
parameter PL_CNT_MAX = 1024*1024;

//	因为按键是低电位有效，在不按下的情况下一直保持高电位，因此采用由低电位恢复为高电位时的上升沿作为触发信号
always@( posedge pl_key )
begin
	pl_key_state <= ~pl_key_state;
end

always@(posedge adc_clk or posedge rst)
begin
	if(rst)
		error <= 1'b0;
	else if(state == MEM_READ && rd_burst_data_valid && rd_burst_data != {(MEM_DATA_BITS/8){rd_cnt}})
		error <= 1'b1;
end

//////////////////////////////////////////////////////////////////
//	这里只处理数据的写：将ADC采集的数据拼接起来，组成4×16=64位长度的数据
(*mark_debug="true"*) reg [4:0] adc_cnt;
//reg [7:0] adc_cnt;
assign debug_cnt = adc_cnt;

(*mark_debug="true"*) wire f_clk;
(*mark_debug="true"*) wire p_clk;

//	ch0
reg [15:0] px10;
reg [15:0] px20;

//	ch1
reg [15:0] px11;
reg [15:0] px21;

//	ch2
reg [15:0] px12;
reg [15:0] px22;

//	ch3
reg [15:0] px13;
reg [15:0] px23;

assign f_clk = ~(adc_cnt[3]);
assign p_clk = adc_cnt[4];

reg[63:0] wr_burst_data_reg_tmp;

// 不断地将AD9627采集的12bit数据最高位当作LTC2271的4通道采集数据，压入“缓冲数组”中
always@(posedge adc_clk or posedge rst)
begin
	if( rst ) begin
		adc_cnt  <= 5'b0;

		px10 <= 16'b0;
		px11 <= 16'b0;
		px12 <= 16'b0;
		px13 <= 16'b0;

		px20 <= 16'b0;
		px21 <= 16'b0;
		px22 <= 16'b0;
		px23 <= 16'b0;
		
		wr_burst_data_reg_tmp <= 64'b0;
	end
	else begin
	  	if(!p_clk) begin	// handle first 16 bits
//			px10 <= (px10 << 1) + {15'b0,adc_ltc2271_0[11]};
//			px11 <= (px11 << 1) + {15'b0,adc_ltc2271_1[11]};
//			px12 <= (px12 << 1) + {15'b0,adc_ltc2271_2[11]};
//            px13 <= (px13 << 1) + {15'b0,adc_ltc2271_3[11]};

            px10 <= (px10 << 1) + {15'b0,adc_ltc2271_0[0]};
			px11 <= (px11 << 1) + {15'b0,adc_ltc2271_1[0]};
			px12 <= (px12 << 1) + {15'b0,adc_ltc2271_2[0]};
            px13 <= (px13 << 1) + {15'b0,adc_ltc2271_3[0]};
            
            // 确保在一次burst期间，发送的数据不受影响。
            // 通过观察wr_burst_data_req的时序图后发现，wr_burst_data_req只在很短的时间内拉高，
            // 因此实际上不需要在此处尽心特殊的处理，真正有效的数据已经在wr_burst_data_req被拉高后“缓存”了。
//            if( (adc_cnt == 5'b00000) || (adc_cnt == 5'b10000) ) begin
            if( adc_cnt == 5'b00000 ) begin
                wr_burst_data_reg_tmp <= {px10,px11,px12,px13};
//                wr_burst_data_reg_tmp <= {pl_cnt,pl_cnt};
            end

//			adc_cnt <= adc_cnt + 5'b1;
		end
		else begin			// handle rest 16 bits
//			px20 <= (px20 << 1) + {15'b0,adc_ltc2271_0[11]};
//			px21 <= (px21 << 1) + {15'b0,adc_ltc2271_1[11]};
//            px22 <= (px22 << 1) + {15'b0,adc_ltc2271_2[11]};
//            px23 <= (px23 << 1) + {15'b0,adc_ltc2271_3[11]};
            px20 <= (px20 << 1) + {15'b0,adc_ltc2271_0[0]};
			px21 <= (px21 << 1) + {15'b0,adc_ltc2271_1[0]};
            px22 <= (px22 << 1) + {15'b0,adc_ltc2271_2[0]};
            px23 <= (px23 << 1) + {15'b0,adc_ltc2271_3[0]};
            
//            if( (adc_cnt == 5'b00000) || (adc_cnt == 5'b10000) ) begin
            if( adc_cnt == 5'b10000 ) begin
                wr_burst_data_reg_tmp <= {px20,px21,px22,px23};
//                wr_burst_data_reg_tmp <= {pl_cnt,pl_cnt};
            end

//			adc_cnt <= adc_cnt + 5'b1;
		end

		adc_cnt <= adc_cnt + 5'b1;
	end
end

// 往DDR中写数据
always@(posedge adc_clk or posedge rst)
begin
	if(rst)
	begin
		wr_burst_data_reg <= {MEM_DATA_BITS{1'b0}};
		wr_cnt <= 8'd0;
	end
	else if(state == MEM_WRITE)
	begin
		if(wr_burst_data_req)
        begin
            wr_burst_data_reg <= wr_burst_data_reg_tmp;
            wr_cnt <= wr_cnt + 8'd1;
        end
//		else if(wr_burst_finish)
//			wr_cnt <= 8'd0;
	end
end

/////////////////////////////////////////////////////////
//	这里只处理数据的读
always@(posedge adc_clk or posedge rst)
begin
	if(rst)
	begin
		rd_cnt <= 8'd0;
	end
	else if(state == MEM_READ)
	begin
		if(rd_burst_data_valid )
			begin
				rd_cnt <= rd_cnt + 8'd1;
			end
		else if(rd_burst_finish)
			rd_cnt <= 8'd0;
	end
	else
		rd_cnt <= 8'd0;
end


//	状态机只处理状态的跳转，实际数据的读和写在上方的代码中
always@(posedge adc_clk or posedge rst)
begin
	if(rst)
	begin
		state <= IDLE;
		wr_burst_req <= 1'b0;
		rd_burst_req <= 1'b0;
		rd_burst_len <= BURST_LEN;
		wr_burst_len <= BURST_LEN;
		rd_burst_addr <= INIT_ADDR;
        wr_burst_addr <= INIT_ADDR;
		write_read_len <= 32'd0;
		pl_cnt <= 32'd0;
	end
	else
	begin
		case(state)
			IDLE:
			begin
				if( pl_key_state == ~pl_key_state0 ) begin
				    if( (adc_cnt == 5'b00000) || (adc_cnt == 5'b10000) ) begin
                        state <= MEM_WRITE;
                        wr_burst_req <= 1'b1;
                        wr_burst_len <= BURST_LEN;
                        pl_cnt <= pl_cnt + 32'd1;			// 每完成一次"写、读、地址递增"，计数器就+1
					end
				end
				else begin
					if( pl_cnt == PL_CNT_MAX )
                        state <= MEM_RESET;
				end
			end
			MEM_WRITE:
			begin
				if(wr_burst_finish)
				begin
					state <= IDLE;
					wr_burst_req <= 1'b0;
//					write_read_len <= write_read_len + BURST_LEN;
					wr_burst_addr <= wr_burst_addr + BURST_LEN;	// 地址一直递增
				end
			end
			MEM_RESET:
			begin
			    wr_burst_addr <= INIT_ADDR;
                pl_cnt <= 32'd0;
                state <= IDLE;
			end
			default:
				state <= IDLE;
		endcase
	end
end

always@(posedge adc_clk)
begin
	if( pl_cnt == PL_CNT_MAX-1 )
		pl_key_state0 <= ~pl_key_state0;	// 将pl_key_state0状态翻转（这行代码所在的位置很重要）
end

endmodule
