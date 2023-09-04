`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/30 18:02:28
// Design Name: 
// Module Name: CPU
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
//////////////////////////////////////////////////////////////////////////////////


module CPU(
    input            clk             ,  // clock, 100MHz
    input            resetn          ,  // active low

    // debug signals
    output reg [31:0]    debug_wb_pc     ,  // ��ǰ����ִ��ָ���PC
    output  reg        debug_wb_rf_wen ,  // ��ǰͨ�üĴ������дʹ���ź�
    output  reg [4 :0]    debug_wb_rf_addr,  // ��ǰͨ�üĴ�����д�صļĴ������
    output  reg [31:0]    debug_wb_rf_wdata  // ��ǰָ����Ҫд�ص�����
    );

wire [31:0] pc_out, pc_add_out, i_ram_out, ir_out, npc_out;
wire [31:0] reg_out_1,reg_out_2;
wire [31:0] reg_A_out,reg_B_out, mux_A_out, mux_B_out, alu_out, reg_out, reg_addr_out;
wire [31:0] wide, imm_out;
wire [31:0] ldm_in, ldm_out,pc_mux_out, reg_mux_out;
wire ram_wen, reg_wen, cout, zero;
wire [4:0] ALU_Op;
wire [1:0] PC_sel,PC_mode, regfile_sel, ALU_A_sel, ALU_B_sel, regfile_addr_sel;
wire [4:0] T;

reg [31:0] now_PC;// ��ǰ����ִ��ָ���PC



always @ (posedge T[4]) begin
       debug_wb_pc <= pc_out;
end

always @ (posedge T[0]) begin
       debug_wb_rf_wen <= reg_wen && ir_out;
       debug_wb_rf_addr <= reg_addr_out[5:0];
       debug_wb_rf_wdata <= reg_mux_out;
end

signal signal(//�źŷ�����
.clk(clk),
.rst(resetn),
.T(T)
);

sym_16_to_32 sym(//����λ��չ
.in_num(ir_out[15:0]),
.out_num(wide)
);

ALU ALU(//������
.A(mux_A_out),
.B(mux_B_out),
.Cin(1'b0),
.Card(ALU_Op),
.F(alu_out),
.Cout(cout),
.Zero(zero)
);

ALU_reg A_reg(//A�Ĵ���
.clk(T[3]),
.in_num(reg_out_1),
.out_num(reg_A_out)
);

ALU_reg B_reg(//B�Ĵ���
.clk(T[3]),
.in_num(reg_out_2),
.out_num(reg_B_out)
);

ALU_reg Imm_reg(//�������Ĵ���
.clk(T[3]),
.in_num(wide),
.out_num(imm_out)
);

ALU_reg out_reg(//ALU�������Ĵ���
.clk(T[2]),
.in_num(alu_out),
.out_num(reg_out)
);

CU CU(//���������
.Func(ir_out[31:26]),
.Op(ir_out[5:0]),
.Zero(zero),

.ram_w(ram_wen),
.reg_w(reg_wen),
.ALU_Op(ALU_Op),
.PC_s(PC_mode),
.regfile_s(regfile_sel),
.regfile_addr_s(regfile_addr_sel),
.ALU_A_s(ALU_A_sel),
.ALU_B_s(ALU_B_sel)
);

IR IR(
.reset(resetn),
.in_ins(i_ram_out),
.out_ins(ir_out)
);

LDM LDM(//�洢�����ݻ���Ĵ���
.in_data(ldm_in),
.out_data(ldm_out)
);

MUX_4_to_1 ALU_A(//ALU������Aѡ����
.data_0(reg_A_out),//�Ĵ���A
.data_1(npc_out),//NPC�����
.data_2({27'b0,ir_out[25:21]}),//ָ���е�base��
.data_3({27'b0,ir_out[10:6]}),//ָ���е�sa��

.select(ALU_A_sel),
.data(mux_A_out)
);

MUX_4_to_1 ALU_B(//ALU������Bѡ����
.data_0(reg_B_out),//�Ĵ���B
.data_1(imm_out),//�������Ĵ���
.data_2(32'b10),//�̶�����2
.data_3(32'b0),

.select(ALU_B_sel),
.data(mux_B_out)
);

MUX_4_to_1 PC_s(//PC����ѡ����
.data_0(npc_out),//NPC����
.data_1(reg_out),//������ת
.data_2({npc_out[31:28],ir_out[25:0],2'b0}),//��������ת
.data_3(32'b0),

.select(PC_sel),
.data(pc_mux_out)
);

MUX_4_to_1 reg_s(//�Ĵ���������ѡ����
.data_0(reg_out),
.data_1(ldm_out),
.data_2(reg_A_out),//�Ĵ���A
.data_3(32'b0),

.select(regfile_sel),
.data(reg_mux_out)
);

MUX_4_to_1 reg_addr_s(//�Ĵ�����ַѡ����
.data_0({27'b0,ir_out[15:11]}),//��Դ��ָ��15-11λ�����ڼ����Ĵ���
.data_1({27'b0,ir_out[20:16]}),//��Դ��ָ��20-16λ�����ڴӴ洢��ȡ��
.data_2(32'b0),
.data_3(32'b0),

.select(regfile_addr_sel),
.data(reg_addr_out)
);

NPC NPC(//Ĭ��PC+4�ļĴ���
.in_address(pc_add_out),
.out_address(npc_out)
);

PC PC(//���������
.clk(T[1]),
.reset(resetn),
.in_address(pc_mux_out),
.out_address(pc_out)
);

PC_Add PC_Add(//����������Լӷ���
.in_address(pc_out),
.out_address(pc_add_out)
);

PC_Cond PC_Cond(//PC������ѡ�������
 .in_A(reg_A_out),
 .in_B(reg_B_out),
 .mode(PC_mode),
 .choose(PC_sel)
);

regfile regfile(//�Ĵ�����
    .clk(T[0]),
    .raddr1(ir_out[25:21]),
    .raddr2(ir_out[20:16]),
    .we(reg_wen && ir_out),//����NOPָ���д�Ĵ���
    .waddr(reg_addr_out[4:0]),
    .wdata(reg_mux_out),
    .rdata1(reg_out_1),
    .rdata2(reg_out_2)
);

i_ram i_ram(
.clk(clk),
.ram_addr(pc_out[7:0]),
.ram_rdata(i_ram_out)
);

d_ram d_ram(
.clk(T[1]),
.ram_wen(ram_wen),
.ram_addr(reg_out[7:0]),
.ram_wdata(reg_B_out),
.ram_rdata(ldm_in)
);

endmodule
