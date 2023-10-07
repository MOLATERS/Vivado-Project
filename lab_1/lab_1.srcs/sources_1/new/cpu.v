`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 20:11:19
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


module cpu(
    input           clk,           // clock, 100MHz
    input           resetn,        // active low

    // debug signals
    output [31:0]   debug_wb_pc,    // 当前正在执行指令的 PC
    output          debug_wb_rf_wen, // 当前通用寄存器组的写使能信号
    output [4:0]    debug_wb_rf_addr,// 当前通用寄存器组写回的寄存器编号
    output [31:0]   debug_wb_rf_wdata // 当前指令需要写回的数据
    );

    
wire [31:0] npc; // chosen npc
wire [31:0] pc; // chosen pc (same as npc)
wire [31:0] if_pc4; // answer for pc add 4
wire [31:0] if_inst; // taken instruction
wire [31:0] id_pc4; // same as if_pc4
wire [31:0] id_inst; // same as if_inst

    PC mypc(
        .clk(clk),
        .NPC(npc),
        .resetn(resetn),
        .PC(pc)
    );

    add4 myadd4(
        .data(pc),
        .result(if_pc4)
    );

    IMEM myInstRom(
        .clk(clk),
        .imem_addr(pc),
        .imem_rdata(if_inst)
    );


    IF_ID myIF_ID(
        .clk(clk),
        .IF_ir(if_inst),
        .IF_npc(if_pc4),
        .ID_npc(id_pc4),
        .ID_ir(id_inst)
    );

wire [5:0] op; // oparation for instruction
wire [5:0] func; // function for instruction
wire [4:0] id_rs; // as the addr of A
wire [4:0] id_rt; // as the addr of B or detination
wire [4:0] id_rd; // as the addr of destination
wire [4:0] id_base; // as the base addr
wire [15:0] id_offset; // as the offset of load and store function
wire [4:0] sa; // as the number (imm) for the SLL
wire [25:0] id_index; // as the jump pcsourse


    Decoder mydecoder(
        .IR(if_inst),
        .op(id_op),
        .func(id_func),
        .rs(id_rs),
        .rd(id_rd),
        .rt(id_rt),
        .base(id_base),
        .offset(id_offset),
        .sa(id_sa),
        .instr_index(id_index)
    );

wire ex_zero ; // get the Zero flag in ALU
wire id_wmem ; // write memery access
wire id_wreg ; // write regfile access
wire [4:0] id_aluc ; // alu function choice
wire [1:0] pcsourse ; // pc choice
wire [1:0] id_m2reg; // write back data choice
wire [1:0] id_regaddr; // write back reg address choice
wire [2:0] id_asourse; // A data choice
wire [2:0] id_bsourse; // B data choice


    CU myCU(
        .func(id_func),
        .op(id_op),
        .zero(ex_zero),
        .wmem(id_wmem),
        .wreg(id_wreg),
        .aluc(id_aluc),
        .PCsourse(pcsourse),
        .m2reg(id_m2reg),
        .regaddr(id_regaddr),
        .asourse(id_asourse),
        .bsourse(id_bsourse)
    );


    Extender myextender(
        .Immin(id_offset),
        .Immout(id_imm)
    );
    
    adder tobpc(
        .data1(id_imm),
        .data2(id_pc4),
        .result(bpc)
    );

wire [4:0]  id_rn; // the addr of chosen reg
wire [31:0] id_ra; //代表的是读出的A寄存器中的值
wire [31:0] id_rb; //代表的是读出的B寄存器中的值
wire [4:0]  wb_rn; //代表写回的时候使用的地址
wire [31:0] wb_data; //代表写回的时候使用的数据
wire wb_wreg; //代表是否能够写回Regfile的使能

    Regfile myregfile(
        .clk(clk),
        .raddr1(id_rs),
        .rdata1(id_ra),
        .raddr2(id_rt),
        .rdata2(id_rb),
        .we(wb_wreg),
        .waddr(wb_rn),
        .wdata(wb_data)
    ); 

wire ex_wmem ; // write memery access
wire ex_wreg ; // write regfile access
wire [4:0] ex_aluc ; // alu function choice
wire [1:0] ex_m2reg; // write back data choice
wire [2:0] ex_asourse; // A data choice
wire [2:0] ex_bsourse; // B data choice
wire [4:0]  ex_rn; // the addr of chosen reg
wire [31:0] ex_ra; //代表的是读出的A寄存器中的值
wire [31:0] ex_rb; //代表的是读出的B寄存器中的值
wire [31:0] ex_inst; // 代表的是指令instruction

    ID_EX myID_EX(
      .clk(clk),

    //接收CU的输入
        .wmem(id_wmem),
        .wreg(id_wreg),
        .aluc(id_aluc),
        .w2reg(id_m2reg),
        .asourse(id_asourse),
        .bsourse(id_bsourse),

    //CU的数值传递
        .outwmem(ex_wmem),
        .outwreg(ex_wreg),
        .outaluc(ex_aluc),
        .outm2reg(ex_m2reg),
        .outasourse(ex_asourse),
        .outbsourse(ex_bsourse),

    //交给ALU的参数
        .ID_ra(id_ra),
        .ID_rb(id_rb),
        .ID_Imm(id_imm),
        .EX_ra(ex_ra),
        .EX_rb(ex_rb),
        .EX_Imm(ex_imm),

    //传递的可写地址
        .ID_rn(id_rn),
        .EX_rn(ex_rn),
    
    //IR
        .ID_inst(id_inst),
        .EX_inst(ex_inst)
    );



// all kinds of mux    

    mux_221 RegAddr(
        .data1(id_rt),
        .data2(id_rd),
        .result(id_rn),
        .index(regaddr)
    );

    mux_421 PCmux(
        .data1(if_pc4),
        .data2(bpc),
        .data3({id_pc4[31:28],id_index << 2}), //代表jpc
        .data4(0),
        .index(pcsourse),
        .result(npc)
    );




endmodule
