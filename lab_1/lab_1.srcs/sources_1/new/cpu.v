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

// 按照OP分类
`define Add 6'b100000
`define Sub 6'b100010
`define And 6'b100100
`define Or 6'b100101
`define Xor 6'b100110
`define Slt 6'b101010
`define Movz 6'b001010
`define Sll 6'b000000

//不同的Func
`define Cal 6'b000000
`define Sw 6'b101011
`define Lw 6'b100011
`define Bne 6'b000101
`define J 6'000010


module cpu(
    input           clk,           // clock, 100MHz
    input           resetn,        // active low

    // debug signals
    output [31:0]   debug_wb_pc,    // 当前正在执行指令的 PC
    output          debug_wb_rf_wen, // 当前通用寄存器组的写使能信号
    output [4:0]    debug_wb_rf_addr,// 当前通用寄存器组写回的寄存器编号
    output [31:0]   debug_wb_rf_wdata // 当前指令需要写回的数据
    );


    
wire [31:0] bpc; //作为跳转的内容
wire [31:0] npc; // chosen npc
wire [31:0] pc; // chosen pc (same as npc)
wire [1:0]  pcsourse ; // pc choice

wire [31:0] if_pc4; // answer for pc add 4
wire [31:0] if_inst; // taken instruction


wire [31:0] id_pc4; // same as if_pc4
wire [31:0] id_inst; // same as if_inst
wire [4:0]  id_rs; // as the addr of A
wire [4:0]  id_rt; // as the addr of B or detination
wire [4:0]  id_rd; // as the addr of destination
wire [15:0] id_offset; // as the offset of load and store function
wire [4:0]  id_base; // as the base addr
wire [25:0] id_index; // as the jump pcsourse
wire        id_wmem ; // write memery access
wire        id_wreg ; // write regfile access
wire [4:0]  id_aluc ; // alu function choice
wire [1:0]  id_m2reg; // write back data choice
wire [1:0]  id_regaddr; // write back reg address choice
wire [2:0]  id_asourse; // A data choice
wire [2:0]  id_bsourse; // B data choice
wire [4:0]  id_rn; // the addr of chosen reg
wire [31:0] id_ra; //代表的是读出的A寄存器中的值
wire [31:0] id_rb; //代表的是读出的B寄存器中的值
wire        id_equal; // 代表的是A和B是否相等
wire [5:0]  id_op; //作为CU的op输入
wire [5:0]  id_func; //作为CU的func输入
wire [4:0]  id_sa; //作为CU的sa输入
wire [31:0] id_imm; //作为立即数输入
wire [31:0] id_cpc;

wire        ex_zero ; // get the Zero flag in ALU
wire        ex_wmem ; // write memery access
wire        ex_wreg ; // write regfile access
wire [4:0]  ex_aluc ; // alu function choice
wire [1:0]  ex_m2reg; // write back data choice
wire [2:0]  ex_asourse; // A data choice
wire [2:0]  ex_bsourse; // B data choice
wire [4:0]  ex_rn; // the addr of chosen reg
wire [31:0] ex_ra; //代表的是读出的A寄存器中的值
wire [31:0] ex_rb; //代表的是读出的B寄存器中的值
wire [31:0] ex_inst; // 代表的是指令instruction
wire [31:0] ex_imm;
wire [31:0] ex_data1;
wire [31:0] ex_data2;
wire [31:0] ex_aluout;


wire        mem_wreg; // 传送的写寄存器使能
wire [1:0]  mem_m2reg; // 传送的写入数据选择
wire        mem_wmem; // 传送的写存储器使能
wire [31:0] mem_aluout; // 传送的是alu的计算结果
wire [4:0]  mem_rn; //传输的是写入寄存器的地址
wire [31:0] mem_inst;
wire [31:0] mem_bsourse; //传输的是在rt地址位置的数
wire [31:0] mem_memdata;
wire [31:0] mem_pc4;
wire [31:0] mem_bpc;
wire [1:0]  mem_pcsourse;
wire [31:0] mem_cpc;


wire [1:0]  wb_m2reg; // 传送的写入数据选择
wire [31:0] wb_aluout; // 传送的是alu的计算结果
wire [4:0]  wb_rn; //代表写回的时候使用的地址
wire [31:0] wb_data; //代表写回的时候使用的数据
wire        wb_wreg; //代表是否能够写回Regfile的使能
wire [31:0] wb_memdata;
wire [31:0] wb_pc4;
wire [31:0] wb_bpc;
wire [1:0]  wb_pcsourse;
wire [31:0] wb_inst;
wire [31:0] wb_cpc;
wire [31:0] ex_bpc;//传递跳转指令
wire [31:0] ex_pc4;//传递PC+4
wire [ 1:0] ex_pcsourse;
wire [31:0] ex_cpc;
wire id_zero;

wire [1:0] ex_rbsourse;
wire [2:0] ex_a_sel;
wire [2:0] ex_b_sel;

wire [31:0] id_chosen_inst;
wire [31:0] wb_bsourse;
wire [31:0] ex_chosen_rb;


assign debug_wb_pc = wb_cpc;
assign debug_wb_rf_wen = wb_wreg;
assign debug_wb_rf_addr = wb_rn;
assign debug_wb_rf_wdata = wb_data;


PC mypc(
    .stop(stop),
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
    .imem_addr(pc[7:0]),
    .imem_rdata(if_inst)
);

IF_ID myIF_ID(
    .cpc(pc),
    .outpc(id_cpc),
    .stop(stop),
    .clk(clk),
    .resetn(resetn),
    .IF_ir(if_inst),
    .IF_npc(if_pc4),
    .ID_npc(id_pc4),
    .ID_ir(id_inst)
);

Decoder mydecoder(
    .resetn(resetn),
    .IR(id_inst),
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

Cond mycond(
    .ra(id_ra),
    .rb(id_rb),
    .equal(id_equal)
);

// TODO 注意这里要修改一下判断条件，因为没有办法及时更新
Zero zero(
    .data(id_rb),
    .zero(id_zero)
);

Zero zero_change(
    .data(ex_chosen_rb),
    .zero(ex_zero)
);

CU myCU(
    .inst(id_inst),
    .resetn(resetn),
    .func(id_func),
    .op(id_op),
    .Zero(id_zero),
    .Equal(id_equal),
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

ID_EX myID_EX(
    .cpc(id_cpc),
    .outpc(ex_cpc),
    .clk(clk),
    .resetn(resetn),
    .pcsourse(pcsourse),
    .outpcsourse(ex_pcsourse),
    .npc(id_pc4),
    .bpc(bpc),
    .npcout(ex_pc4),
    .bpcout(ex_bpc),
//接收CU的输入
    .wmem(id_wmem),
    .wreg(id_wreg),
    .aluc(id_aluc),
    .m2reg(id_m2reg),
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
    .ID_inst(id_chosen_inst),
    .EX_inst(ex_inst)
);

// A 和 B 的选择器

// TODO 记得要再试试加上stop来管理每一个暂停

// TODO 这里加上Locker，注意管脚有没有错误 最后再来

// ALU的接口标识

ALU myALU(
    .A(ex_data1),
    .B(ex_data2),
    .Cin(1'b0),
    .Card(ex_aluc),
    .Cout(),
    .F(ex_aluout),
    .Zero(ex_zero)
);



EX_MEM myEX_MEM(
    //PC跟踪
    .cpc(ex_cpc),
    .outpc(mem_cpc),


    .clk(clk),
    .resetn(resetn),
    .pcsourse(ex_pcsourse),
    .outpcsourse(mem_pcsourse),
    .npc(ex_pc4),
    .bpc(ex_bpc),
    .npcout(mem_pc4),
    .bpcout(mem_bpc),

    //CU的控制部分
    .wreg(ex_wreg),
    .m2reg(ex_m2reg),
    .wmem(ex_wmem),
    .outwreg(mem_wreg),
    .outm2reg(mem_m2reg),
    .outwmem(mem_wmem),

    //ALU输出部分
    .aluout(ex_aluout),
    .out_aluout(mem_aluout),

    //数值传递部分
    // .EX_ra(ex_ra),
    .EX_rb(ex_chosen_rb),
    .EX_rn(ex_rn),
    .MEM_rn(mem_rn),
    .MEM_rb(mem_bsourse),
    // .MEM_ra(mem_asourse),

    //指令存储部分
    .EX_ir(ex_inst),
    .MEM_ir(mem_inst)
);



DMEM myDataMem(
        .clk(clk),
        .dmem_addr(mem_aluout[7:0]),
        .dmem_wdata(mem_bsourse),
        .dmem_wen(mem_wmem),
        .dmem_rdata(mem_memdata)
);


MEM_WB myMEM_WB(
    //PC跟踪
    .cpc(mem_cpc),
    .outpc(wb_cpc),
    
    .clk(clk),
    .resetn(resetn),
    .pcsourse(mem_pcsourse),
    .outpcsourse(wb_pcsourse),
    .npc(mem_pc4),
    .bpc(mem_bpc),
    .npcout(wb_pc4),
    .bpcout(wb_bpc),

    //CU控制输入
    .wreg(mem_wreg),
    .m2reg(mem_m2reg),
    .outwreg(wb_wreg),
    .outm2reg(wb_m2reg),

    // ALU结果传递
    .aluout(mem_aluout),
    .out_aluout(wb_aluout),

    //MEM内容结果传递
    .ldm(mem_memdata),
    .outldm(wb_memdata),


    //rn传递
    .MEM_rn(mem_rn),
    .WB_rn(wb_rn),

    //Instruct传递
    .MEM_inst(mem_inst),
    .WB_inst(wb_inst),

    .MEM_rb(mem_bsourse),
    .WB_rb(wb_bsourse)
);


wire active;
// wire wreg_sel;
// wire [1:0] pcsourse_sel;

Locker myLocker(

    //接收所有指令
    .if_id_inst(id_inst),
    .id_ex_inst(ex_inst),
    .ex_mem_inst(mem_inst),
    .mem_wb_inst(wb_inst),

    //选择更新的B的数值
    .ex_rbsourse(ex_rbsourse),
    .ex_mem_rb(mem_bsourse),
    .mem_wb_rb(wb_bsourse),

    //A的选择和B的选择控制
    .a_sel(ex_asourse),
    .b_sel(ex_bsourse),
    .asourse(ex_a_sel),
    .bsourse(ex_b_sel),

    //wreg选择,跳转选择
    // .wregsourse(),
    // .pcsourse(),

    //暂停控制
    .stop(stop),
    .id_inst(id_chosen_inst),

    //检测是否在工作
    .active(active)
);

// all kinds of mux    
mux_421 Bget(
    .data1(ex_rb),
    .data2(mem_aluout),
    .data3(mem_memdata),
    .data4(0),
    .index(ex_rbsourse),
    .result(ex_chosen_rb)
);


mux_421 WBdata(
    .data1(wb_aluout),
    .data2(wb_memdata),
    .data3(32'b0),
    .data4(32'b0),
    .index(wb_m2reg),
    .result(wb_data)
);

mux_421_2 RegAddr(
    .data1(id_rd),
    .data2(id_rt),
    .data3(5'b0),
    .data4(5'b0),
    .result(id_rn),
    .index(id_regaddr)
);

mux_421 PCmux(
    .data1(if_pc4),
    .data2(mem_bpc),
    .data3({id_pc4[31:28], id_index[25:24] , id_index << 2}), //代表jpc
    .data4(32'b0),
    .index(mem_pcsourse),
    .result(npc)
);

mux_821 AsourseMux(
    .data1(ex_ra),
    .data2({27'b0,ex_inst[25:21]}),
    .data3({27'b0,ex_inst[10:6]}),
    .data4(mem_aluout),
    .data5(wb_aluout),
    .data6(wb_memdata),
    .data7(32'b0),
    .data8(32'b0),
    .index(ex_a_sel),
    .result(ex_data1)
);

mux_821 BsourseMux(
    .data1(ex_rb),
    .data2(ex_imm),
    .data3(mem_aluout),
    .data4(wb_aluout),
    .data5(wb_memdata),
    .data6(32'b0),
    .data7(32'b0),
    .data8(32'b0),
    .index(ex_b_sel),
    .result(ex_data2)
);




endmodule
