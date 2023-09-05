`timescale 1ns / 1ps

module cpu (
    input           clk,           // clock, 100MHz
    input           resetn,        // active low

    // debug signals
    output [31:0]   debug_wb_pc,    // 当前正在执行指令的 PC
    output          debug_wb_rf_wen, // 当前通用寄存器组的写使能信号
    output [4:0]    debug_wb_rf_addr,// 当前通用寄存器组写回的寄存器编号
    output [31:0]   debug_wb_rf_wdata // 当前指令需要写回的数据
);

wire [31:0] PCout;     // 表示 PC 寄存器内的指令地址
wire [31:0] NewPC;     // 表示增加之后的指令地址
wire [31:0] NPC;       // 存储在 NPC 内的已经增加了的指令地址
wire [31:0] IRin;      // 输入指令寄存器的值，也就是从指令存储器里面读出来的当前需要执行的指令
wire [31:0] IRout;     // 指令寄存器输出
wire [31:0] PC_chosen; // 最后选择的PC地址
wire [31:0] reg_a_out; // 寄存器读出来的 A 数据
wire [31:0] reg_b_out; // 寄存器读出来的 B 数据
wire reg_w;            // 寄存器写使能
wire ram_w;            // 存储器写使能
wire [4:0] Card;       // ALU 功能码
wire [1:0] PC_s;       // PC 数据来源选择
wire [1:0] regfile_s;  // 寄存器文件数据来源选择
wire [1:0] regfile_addr_s;   // 寄存器文件地址来源选择
wire [1:0] A_s;        // ALU 输入 A 来源选择
wire [1:0] B_s;        // ALU 输入 B 来源选择
wire zero;             // 0 位
wire [31:0] A_out;     // 作为 A 的数据输出
wire [31:0] B_out;     // 作为 B 的数据输出
wire [31:0] Imm;       // 作为Imm的数据输出
wire [31:0] Imm_out;   // 作为 Imm 的数据输出
wire [31:0] ALU_A_in;  // 数据 A 的输入
wire [31:0] ALU_B_in;  // 数据 B 的输入
wire [31:0] alu_out;   // 记录数据的输出
wire cout;             // 进位
wire [31:0] result;    // 记录在缓冲器内的数据
wire [31:0] reg_mux_out;     // 选择后的寄存器位置输出
wire [31:0] reg_addr_choose; // 选择的寄存器地址
wire [31:0] ldm_in;          // mdl 寄存器输入
wire [31:0] ldm_out;         // mdl 寄存器输出

assign debug_wb_pc = PCout;
assign debug_wb_rf_wen = reg_w && IRout;
assign debug_wb_rf_addr = reg_addr_choose[5:0];
assign debug_wb_rf_wdata = reg_mux_out;

/* IF 模块部分 */
IMEM U_IMEM (
    .clk(clk),                // 时钟信号
    .imem_addr(PCout[7:0]),   // 选定存储地址
    .imem_rdata(IRin)         // 读出的指令
);

PC U_PC (
    .Reset(!resetn),
    .Clk(clk),
    .PCwen(1'b1),
    .NPC(PC_chosen),          // 是由选择器给出的
    .PC(PCout)
);

ADD U_ADD (
    .PC(PCout),
    .NextPC(NewPC)
);

NPC U_NPC (
    .clk(clk),                 // 时钟输入
    .rst(!resetn),             // 复位输入
    .NPCin(NewPC),
    .load(1'b1),               // 载入使能
    .NPCout(NPC)
);

IR U_IR (
    .clk(clk),                 // 时钟输入
    .rst(!resetn),             // 复位输入
    .IRin(IRin),
    .load(1'b1),               // 载入使能
    .IRout(IRout)
);
/* IF 模块部分 */

/* ID 模块部分 */
Regfile U_regfile (
    .clk(clk),                // 时钟信号
    .raddr1(IRout[25:21]),    // 寄存器堆读地址1
    .rdata1(reg_a_out),       // 返回数据1
    .raddr2(IRout[20:16]),    // 寄存器堆读地址2
    .rdata2(reg_b_out),       // 返回数据2
    .we(reg_w && IRout),      // 写使能
    .waddr(reg_addr_choose[4:0]), // 写地址
    .wdata(reg_mux_out)       // 写数据
);

CU U_CU (
    .Instruct(IRout),          // 输入指令
    .Zero(zero),               // 零标志位
    .ram_w(ram_w),             // 存储器写使能
    .reg_w(reg_w),             // 寄存器写使能
    .Card(Card),               // ALU 功能码
    .PC_s(PC_s),               // PC 数据来源选择
    .regfile_s(regfile_s),     // 寄存器文件数据来源选择
    .regfile_addr_s(regfile_addr_s), // 寄存器文件地址来源选择
    .ALU_As(A_s),              // ALU 输入 A 来源选择
    .ALU_Bs(B_s)               // ALU 输入 B 来源选择
);

A U_A (
    .clk(clk),                  // 时钟输入
    .rst(!resetn),              // 复位输入
    .din(reg_a_out),            // 数据输入
    .load(1'b1),                // 载入控制输入
    .dout(A_out)                // 数据输出
);

B U_B (
    .clk(clk),                  // 时钟输入
    .rst(!resetn),              // 复位输入
    .din(reg_b_out),            // 数据输入
    .load(1'b1),                // 载入控制输入
    .dout(B_out)                // 数据输出
);

Extender U_Extender (
    .Immin(IRout[15:0]),
    .Immout(Imm)
);

Imm U_Imm (
    .clk(clk),                  // 时钟输入
    .rst(!resetn),              // 复位输入
    .din(Imm),                  // 数据输入
    .load(1'b1),                // 载入控制输入
    .dout(Imm_out)              // 数据输出
);
/* ID 模块部分 */

/* EX 模块部分 */
A_MUX A_MUX (
    .A_data1(A_out),                  //A寄存器的输出
    .A_data2(NPC),                    //根据现在的PC产生的NPC值
    .A_data3(A_out),                  //代表base的值
    .A_data4({27'b0,IRout[10:6]}),    //代表左移的偏置量sa
    .A_select(A_s),
    .A_data_chosen(ALU_A_in)
);

B_MUX B_MUX (
    .B_data1(B_out),              //B寄存器的输出
    .B_data2(Imm_out),            //立即数扩展符号位之后的输出
    .B_data3(32'b0),
    .B_data4(32'b0),
    .B_select(B_s),
    .B_data_chosen(ALU_B_in)
);

ALU U_ALU (
    .A(ALU_A_in),
    .B(ALU_B_in),
    .Cin(1'b0),
    .Card(Card),
    .F(alu_out),
    .Cout(cout),
    .Zero(zero)
);
/* EX 模块部分 */

/* MEM 部分 */
ALU_out U_ALU_output (
    .clk(clk),                  // 时钟输入
    .rst(!resetn),              // 复位输入
    .din(alu_out),              // 数据输入
    .load(1'b1),                // 载入控制输入
    .dout(result)               // 数据输出
);

PC_MUX PC_MUX (
    .data1(NPC),
    .data2(result),
    .data3({NPC[31:28],IRout[25:0],2'b0}),
    .data4(32'b0),
    .select(PC_s),
    .data_chosen(PC_chosen)
);

WB_DATA_MUX WB_Reg_MUX (
    .data1(result),
    .data2(ldm_out),
    .data3(A_out),
    .data4(32'b0),
    .select(regfile_s),
    .data_chosen(reg_mux_out)
);

WB_ADDR_MUX WB_Reg_Addr_MUX (
    .data1({27'b0,IRout[15:11]}),
    .data2({27'b0,IRout[20:16]}),
    .data3(32'b0),
    .data4(32'b0),
    .select(regfile_addr_s),
    .data_chosen(reg_addr_choose)
);

DMEM U_DMEM (
    .clk(clk),                  // 时钟信号
    .dmem_addr(result[7:0]),    // 选定存储地址
    .dmem_wdata(reg_b_out),     // 输入的数据
    .dmem_wen(ram_w),           // 写使能
    .dmem_rdata(ldm_in)         // 读出的数据
);

LDM LDM (
    .clk(clk),                  // 时钟输入
    .rst(!resetn),              // 复位输入
    .din(ldm_in),               // 数据输入
    .load(1'b1),                // 载入控制输入
    .dout(ldm_out)              // 数据输出
);
/* MEM 部分 */

/* mTODO: 完成非流水 CPU 的设计代码 */

endmodule
