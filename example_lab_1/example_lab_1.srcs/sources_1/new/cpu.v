`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 21:31:58
// Design Name: 
// Module Name: cpu
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


module cpu (
    input           clk,          
    input           resetn,        // active low
    // debug signals
    output [31:0]   debug_wb_pc,    
    output          debug_wb_rf_wen, 
    output [4:0]    debug_wb_rf_addr,
    output [31:0]   debug_wb_rf_wdata 
   
);



wire [31:0] PC_out;  
wire [31:0] next_PC;     
wire [31:0] NPC; 
wire [31:0]ir_in;
wire [31:0] NPC_id;
wire [31:0] ir_id;
wire [31:0] Ime_in;
wire [31:0] rdata1,rdata2;
wire [31:0] NPC_ex;
wire [31:0] A;
wire [31:0] B;
wire [31:0] Ime_out;
wire [4:0] card;
wire [2:0] A_sel;        
wire [2:0] B_sel; 
wire [31:0] ir_ex;
wire [31:0] ALU_A;
wire [31:0] ALU_B;
wire [31:0] ALU_out;
wire [31:0] ir_mem;
wire [31:0] ALU_res;
wire [31:0] store_num;
wire [31:0] ldm_in;
wire [31:0] ldm_out;
wire [31:0] ALU_end;
wire ram_w,reg_w;
wire wdata_sel;
wire [31:0] waddr; 
wire [31:0] wdata;
wire [31:0] pc_id;
wire [31:0] pc_ex;
wire [31:0] pc_mem;
wire [31:0] pc_end;
wire [31:0] ir_cu;
wire [31:0] ir_wb;
wire stop;
wire [31:0] BB;
wire [1:0] chooser;
wire [31:0] wb_B;
assign debug_wb_pc = pc_end;
assign debug_wb_rf_wen = reg_w ;
assign debug_wb_rf_addr = waddr[31:0];
assign debug_wb_rf_wdata = wdata;
super_CU sucu(
    .if_id_ir(ir_id),
    .id_ex_ir(ir_ex),
    .ex_mem_ir(ir_mem),
    .mem_wb_ir(ir_wb),
    .A_sel(A_sel),
    .B_sel(B_sel),
    .stop(stop),
    .ir(ir_cu),
    .B_chooser(chooser),
    .ex_mem_B(store_num),
    .mem_wb_B(wb_B)
);
PC pc (
    .stop(stop),
    .reset(resetn),
    .clk(clk),
    .pc_we(1'b1),
    .NPC(NPC),          
    .PC(PC_out)
);
adder pc_adder (
    .PC(PC_out),
    .NextPC(next_PC)
);
pc_adder_res npc (               
    .rst(resetn),               
    .NPC_in(next_PC),              
    .NPC_out(NPC)
);
ir_ROM ir_rom (               
    .ir_rom_addr(PC_out[7:0]),  
    .ir_rom_rdata(ir_in)        
);
IF_ID if_id(
    .stop(stop),
    .clk(clk),
    .NPC_in(NPC),
    .PC(PC_out),
    .CPC(pc_id),
    .IR(ir_in),
    .reset(resetn),
    .NPC(NPC_id),
    .ir(ir_id)
);

regfiles regfile_pile (
    .clk(clk),              
    .raddr1(ir_id[25:21]), 
    .raddr2(ir_id[20:16]), 
    .rdata1(rdata1),     
    .rdata2(rdata2),       
    .we(reg_w),   
    .waddr(waddr), 
    .wdata(wdata)      
);
Extender extender (.Ime_in(ir_id[15:0]),.Ime_out(Ime_in));
ID_EX id_ex(
    .clk(clk),
    .NPC_in(NPC_id),
    .reset(resetn),
    .rdata1(rdata1),
    .rdata2(rdata2),
    .immer_in(Ime_in),
    .ir_in(ir_cu),
    .NPC(NPC_ex),
    .PC(pc_id),
    .CPC(pc_ex),
    .A(A),
    .B(B),
    .IMM(Ime_out),
    .IR(ir_ex),
    .Card(card)
);
data_selecter_8_to_1 A_seler(
    .data1(A),
    .data2(NPC_ex),
    .data3({27'b0,ir_ex[10:6]}),
    .data4(ALU_res),//ex_memµÄALu½á¹û
    .data5(wdata),
    .data6(ldm_in),
    .data7(32'b0),
    .data8(32'b0),
    .select(A_sel),
    .data_chosen(ALU_A)
);
data_selecter_8_to_1 B_seler(
    .data1(B),
    .data2(Ime_out),
    .data3(ir_ex),
    .data4(ALU_res),
    .data5(wdata),
    .data6(ldm_in),
    .data7(32'b0),
    .data8(32'b0),
    .select(B_sel),
    .data_chosen(ALU_B)
);
ALU alu(
    .a(ALU_A),
    .b(ALU_B),
    .cin(1'b0),
    .card(card),
    .F(ALU_out),
    .cout(),
    .zero()
);
data_selecter_4_to_1 Ber_chooser(
.data1(B),
.data2(ALU_res),
.data3(wdata),
.data4(32'b0),
.select(chooser),
.data_chosen(BB)
);
EX_MEM ex_mem(
    .clk(clk),
    .ALU_out(ALU_out),
    .reset(resetn),
    .ir_in(ir_ex),
    .B(BB),
    .PC(pc_ex),
    .CPC(pc_mem),
    .IR(ir_mem),
    .ram_w(ram_w),
    .ALU_res(ALU_res),
    .store_num(store_num)
);
data_ram data_RAM(
    .clk(clk),
    .data_ram_addr(ALU_res),
    .data_ram_wdata(store_num),
    .data_ram_wen(ram_w),
    .data_ram_rdata(ldm_in)
);
MEM_WB mem_wb(
    .clk(clk),
    .PC(pc_mem),
    .CPC(pc_end),
    .B(store_num),
    .LDM_IN(ldm_in),
    .reset(resetn),
    .ir_in(ir_mem),
    .ALU_out(ALU_res),
    .LDM_OUT(ldm_out),
    .ALU_res(ALU_end),
    .wdata_sel(wdata_sel),
    .reg_w(reg_w),
    .waddr(waddr),
    .IR(ir_wb),
    .wb_B(wb_B)
);
data_selecter_2_to_1 wdata_seler(
.data1(ALU_end),
.data2(ldm_out),
.select(wdata_sel),
.data_chosen(wdata)
);
endmodule