module mem_test
	#(
		parameter MEM_DATA_BITS = 64,						/* 64 = 16*4 */
		parameter ADDR_BITS = 32
	)
	(
		input rst,                                 			/*复位*/
		input mem_clk,                               		/*接口时钟*/
		output reg rd_burst_req,                          	/*读请求*/
		output reg wr_burst_req,                          	/*写请求*/
		output reg[9:0] rd_burst_len,                     	/*读数据长度*/
		output reg[9:0] wr_burst_len,                     	/*写数据长度*/
		output reg[ADDR_BITS - 1:0] rd_burst_addr,        	/*读首地址*/
		output reg[ADDR_BITS - 1:0] wr_burst_addr,        	/*写首地址*/
		input rd_burst_data_valid,                  		/*读出数据有效*/
		input wr_burst_data_req,                    		/*写数据信号*/
		input[MEM_DATA_BITS - 1:0] rd_burst_data,   		/*读出的数据*/
		output[MEM_DATA_BITS - 1:0] wr_burst_data,    		/*写入的数据*/
		input rd_burst_finish,                      		/*读完成*/
		input wr_burst_finish,                      		/*写完成*/
		
//		input EF_FR_p,			//	E&F frame clock
//		input EF_FR_n,			//	E&F frame clock
		
//		input GH_FR_p,			//	G&H frame clock
//		input GH_FR_n,			//	G&H frame clock
		
//		input EF_DCO_p,			//	E&F data clock
//		input EF_DCO_n,			//	E&F data clock
		
//		input GH_DCO_p,			//	G&H data clock
//		input GH_DCO_n,			//	G&H data clock

        input ENC,

		input EF_FR,			//	E&F frame clock
		input GH_FR,			//	G&H frame clock
		
		input EF_DCO,			//	E&F data clock
		input GH_DCO,			//	G&H data clock

		input EOUT,				//	E output bit
		input FOUT,				//	F output bit
		input GOUT,				//	G output bit
		inout HOUT,				//	H output bit
		
		output status,            // 1表示指定次数的采样已经完成，0表示未完成
		output error
	);
	
	assign error = 1'b0;

    reg[2:0] state;
    reg ddr_state = 1'b0, ddr_state0 = 1'b0;
	parameter BURST_LEN = 1;	//在当前的例子中，摁一下PL按键将连续采集发送4次
	parameter IDLE         = 3'd0;
	parameter MEM_READ     = 3'd1;
	parameter MEM_WRITE    = 3'd2;

//	在DDR中写数据时的初始地址：
	parameter INIT_ADDR = 'h02000000;  // 这是个特殊的初始位置

	reg[7:0] wr_cnt;
	reg[MEM_DATA_BITS - 1:0] wr_burst_data_reg;
	assign wr_burst_data = wr_burst_data_reg;
	reg[7:0] rd_cnt;
	reg[31:0] write_read_len;
	//assign error = (state == MEM_READ) && rd_burst_data_valid && (rd_burst_data != {(MEM_DATA_BITS/8){rd_cnt}});

	reg [31:0] pl_cnt;			// 记录连续“写、读、地址递增”的次数
//	parameter PL_CNT_MAX = 1024*1024;
	parameter PL_CNT_MAX = 32'b10000000000;

    reg status_r = 1'b0;
    assign status = status_r;

//	always@(posedge fclk or posedge rst)
//	begin
//		if(rst)
//			error <= 1'b0;
//		else if(state == MEM_READ && rd_burst_data_valid && rd_burst_data != {(MEM_DATA_BITS/8){rd_cnt}})
//			error <= 1'b1;
//	end

	// ===============================================================
	//	这里只处理数据的写：将ADC采集的数据拼接起来，组成4×16=64位长度的数据
    reg reg_flag_EF = 1'b0;
    reg reg_flag_GH = 1'b0;
    
	reg [15:0] px10, px20;	//	channel E
	reg [15:0] px11, px21;	//	channel F
	reg [15:0] px12, px22;	//	channel G
	reg [15:0] px13, px23;	//	channel H
	
