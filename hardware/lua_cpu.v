`timescale 1 ps / 1 ps

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
		B = instruction[22:14];
		C = instruction[31:23];
		Bx = instruction[31:14];
		sBx = $signed(Bx);
	end
endmodule

// module register_file(
// 	output reg[31:0] mem_address,
// 	input wire[31:0] mem_readdata,
// 	output reg[31:0] mem_writedata,
// 	output reg mem_read,
// 	output reg mem_write,
// 	input wire mem_waitrequest,

// 	input reg[4:0] idx_a,
// 	input reg[4:0] idx_b,
// 	input reg[4:0] idx_c,
// 	input reg[32:0] writedata_a,
// 	input reg[TTAG_SIZE-1:0] writetype_a,
// 	output reg[31:0] data_a,
// 	output reg[31:0] data_b,
// 	output reg[31:0] data_c,
// 	output reg[TTAG_SIZE-1:0] type_a,
// 	output reg[TTAG_SIZE-1:0] type_b,
// 	output reg[TTAG_SIZE-1:0] type_c,
// 	input reg write_a
// );
// 	localparam TTAG_SIZE = 3;

// 	localparam T_NIL = 0;
// 	localparam T_INTEGER = 1;
// 	localparam T_NUMBER = 2;
// 	localparam T_STRING = 3;
// 	localparam T_TABLE = 4;
// 	localparam T_FUNCTION = 5;
// 	localparam T_OTHER = 6;

// 	reg[31:0] regs[31:0];
// 	reg[TTAG_SIZE-1:0] ttags[31:0];
// 	reg valid[31:0];
// 	integer i;

// 	always @(posedge clk or posedge clk) begin
// 		if (rst) begin
// 			for (i = 0; i < 32; i = i + 1) begin
// 				regs[i] <= 32'd0;
// 				ttags[i] <= T_NIL;
// 				valid[i] <= 1'd0;
// 			end
// 		end else if (write_a) begin
// 			regs[idx_a] <= writedata_a;
// 			ttags[idx_a] <= writetype_a;
// 			valid[i] <= 1'd1;
// 		end
// 	end

// 	always @* begin
// 		data_a = write_a ? writedata_a : regs[idx_a];
// 		data_b = regs[idx_b];
// 		data_c = regs[idx_c];
// 		type_a = write_a ? writetype_a : ttags[idx_a];
// 		type_b = ttags[idx_b];
// 		type_c = ttags[idx_c];
// 	end
// endmodule

module sequencer(
	output reg fetch_pc,
	output reg store_pc,
	output reg incr_pc,
	output reg load_pc,
	output reg fetch_instr,
	output reg done_cpu,
	
	input wire done_pc,
	input wire done_ir,
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
	localparam EX_FETCH_REGS = 4'd4;
	localparam EX_FINISH = 4'd15;

	// supported opcodes
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

	reg[3:0] ex_state;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			ex_state <= EX_START;
		end else if (clk_en) begin
			case(ex_state)
				EX_START: begin
					if (nios_start)
						if (nios_n == 2'd0)
							ex_state <= EX_FETCH_PC;
						else
							ex_state <= EX_FINISH;
				end
				EX_FETCH_PC: begin
					if (done_pc)
						ex_state <= EX_FETCH_INSTR;
				end
				EX_STORE_PC: begin
					if (done_pc)
						ex_state <= EX_FINISH;
				end
				EX_FETCH_INSTR: begin
					if (done_ir)
						ex_state <= EX_STORE_PC;
						//ex_state <= EX_FETCH_REGS;
				end
				EX_FETCH_REGS: begin

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
		done_cpu = 1'd0;
		case(ex_state)
			EX_START: begin end
			EX_FETCH_PC: begin
				fetch_pc = 1'd1;
			end
			EX_STORE_PC: begin
				store_pc = 1'd1;
			end
			EX_FETCH_INSTR: begin
				fetch_instr = 1'd1;
				if (done_ir)
					incr_pc = 1'd1;
			end
			EX_FETCH_REGS: begin
				
			end
			EX_FINISH: begin
				done_cpu = 1'd1;
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
	wire[31:0] L, ci;
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
	wire[31:0] load_data_pc;

	wire[5:0] opcode;
	wire[7:0] A;
	wire[8:0] B;
	wire[8:0] C;
	wire[17:0] Bx;
	wire signed[17:0] sBx;

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
	sequencer seq(
		.fetch_pc(fetch_pc),
		.store_pc(store_pc),
		.incr_pc(incr_pc),
		.load_pc(load_pc),
		.fetch_instr(fetch_instr_ir),
		.done_cpu(nios_done),
		
		.done_pc(done_pc),
		.done_ir(done_ir),
		.nios_start(nios_start),
		.nios_n(n),
		.clk_en(nios_clk_en),
		.clk(main_clk),
		.rst(main_rst)
	);

	always @* begin
		mem_addr = mem_addr_ir | mem_addr_pc;
		mem_wdata = mem_wdata_ir | mem_wdata_pc;
		mem_r = |{mem_r_ir, mem_r_pc};
		mem_w = |{mem_w_ir, mem_w_pc};
		nios_result = instruction;
	end
	
endmodule
