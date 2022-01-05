

`timescale 1 ps / 1 ps
module lua_cpu (
		input  wire [31:0] nios_lua_exec_slave_dataa,   // nios_lua_exec_slave.dataa
		input  wire [31:0] nios_lua_exec_slave_datab,   //                    .datab
		output reg  [31:0] nios_lua_exec_slave_result,  //                    .result
		input  wire        nios_lua_exec_slave_clk,     //                    .clk
		input  wire        nios_lua_exec_slave_clk_en,  //                    .clk_en
		input  wire        nios_lua_exec_slave_start,   //                    .start
		output reg         nios_lua_exec_slave_done,    //                    .done
		input  wire [4:0]  nios_lua_exec_slave_a,       //                    .a
		input  wire [4:0]  nios_lua_exec_slave_b,       //                    .b
		input  wire [4:0]  nios_lua_exec_slave_c,       //                    .c
		input  wire [1:0]  nios_lua_exec_slave_n,       //                    .n
		input  wire        nios_lua_exec_slave_readra,  //                    .readra
		input  wire        nios_lua_exec_slave_readrb,  //                    .readrb
		input  wire        nios_lua_exec_slave_reset,   //                    .reset
		input  wire        nios_lua_exec_slave_writerc, //                    .writerc
		output reg  [31:0] avalon_master_address,       //       avalon_master.address
		input  wire [31:0] avalon_master_readdata,      //                    .readdata
		output reg  [31:0] avalon_master_writedata,     //                    .writedata
		output reg         avalon_master_read,          //                    .read
		output reg         avalon_master_write,         //                    .write
		input  wire        avalon_master_waitrequest,   //                    .waitrequest
		input  wire        clock_sink_clk,              //          clock_sink.clk
		input  wire        reset_sink_reset             //          reset_sink.reset
	);
	// execution state constants
	localparam EX_START = 4'd0;
	localparam EX_GET_PC = 4'd1;
	localparam EX_FETCH_INSTR = 4'd2;
	localparam EX_WB_PC = 4'd3;
	localparam EX_FETCH_RA = 4'd4;
	localparam EX_FINISH = 4'd15;
	
	// wire aliases
	wire main_clk, main_rst;
	wire nios_clk, nios_rst, nios_clk_en;
	wire nios_start;
	wire mem_wait;
	wire[31:0] L, ci;
	wire[31:0] mem_rdata;
	reg nios_done;
	reg mem_r, mem_w;
	reg[31:0] nios_result;
	reg[31:0] mem_addr, mem_wdata;
	
	
	assign main_clk = clock_sink_clk;
	assign main_rst = reset_sink_reset;
	assign nios_clk_en = nios_lua_exec_slave_clk_en;
	assign nios_clk = nios_lua_exec_slave_clk;
	assign nios_rst = nios_lua_exec_slave_reset;
	assign nios_start = nios_lua_exec_slave_start;
	assign L = nios_lua_exec_slave_dataa;
	assign ci = nios_lua_exec_slave_datab;
	assign mem_rdata = avalon_master_readdata;
	assign mem_wait = avalon_master_waitrequest;
	
	always @* begin
		avalon_master_address = mem_addr;
		nios_lua_exec_slave_result = nios_result;
		nios_lua_exec_slave_done = nios_done;
		avalon_master_writedata = mem_wdata;
		avalon_master_read = mem_r;
		avalon_master_write = mem_w;
	end
	
	// internal registers
	reg[3:0] ex_state;
	reg[31:0] ci_u_l_savedpc_v;
	reg[31:0] instruction;
	
	// internal signals
	reg[31:0] ci_u_l_p;
	reg[31:0] ci_u_l_savedpc_p;
	reg[31:0] ci_u_l_savedpc_incr_v;
	reg[7:0] A;
	reg[8:0] B;
	reg[8:0] C;
	reg[17:0] Bx;
	reg signed[17:0] sBx;
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars();
		$dumpon();
	end

	always @* begin
		ci_u_l_p = ci + 32'd16;
		ci_u_l_savedpc_p = ci_u_l_p + 32'd4;
		ci_u_l_savedpc_incr_v = ci_u_l_savedpc_v + 32'd4;
		A = instruction[7:0];
		B = instruction[16:8];
		C = instruction[25:17];
		Bx = instruction[25:8];
		sBx = $signed(Bx);
	end
	
	// avalon master clock domain
	always @(posedge main_clk or posedge main_rst) begin
		if (main_rst) begin
			ex_state <= EX_START;
			ci_u_l_savedpc_v <= 32'd0;
			instruction <= 32'd0;
		end else if (nios_clk_en) begin // is this really needed? different clock domain
			case(ex_state)
				EX_START: begin
					if (nios_start)
						ex_state <= EX_GET_PC;
				end
				EX_GET_PC: begin
					if (!mem_wait) begin
						ci_u_l_savedpc_v <= mem_rdata;
						ex_state <= EX_WB_PC;
					end
				end
				EX_WB_PC: begin
					if (!mem_wait)
						ex_state <= EX_FETCH_INSTR;
				end
				EX_FETCH_INSTR: begin
					if (!mem_wait) begin
						instruction <= mem_rdata;
						//ex_state <= EX_FETCH_RA;
						ex_state <= EX_FINISH;
					end
				end
				EX_FETCH_RA: begin
					
				end
				EX_FINISH: begin
					ex_state <= EX_START;
				end
				default: begin end
			endcase
		end
	end
	
	// nios 2 clock domain
	always @(posedge nios_clk or posedge nios_rst) begin
		
	end

	always @* begin
		mem_addr = 32'd0;
		mem_wdata = 32'd0;
		mem_r = 1'd0;
		mem_w = 1'd0;
		nios_done = 1'd0;
		nios_result = 32'd0;
		case(ex_state)
			EX_START: begin end
			EX_GET_PC: begin
				mem_addr = ci_u_l_savedpc_p;
				mem_r = 1'd1;
			end
			EX_WB_PC: begin
				mem_addr = ci_u_l_savedpc_p;
				mem_w = 1'd1;
				mem_wdata = ci_u_l_savedpc_incr_v;
			end
			EX_FETCH_INSTR: begin
				mem_addr = ci_u_l_savedpc_v;
				mem_r = 1'd1;
			end
			EX_FETCH_RA: begin
				
			end
			EX_FINISH: begin
				nios_result = instruction;
				nios_done = 1'd1;
			end
			default: begin end
		endcase
	end
	
endmodule