////  用data clock对数据采样
//	always@(posedge EF_DCO or negedge EF_DCO or posedge rst) begin
//		if( rst ) begin
//			px10 <= 16'b0;
//			px11 <= 16'b0;
//			px20 <= 16'b0;
//			px21 <= 16'b0;
//		end
//        else if( EF_DCO | ~EF_DCO ) begin
//			if( reg_flag == 1'b0 ) begin	// handle the first 16 bits
//				px10 <= {px10[14:0], EOUT};
//                px11 <= {px11[14:0], FOUT};
//			end
//			else begin			// handle the rest 16 bits
//				px20 <= {px20[14:0], EOUT};
//				px21 <= {px21[14:0], FOUT};
//			end
//		end
//	end

//	always@(posedge GH_DCO or negedge GH_DCO or posedge rst) begin
//		if( rst ) begin
//			px12 <= 16'b0;
//			px13 <= 16'b0;
//			px22 <= 16'b0;
//			px23 <= 16'b0;
//		end
//        else if( GH_DCO | ~GH_DCO ) begin
//			if( reg_flag == 1'b0 ) begin	// handle the first 16 bits
//				px12 <= {px12[14:0], GOUT};
//				px13 <= {px13[14:0], HOUT};
//			end
//			else begin			// handle the rest 16 bits
//				px22 <= {px22[14:0], GOUT};
//				px23 <= {px23[14:0], HOUT};
//			end
//		end
//	end


