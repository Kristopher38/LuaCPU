`timescale 1 ps / 1 ps

`define INSTR_IN_PROGRESS 2'd0
`define INSTR_DONE 2'd1
`define INSTR_ERROR 2'd2
`define INSTR_NOT_IMPL 2'd3

`define A_SOURCE_INSTR 2'd0
`define A_SOURCE_REGDUMPER 2'd1
`define A_SOURCE_EXTERNAL 2'd3

`define TTAG_SIZE 7
`define REG_COUNT 64
`define REG_COUNT_M1 6'd63
`define REG_ADDR_BITS 6

`define T_NIL 0
`define T_INTEGER 1
`define T_NUMBER 2
`define T_STRING 3
`define T_TABLE 4
`define T_FUNCTION 5
`define T_OTHER 6

module instruction_register(
	output reg[31:0] mem_address,
	input wire[31:0] mem_readdata,
	output reg[31:0] mem_writedata,
	output reg mem_read,
	output reg mem_write,
	input wire mem_waitrequest,

	output reg[31:0] instruction,
	input reg[31:0] PC,

	output reg done,
	input wire fetch_instr,
	input wire clk,
	input wire rst
);
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			instruction <= 32'd0;
			done <= 1'd0;
		end else if (fetch_instr && !mem_waitrequest) begin
			instruction <= mem_readdata;
			done <= 1'd1;
		end else
			done <= 1'd0;
	end

	always @* begin
		mem_address = 32'd0;
		mem_read = 1'd0;
		if (fetch_instr && !done) begin
			mem_address = PC;
			mem_read = 1'd1;
		end
	end

endmodule

module program_counter(
	output reg[31:0] mem_address,
	input wire[31:0] mem_readdata,
	output reg[31:0] mem_writedata,
	output reg mem_read,
	output reg mem_write,
	input wire mem_waitrequest,

	output reg[31:0] PC,
	// done is used only for fetch_pc and store_pc
	output reg done,
	input wire[31:0] ci,
	input wire[31:0] load_data,
	input wire fetch_pc,
	input wire store_pc,
	input wire incr_pc,
	input wire load_pc,

	input wire clk,
	input wire rst
);
	// signals
	reg[31:0] ci_u_l_p;
	reg[31:0] ci_u_l_savedpc_p;
	reg[31:0] next_PC;

	always @* begin
		ci_u_l_p = ci + 32'd16;
		ci_u_l_savedpc_p = ci_u_l_p + 32'd4;
		next_PC = PC + 32'd4;
	end

	always @* begin
		mem_address = 32'd0;
		mem_writedata = 32'd0;
		mem_read = 1'd0;
		mem_write = 1'd0;
		if (fetch_pc && !done) begin
			mem_address = ci_u_l_savedpc_p;
			mem_read = 1'd1;
		end else if (store_pc && !done) begin
			mem_address = ci_u_l_savedpc_p;
			mem_write = 1'd1;
			mem_writedata = PC;
		end
	end

	always @(posedge clk or posedge rst) begin
		if (rst)
			PC <= 32'd0;
		else if (fetch_pc && !mem_waitrequest) begin
			PC <= mem_readdata;
			done <= 1'd1;
		end else if (incr_pc)
			PC <= next_PC;
		else if (load_pc)
			PC <= load_data;
		else if (store_pc && !mem_waitrequest)
			done <= 1'd1;	// this could be potentially signalled one cycle earlier
		else
			done <= 1'd0;
	end
endmodule

module decoder(
	output reg[5:0] opcode,
	output reg[7:0] A,
	output reg[8:0] B,
	output reg[8:0] C,
	output reg[17:0] Bx,
	output reg signed[17:0] sBx,
	input reg[31:0] instruction
);
	always @* begin
		opcode = instruction[5:0];
		A = instruction[13:6];
		C = instruction[22:14];
		B = instruction[31:23];
		Bx = instruction[31:14];
		sBx = $signed(Bx);
	end
endmodule

module register_dumper(
	output reg[31:0] mem_address,
	output reg[31:0] mem_writedata,
	output reg mem_write,
	input wire mem_waitrequest,

	output reg[`REG_ADDR_BITS-1:0] reg_idx,
	input reg[31:0] reg_data,
	input reg[`TTAG_SIZE-1:0] reg_type,
	input reg reg_dirty,
	input reg reg_valid,
	output reg done,
	input reg[31:0] base,
	input reg start,
	input wire clk,
	input wire rst
);
	localparam PHASE_START = 2'd0;
	localparam PHASE_WRITEDATA = 2'd1;
	localparam PHASE_WRITETYPE = 2'd2;
	localparam PHASE_DONE = 2'd3;
	reg[1:0] phase;
	reg[`REG_ADDR_BITS-1:0] cur_reg;
	reg[31:0] mem_reg_addr;
	reg write_done;
	reg should_write;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			phase <= PHASE_START;
			cur_reg <= `REG_ADDR_BITS'd0;
		end else begin
			case(phase)
				PHASE_START: begin
					if (start) begin
						cur_reg <= `REG_ADDR_BITS'd0;
						phase <= PHASE_WRITEDATA;
					end
				end
				PHASE_WRITEDATA: begin
					if (write_done)
						if (should_write)
							phase <= PHASE_WRITETYPE;
						else if (cur_reg == `REG_COUNT_M1)
							phase <= PHASE_DONE;
						else
							cur_reg <= cur_reg + 1;
				end
				PHASE_WRITETYPE: begin
					if (write_done) begin
						if (cur_reg == `REG_COUNT_M1)
							phase <= PHASE_DONE;
						else
							phase <= PHASE_WRITEDATA;
						cur_reg <= cur_reg + 1;
					end
				end
				PHASE_DONE: begin
					phase <= PHASE_START;
				end
			endcase
		end

	end

	always @* begin
		mem_address = 32'd0;
		mem_writedata = 32'd0;
		mem_write = 1'd0;
		mem_reg_addr = base + ({{(32-`REG_ADDR_BITS){1'd0}}, cur_reg} << 3); // shift by log2(sizeof(TValue))
		done = phase == PHASE_DONE;
		should_write = reg_dirty && reg_valid;
		write_done = should_write ? !mem_waitrequest : 1'd1;
		reg_idx = cur_reg;
		if (phase == PHASE_WRITEDATA && should_write) begin
			mem_address = mem_reg_addr;
			mem_writedata = reg_data;
			mem_write = 1'd1;
		end else if (phase == PHASE_WRITETYPE && should_write) begin
			mem_address = mem_reg_addr + 4; // add 4 to write into type field	
			mem_writedata = {{(32-`TTAG_SIZE){1'd0}}, reg_type};
			mem_write = 1'd1;
		end
	end
endmodule

module register_file(
	input reg[`REG_ADDR_BITS-1:0] idx_a,
	input reg[`REG_ADDR_BITS-1:0] idx_b,
	input reg[`REG_ADDR_BITS-1:0] idx_c,
	input reg[31:0] writedata_a,
	input reg[`TTAG_SIZE-1:0] writetype_a,
	/* verilator lint_off UNOPTFLAT */
	output reg[31:0] data_a,
	output reg[31:0] data_b,
	output reg[31:0] data_c,
	output reg[`TTAG_SIZE-1:0] type_a,
	output reg[`TTAG_SIZE-1:0] type_b,
	output reg[`TTAG_SIZE-1:0] type_c,
	output reg dirty_a,
	output reg valid_a,
	output reg global_dirty,
	/* verilator lint_on UNOPTFLAT */
	input reg writedata_a_en,
	input reg writetype_a_en,
	input reg[1:0] write_src,
	input reg rst_dirty,
	input reg rst_valid,
	input wire clk,
	input wire rst
);
	reg[31:0] regs[`REG_COUNT-1:0];
	reg[`TTAG_SIZE-1:0] ttags[`REG_COUNT-1:0];
	reg dirty[`REG_COUNT-1:0];
	reg valid[`REG_COUNT-1:0];
	integer i;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			for (i = 0; i < `REG_COUNT; i = i + 1) begin
				regs[i] <= 32'd0;
				ttags[i] <= `T_NIL;
				dirty[i] <= 1'd0;
				valid[i] <= 1'd0;
			end
			global_dirty <= 1'd0;
		end else if (rst_dirty || rst_valid) begin
			if (rst_dirty) begin
				for (i = 0; i < `REG_COUNT; i = i + 1) begin
					dirty[i] <= 1'd0;
				end
				global_dirty <= 1'd0;
			end
			if (rst_valid) begin
				for (i = 0; i < `REG_COUNT; i = i + 1) begin
					valid[i] <= 1'd0;
				end
			end
		end else begin 
			if (writedata_a_en) begin
				regs[idx_a] <= writedata_a;
				valid[idx_a] <= 1'd1;	// assume writing type tag follows writing data if necessary
				if (write_src != `A_SOURCE_EXTERNAL) begin
					dirty[idx_a] <= 1'd1;
					global_dirty <= 1'd1;
				end
			end
			if (writetype_a_en) begin
				ttags[idx_a] <= writetype_a;
				if (write_src != `A_SOURCE_EXTERNAL) begin
					dirty[idx_a] <= 1'd1;
					global_dirty <= 1'd1;
				end
			end
		end
	end

	always @* begin
		data_a = writedata_a_en ? writedata_a : regs[idx_a];
		data_b = regs[idx_b];
		data_c = regs[idx_c];
		type_a = writetype_a_en ? writetype_a : ttags[idx_a];
		type_b = ttags[idx_b];
		type_c = ttags[idx_c];
		dirty_a = dirty[idx_a];
		valid_a = valid[idx_a];
	end
endmodule

module base_register(
	input reg write,
	input reg[31:0] writedata,
	output reg[31:0] base,
	input wire clk,
	input wire rst
);
	always @(posedge clk or posedge rst) begin
		if (rst)
			base <= 32'd0;
		else if (write)
			base <= writedata;
	end
endmodule

module instr_sequencer(
	input reg start,
	input reg[5:0] opcode,
	input reg[31:0] data_a,
	input reg[31:0] data_b,
	input reg[31:0] data_c,
	input reg[`TTAG_SIZE-1:0] tt_a,
	input reg[`TTAG_SIZE-1:0] tt_b,
	input reg[`TTAG_SIZE-1:0] tt_c,

	input reg[17:0] Bx,
	input reg signed[17:0] sBx,

	/* verilator lint_off UNOPTFLAT */
	output reg[31:0] writedata_a,
	output reg[`TTAG_SIZE-1:0] writetype_a,
	output reg writedata_a_en,
	output reg writetype_a_en,
	/* verilator lint_on UNOPTFLAT */
	output reg[1:0] instr_status,
	input wire clk,
	input wire rst
);
	// opcodes
	localparam OP_MOVE = 0;
	localparam OP_LOADK = 1;
	localparam OP_LOADKX = 2;
	localparam OP_LOADBOOL = 3;
	localparam OP_LOADNIL = 4;
	localparam OP_GETUPVAL = 5;
	localparam OP_GETTABUP = 6;
	localparam OP_GETTABLE = 7;
	localparam OP_SETTABUP = 8;
	localparam OP_SETUPVAL = 9;
	localparam OP_SETTABLE = 10;
	localparam OP_NEWTABLE = 11;
	localparam OP_SELF = 12;
	localparam OP_ADD = 13;
	localparam OP_SUB = 14;
	localparam OP_MUL = 15;
	localparam OP_MOD = 16;
	localparam OP_POW = 17;
	localparam OP_DIV = 18;
	localparam OP_IDIV = 19;
	localparam OP_BAND = 20;
	localparam OP_BOR = 21;
	localparam OP_BXOR = 22;
	localparam OP_SHL = 23;
	localparam OP_SHR = 24;
	localparam OP_UNM = 25;
	localparam OP_BNOT = 26;
	localparam OP_NOT = 27;
	localparam OP_LEN = 28;
	localparam OP_CONCAT = 29;
	localparam OP_JMP = 30;
	localparam OP_EQ = 31;
	localparam OP_LT = 32;
	localparam OP_LE = 33;
	localparam OP_TEST = 34;
	localparam OP_TESTSET = 35;
	localparam OP_CALL = 36;
	localparam OP_TAILCALL = 37;
	localparam OP_RETURN = 38;
	localparam OP_FORLOOP = 39;
	localparam OP_FORPREP = 40;
	localparam OP_TFORCALL = 41;
	localparam OP_TFORLOOP = 42;
	localparam OP_SETLIST = 43;
	localparam OP_CLOSURE = 44;
	localparam OP_VARARG = 45;
	localparam OP_EXTRAARG = 46;

	always @(posedge clk or negedge rst) begin
		if (rst)
			instr_status <= `INSTR_IN_PROGRESS;
		else if (start) begin
			case(opcode)
				OP_MOVE: instr_status <= `INSTR_DONE;
				default: instr_status <= `INSTR_NOT_IMPL;
			endcase
		end else
			instr_status <= `INSTR_IN_PROGRESS;
	end

	always @* begin
		writedata_a = 32'd0;
		writetype_a = `T_NIL;
		writedata_a_en = 1'd0;
		writetype_a_en = 1'd0;
		if (start) begin
			case(opcode)
				OP_MOVE: begin
					writedata_a = data_b;
					writetype_a = tt_b;
					writedata_a_en = 1'd1;
					writetype_a_en = 1'd1;
				end
				default: begin end
			endcase
		end
	end
endmodule

module main_sequencer(
	output reg fetch_pc,
	output reg store_pc,
	output reg incr_pc,
	output reg load_pc,
	output reg fetch_instr,
	output reg writedata_a_en,
	output reg writetype_a_en,
	output reg[1:0] write_a_source,
	output reg write_base,
	output reg run_instr,
	output reg store_regs,
	output reg dirty_clear_rf,
	output reg valid_clear_rf,

	output reg done_cpu,
	
	input wire global_dirty_rf,
	input wire done_pc,
	input wire done_ir,
	input wire done_regdump,
	input wire[1:0] instr_status,
	input wire nios_start,
	input wire[1:0] nios_n,
	input wire clk_en,
	input wire clk,
	input wire rst
);
	// execution state constants
	localparam EX_START = 4'd0;
	localparam EX_FETCH_PC = 4'd1;
	localparam EX_FETCH_INSTR = 4'd2;
	localparam EX_STORE_PC = 4'd3;
	localparam EX_EXEC_INSTR = 4'd4;
	localparam EX_LOAD_REG = 4'd5;
	localparam EX_LOAD_TT = 4'd6;
	localparam EX_LOAD_BASE = 4'd7;
	localparam EX_STORE_REGS = 4'd8;
	localparam EX_FINISH = 4'd15;

	reg[3:0] ex_state;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ex_state <= EX_START;
		end else if (clk_en) begin
			case(ex_state)
				EX_START: begin
					if (nios_start) begin
						case(nios_n)
							2'd0: ex_state <= EX_FETCH_PC;
							2'd1: ex_state <= EX_LOAD_REG;
							2'd2: ex_state <= EX_LOAD_TT;
							2'd3: ex_state <= EX_LOAD_BASE;
						endcase
					end
				end
				EX_FETCH_PC: begin
					if (done_pc)
						ex_state <= EX_FETCH_INSTR;
				end
				EX_STORE_PC: begin
					if (done_pc)
						if (global_dirty_rf)
							ex_state <= EX_STORE_REGS;
						else
							ex_state <= EX_FINISH;
				end
				EX_STORE_REGS: begin
					if (done_regdump)
						ex_state <= EX_FINISH;
				end
				EX_FETCH_INSTR: begin
					if (done_ir)
						ex_state <= EX_EXEC_INSTR;
				end
				EX_EXEC_INSTR: begin
					case(instr_status)
						`INSTR_IN_PROGRESS: ex_state <= EX_EXEC_INSTR;
						`INSTR_DONE: ex_state <= EX_FETCH_INSTR;
						`INSTR_ERROR: ex_state <= EX_STORE_PC;
						`INSTR_NOT_IMPL: ex_state <= EX_STORE_PC;
					endcase
				end
				EX_LOAD_REG: begin
					ex_state <= EX_FINISH;
				end
				EX_LOAD_TT: begin
					ex_state <= EX_FINISH;
				end
				EX_LOAD_BASE: begin
					ex_state <= EX_FINISH;
				end
				EX_FINISH: begin
					ex_state <= EX_START;
				end
				default: begin end
			endcase
		end
	end

	always @* begin
		fetch_pc = 1'd0;
		store_pc = 1'd0;
		fetch_instr = 1'd0;
		incr_pc = 1'd0;
		write_a_source = `A_SOURCE_INSTR;
		writedata_a_en = 1'd0;
		writetype_a_en = 1'd0;
		write_base = 1'd0;
		done_cpu = 1'd0;
		run_instr = 1'd0;
		store_regs = 1'd0;
		dirty_clear_rf = 1'd0;
		valid_clear_rf = 1'd0;
		case(ex_state)
			EX_START: begin end
			EX_FETCH_PC: begin
				fetch_pc = 1'd1;
			end
			EX_STORE_PC: begin
				store_pc = 1'd1;
			end
			EX_STORE_REGS: begin
				write_a_source = `A_SOURCE_REGDUMPER;
				store_regs = 1'b1;
			end
			EX_FETCH_INSTR: begin
				fetch_instr = 1'd1;
				if (done_ir)
					incr_pc = 1'd1;
			end
			EX_EXEC_INSTR: begin
				write_a_source = `A_SOURCE_INSTR;
				run_instr = 1'd1;
			end
			EX_LOAD_REG: begin
				write_a_source = `A_SOURCE_EXTERNAL;
				writedata_a_en = 1'd1;
			end
			EX_LOAD_TT: begin
				write_a_source = `A_SOURCE_EXTERNAL;
				writetype_a_en = 1'd1;
			end
			EX_LOAD_BASE: begin
				write_base = 1'd1;
				dirty_clear_rf = 1'd1;
				valid_clear_rf = 1'd1;
			end
			EX_FINISH: begin
				done_cpu = 1'd1;
				dirty_clear_rf = 1'd1;
			end
			default: begin end
		endcase
	end
endmodule

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
	
	
	// wire aliases
	wire main_clk, main_rst;
	wire nios_clk, nios_rst, nios_clk_en;
	wire nios_start;
	wire mem_wait;
	wire[31:0] L, ci, reg_base, reg_val, reg_type;
	wire[1:0] n;
	wire[31:0] mem_rdata;
	reg nios_done;
	reg mem_r, mem_w;
	reg[31:0] nios_result;
	reg[31:0] mem_addr, mem_wdata;
	
	
	assign main_clk = clock_sink_clk;
	assign main_rst = reset_sink_reset;
	assign nios_clk_en = nios_lua_exec_slave_clk_en;
	assign nios_clk = nios_lua_exec_slave_clk;			// equivalent to main_clk since both are 50MHz, no phase shift
	assign nios_rst = nios_lua_exec_slave_reset;
	assign nios_start = nios_lua_exec_slave_start;
	assign L = nios_lua_exec_slave_dataa;
	assign ci = nios_lua_exec_slave_datab;
	assign reg_base = nios_lua_exec_slave_dataa;
	assign reg_val = nios_lua_exec_slave_datab;
	assign reg_type = nios_lua_exec_slave_datab;
	assign n = nios_lua_exec_slave_n;
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

	wire[31:0] instruction, PC;

	wire[31:0] mem_addr_ir, mem_wdata_ir;
	wire mem_r_ir, mem_w_ir;
	wire done_ir, fetch_instr_ir;

	wire[31:0] mem_addr_pc, mem_wdata_pc;
	wire mem_r_pc, mem_w_pc;
	wire done_pc, fetch_pc, store_pc, incr_pc, load_pc; 
	wire writedata_a_en_seq, writetype_a_en_seq;
	wire[1:0] write_a_source_seq;
	wire write_base;
	wire[31:0] load_data_pc;

	wire[5:0] opcode;
	wire[7:0] A;
	wire[8:0] B;
	wire[8:0] C;
	wire[17:0] Bx;
	wire signed[17:0] sBx;

	wire[31:0] data_a_rf, data_b_rf, data_c_rf;
	wire[`TTAG_SIZE-1:0] type_a_rf, type_b_rf, type_c_rf;
	wire dirty_a_rf, valid_a_rf;
	wire rst_dirty_rf, global_dirty_rf, rst_valid_rf;

	wire[31:0] base;

	wire run_instr;
	wire[31:0] writedata_a_instr;
	wire[`TTAG_SIZE-1:0] writetype_a_instr;
	wire writedata_a_en_instr, writetype_a_en_instr;
	wire[1:0] instr_status;

	wire[31:0] mem_addr_regdump;
	wire[31:0] mem_wdata_regdump;
	wire mem_w_regdump;

	wire[`REG_ADDR_BITS-1:0] reg_idx_regdumper;
	wire done_regdump;
	wire start_regdump;
	

	reg[31:0] reg_idx_inject;
	assign reg_idx_inject = (reg_base - base) >> 3; // shift by log2(sizeof(TValue))
	reg[`REG_ADDR_BITS-1:0] reg_idx_a;
	always @* begin
		case(write_a_source_seq)
			`A_SOURCE_INSTR: reg_idx_a = A[`REG_ADDR_BITS-1:0];
			`A_SOURCE_REGDUMPER: reg_idx_a = reg_idx_regdumper;
			`A_SOURCE_EXTERNAL: reg_idx_a = reg_idx_inject[`REG_ADDR_BITS-1:0];
			default: reg_idx_a = A[`REG_ADDR_BITS-1:0];
		endcase
	end

	instruction_register instr_reg(
		.mem_address(mem_addr_ir),
		.mem_readdata(mem_rdata),
		.mem_writedata(mem_wdata_ir),
		.mem_read(mem_r_ir),
		.mem_write(mem_w_ir),
		.mem_waitrequest(mem_wait),

		.instruction(instruction),
		.PC(PC),

		.done(done_ir),
		.fetch_instr(fetch_instr_ir),
		.clk(main_clk),
		.rst(main_rst)
	);
	program_counter prog_count(
		.mem_address(mem_addr_pc),
		.mem_readdata(mem_rdata),
		.mem_writedata(mem_wdata_pc),
		.mem_read(mem_r_pc),
		.mem_write(mem_w_pc),
		.mem_waitrequest(mem_wait),

		.PC(PC),

		.done(done_pc),
		.ci(ci),
		.load_data(load_data_pc),
		.fetch_pc(fetch_pc),
		.store_pc(store_pc),
		.incr_pc(incr_pc),
		.load_pc(load_pc),

		.clk(main_clk),
		.rst(main_rst)
	);
	decoder dec(
		.opcode(opcode),
		.A(A),
		.B(B),
		.C(C),
		.Bx(Bx),
		.sBx(sBx),
		.instruction(instruction)
	);
	main_sequencer seq(
		.fetch_pc(fetch_pc),
		.store_pc(store_pc),
		.incr_pc(incr_pc),
		.load_pc(load_pc),
		.fetch_instr(fetch_instr_ir),
		.writedata_a_en(writedata_a_en_seq),
		.writetype_a_en(writetype_a_en_seq),
		.write_a_source(write_a_source_seq),
		.write_base(write_base),
		.run_instr(run_instr),
		.store_regs(start_regdump),
		.dirty_clear_rf(rst_dirty_rf),
		.valid_clear_rf(rst_valid_rf),

		.done_cpu(nios_done),
		
		.global_dirty_rf(global_dirty_rf),
		.done_regdump(done_regdump),
		.done_pc(done_pc),
		.done_ir(done_ir),
		.instr_status(instr_status),
		.nios_start(nios_start),
		.nios_n(n),
		.clk_en(nios_clk_en),
		.clk(main_clk),
		.rst(main_rst)
	);
	instr_sequencer instr_seq(
		.start(run_instr),
		.opcode(opcode),
		.data_a(data_a_rf),
		.data_b(data_b_rf),
		.data_c(data_c_rf),
		.tt_a(type_a_rf),
		.tt_b(type_b_rf),
		.tt_c(type_c_rf),

		.Bx(Bx),
		.sBx(sBx),

		.writedata_a(writedata_a_instr),
		.writetype_a(writetype_a_instr),
		.writedata_a_en(writedata_a_en_instr),
		.writetype_a_en(writetype_a_en_instr),
		.instr_status(instr_status),
		.clk(main_clk),
		.rst(main_rst)
	);
	register_file rf(
		.idx_a(reg_idx_a),
		.idx_b(B[`REG_ADDR_BITS-1:0]),
		.idx_c(C[`REG_ADDR_BITS-1:0]),
		.writedata_a(write_a_source_seq == `A_SOURCE_EXTERNAL ? reg_val : writedata_a_instr),
		.writetype_a(write_a_source_seq == `A_SOURCE_EXTERNAL ? reg_type[`TTAG_SIZE-1:0] : writetype_a_instr),
		.write_src(write_a_source_seq),
		.data_a(data_a_rf),
		.data_b(data_b_rf),
		.data_c(data_c_rf),
		.type_a(type_a_rf),
		.type_b(type_b_rf),
		.type_c(type_c_rf),
		.dirty_a(dirty_a_rf),
		.valid_a(valid_a_rf),
		.writedata_a_en(write_a_source_seq == `A_SOURCE_EXTERNAL ? writedata_a_en_seq && reg_idx_inject < `REG_COUNT : writedata_a_en_seq || writedata_a_en_instr),
		.writetype_a_en(write_a_source_seq == `A_SOURCE_EXTERNAL ? writetype_a_en_seq && reg_idx_inject < `REG_COUNT : writetype_a_en_seq || writetype_a_en_instr),
		.rst_dirty(rst_dirty_rf),
		.rst_valid(rst_valid_rf),
		.global_dirty(global_dirty_rf),
		.clk(main_clk),
		.rst(main_rst)
	);
	base_register basereg(
		.write(write_base),
		.writedata(reg_base),
		.base(base),
		.clk(main_clk),
		.rst(main_rst)
	);
	register_dumper regdumper(
		.mem_address(mem_addr_regdump),
		.mem_writedata(mem_wdata_regdump),
		.mem_write(mem_w_regdump),
		.mem_waitrequest(mem_wait),

		.reg_idx(reg_idx_regdumper),
		.reg_data(data_a_rf),
		.reg_type(type_a_rf),
		.reg_dirty(dirty_a_rf),
		.reg_valid(valid_a_rf),
		.done(done_regdump),
		.base(base),
		.start(start_regdump),
		.clk(main_clk),
		.rst(main_rst)
	);

	always @* begin
		mem_addr = mem_addr_ir | mem_addr_pc | mem_addr_regdump;
		mem_wdata = mem_wdata_ir | mem_wdata_pc | mem_wdata_regdump;
		mem_r = |{mem_r_ir, mem_r_pc};
		mem_w = |{mem_w_ir, mem_w_pc, mem_w_regdump};
		nios_result = instruction;
	end
	
endmodule