//  用data clock对数据采样
    wire E_q1, E_q2;
    wire F_q1, F_q2;
    wire G_q1, G_q2;
    wire H_q1, H_q2;
    
    IDDR #(
        .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED"
        .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) ch_E (
            .Q1(E_q1), // 1-bit output for positive edge of clock 
            .Q2(E_q2), // 1-bit output for negative edge of clock
            .C(EF_DCO),   // 1-bit clock input
            .CE(1'b1), // 1-bit clock enable input
            .D(EOUT),   // 1-bit DDR data input
            .R(1'b0),   // 1-bit reset
            .S(1'b0)    // 1-bit set
        );

    IDDR #(
        .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED"
        .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) ch_F (
            .Q1(F_q1), // 1-bit output for positive edge of clock 
            .Q2(F_q2), // 1-bit output for negative edge of clock
            .C(EF_DCO),   // 1-bit clock input
            .CE(1'b1), // 1-bit clock enable input
            .D(FOUT),   // 1-bit DDR data input
            .R(1'b0),   // 1-bit reset
            .S(1'b0)    // 1-bit set
        );
        
    IDDR #(
        .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED"
        .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) ch_G (
            .Q1(G_q1), // 1-bit output for positive edge of clock 
            .Q2(G_q2), // 1-bit output for negative edge of clock
            .C(GH_DCO),   // 1-bit clock input
            .CE(1'b1), // 1-bit clock enable input
            .D(GOUT),   // 1-bit DDR data input
            .R(1'b0),   // 1-bit reset
            .S(1'b0)    // 1-bit set
        );    

    IDDR #(
        .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" or "SAME_EDGE_PIPELINED"
        .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC" 
        ) ch_H (
            .Q1(H_q1), // 1-bit output for positive edge of clock 
            .Q2(H_q2), // 1-bit output for negative edge of clock
            .C(GH_DCO),   // 1-bit clock input
            .CE(1'b1), // 1-bit clock enable input
            .D(HOUT),   // 1-bit DDR data input
            .R(1'b0),   // 1-bit reset
            .S(1'b0)    // 1-bit set
        );
    
	always@( posedge EF_DCO ) begin
        if( ~reg_flag_EF ) begin	// handle the first 16 bits
            px10 <= {px10[13:0], E_q1, E_q2};
            px11 <= {px11[13:0], F_q1, F_q2};
        end
        else begin			// handle the rest 16 bits
            px20 <= {px20[13:0], E_q1, E_q2};
            px21 <= {px21[13:0], F_q1, F_q2};
        end
    end

	always@( posedge GH_DCO ) begin
        if( ~reg_flag_GH ) begin	// handle the first 16 bits
            px12 <= {px12[13:0], G_q1, G_q2};
            px13 <= {px13[13:0], H_q1, H_q2};
        end
        else begin			// handle the rest 16 bits
            px22 <= {px22[13:0], G_q1, G_q2};
            px23 <= {px23[13:0], H_q1, H_q2};
        end
	end

	
//  用Frame clock的上升沿来改变应该往哪个“16位”寄存器中“写”入数据
    always@( posedge EF_FR ) begin
        reg_flag_EF <= ~reg_flag_EF;
    end
    
    always@( posedge GH_FR ) begin
        reg_flag_GH <= ~reg_flag_GH;
    end

//  用某个芯片的frame clock下降沿触发往DDR写数据，能够比较有效避免不同芯片间的延时带来的不同步问题
    reg[63:0] wr_burst_data_reg_tmp;
    always@( negedge EF_FR or posedge rst ) begin
	   if( rst ) begin
//	       wr_burst_data_reg_tmp    <= 64'b0;
           rd_burst_addr            <= INIT_ADDR;
           wr_burst_addr            <= INIT_ADDR;
           pl_cnt                   <= 32'b0;
           status_r                 <= 1'b0;
           ddr_state                <= 1'b0;
	   end
	   else begin
           if( reg_flag_EF ) // 这里用reg_flag_EF或reg_flag_GH都可以
//               wr_burst_data_reg_tmp <= {px10,px11,px12,px13};
               wr_burst_data_reg_tmp <= {px10[13:0],px20[1:0], px11[13:0],px21[1:0], px12[13:0],px22[1:0], px13[13:0],px23[1:0]};
           else
//               wr_burst_data_reg_tmp <= {px20,px21,px22,px23};
               wr_burst_data_reg_tmp <= {px20[13:0],px10[1:0], px21[13:0],px11[1:0], px22[13:0],px12[1:0], px23[13:0],px13[1:0]};

// 测试往DDR写数据是否正常：已经检查了，OK！
// 同时确定了字节序
//           if( !reg_flag == 1'b0 )
//               wr_burst_data_reg_tmp <= {16'haaaa,16'hbbbb,16'hcccc,16'hdddd};
//           else
//               wr_burst_data_reg_tmp <= {16'hdddd,16'hcccc,16'hbbbb,16'haaaa};
       
       // 测试数据组合在内存中排列的位置
//           wr_burst_data_reg_tmp <= {16'haaaa,16'hbbbb,16'hcccc,16'hdddd};
           
//           reg_flag <= reg_flag + 1'b1;
           
           if( pl_cnt >= PL_CNT_MAX ) begin
                rd_burst_addr <= INIT_ADDR;
                wr_burst_addr <= INIT_ADDR;
                pl_cnt        <= 32'b0;
                status_r      <= 1'b1;
           end
           else begin
               if( status_r == 1'b0 )
                   ddr_state   <= ~ddr_state;                  // 生成触发写DDR的信号
               
               wr_burst_addr   <= wr_burst_addr + BURST_LEN;    // 地址一直递增
               rd_burst_addr   <= rd_burst_addr + BURST_LEN;   // 地址一直递增
               pl_cnt          <= pl_cnt + 32'b1;                // 每完成一次"写、读、地址递增"，计数器就+1
          end
       end
	end

	// =======================================================
	// 往DDR中写数据
	always@(posedge mem_clk or posedge rst) begin
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
		end
	end

	// =======================================================
	//	这里只处理数据的读
	always@(posedge mem_clk or posedge rst)
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

	// =======================================================
	//	状态机只处理状态的跳转，实际数据的读和写在上方的代码中
	always@(posedge mem_clk or posedge rst)
	begin
		if(rst)
		begin
			state            <= IDLE;
			wr_burst_req     <= 1'b0;
			rd_burst_req     <= 1'b0;
			rd_burst_len     <= BURST_LEN;
			wr_burst_len     <= BURST_LEN;
			write_read_len   <= 32'd0;
			ddr_state0       <= 1'b0;
		end
		else
		begin
			case(state)
				IDLE:
				begin
				    if( ddr_state != ddr_state0 ) begin
                        state <= MEM_WRITE;
                        wr_burst_req <= 1'b1;   // DDR的写请求
                        wr_burst_len <= BURST_LEN;
                    end
                end
				MEM_WRITE:
				begin
					if(wr_burst_finish)
					begin
						state <= IDLE;
						wr_burst_req <= 1'b0;
						ddr_state0 <= ~ddr_state0;
					end
				end
				default:
					state <= IDLE;
			endcase
		end
	end

endmodule
