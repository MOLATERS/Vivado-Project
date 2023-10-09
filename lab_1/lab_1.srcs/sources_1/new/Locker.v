`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/08 14:37:20
// Design Name: 
// Module Name: Locker
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

// module super_CU(
//     input wire [31:0]if_id_ir,
//     input wire [31:0]id_ex_inst,
//     input wire [31:0]ex_mem_inst,
//     input wire [31:0]mem_wb_inst,
//     output reg [2:0] A_sel,
//     output reg [2:0] B_sel,
//     output reg ram_sel,
//     output reg stop,
//     output reg [31:0]ir,
//     output reg [1:0]B_chooser,
//     input wire [31:0] ex_mem_B,
//     input wire [31:0] mem_wb_B
//     );
    
//     always@(*)
//     begin
//         if ((id_ex_inst[31:26]==6'b100011&&if_id_ir[31:26]==6'b0 &&id_ex_inst[20:16]==if_id_ir[25:21])||(id_ex_inst[31:26]==6'b100011&&if_id_ir[31:26]==6'b0 &&id_ex_inst[20:16]==if_id_ir[20:16])||(id_ex_inst[31:26]==6'b100011&&if_id_ir[31:26]==6'b100011 &&id_ex_inst[20:16]==if_id_ir[25:21]))//气泡
//         begin
//             stop=1;
//             ir=32'b0;
//         end
//         else if((ex_mem_inst[31:26]==6'b100011&&if_id_ir[31:26]==6'b100011 &&ex_mem_inst[20:16]==if_id_ir[25:21]))//写后读
//         begin
//             stop=1;
//             ir=32'b0;
//         end
//         else
//         begin
//             stop=0;
//             ir=if_id_ir;
//         end
        
        
        
        
//         if (ex_mem_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b0 &&ex_mem_inst[15:11]==id_ex_inst[25:21]&& !(ex_mem_inst[10:0]==11'b00000001010 && ex_mem_B != 32'b0)&&!(ex_mem_inst==32'b0&&id_ex_inst[10:0]==32'b0))
//         begin
//             A_sel=3'b011;
//         end
//         else if (ex_mem_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b100011 &&ex_mem_inst[15:11]==id_ex_inst[25:21]&& !(ex_mem_inst[10:0]==11'b00000001010 && ex_mem_B != 32'b0))
//         begin
//             A_sel=3'b011;
//         end
//         else if (mem_wb_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b0 &&mem_wb_inst[15:11]==id_ex_inst[25:21]&& !(mem_wb_inst[10:0]==11'b00000001010 && mem_wb_B != 32'b0)&&!(mem_wb_inst==32'b0&&id_ex_inst[10:0]==32'b0))
//         begin
//             A_sel=3'b100;
//         end
//         else if (mem_wb_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b100011 &&mem_wb_inst[15:11]==id_ex_inst[25:21]&& !(mem_wb_inst[10:0]==11'b00000001010 && mem_wb_B != 32'b0))
//         begin
//             A_sel=3'b100;
//         end
        
//         else if (mem_wb_inst[31:26]==6'b100011&&id_ex_inst[31:26]==6'b0 &&mem_wb_inst[20:16]==id_ex_inst[25:21])
//         begin
//             A_sel=3'b100;
//         end
//         else if (mem_wb_inst[31:26]==6'b100011&&id_ex_inst[31:26]==6'b0 &&mem_wb_inst[20:16]==id_ex_inst[25:21])
//         begin
//             A_sel=3'b100;
//         end
//         else if (id_ex_inst[31:26]==6'b0&&id_ex_inst[5:0]==6'b0)
//         begin
//             A_sel = 3'b010;
//         end
//         else 
//         begin
//             A_sel=3'b000;
//         end
        
        
//         if (ex_mem_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b0 &&ex_mem_inst[15:11]==id_ex_inst[20:16]&&!(ex_mem_inst[10:0]==11'b00000001010 && ex_mem_B != 32'b0)&&!(ex_mem_inst==32'b0&&id_ex_inst[10:0]==32'b0))
//         begin
//             B_sel=3'b011;
//             B_chooser = 2'b01;
//         end
//         else if (mem_wb_inst[31:26]==6'b0&&id_ex_inst[31:26]==6'b0 &&mem_wb_inst[15:11]==id_ex_inst[20:16]&& !(mem_wb_inst[10:0]==11'b00000001010 && mem_wb_B != 32'b0)&&!(mem_wb_inst==32'b0&&id_ex_inst[10:0]==32'b0))
//         begin
//             B_sel=3'b100;
//             B_chooser=2'b10;
//         end
//          else if (mem_wb_inst[31:26]==6'b100011&&id_ex_inst[31:26]==6'b0 &&mem_wb_inst[20:16]==id_ex_inst[20:16])
//         begin
//             B_sel=3'b100;
//             B_chooser=2'b10;
//         end
//         else if (id_ex_inst[31:26]==6'b100011)
//         begin
//             B_sel = 3'b001;
//             B_chooser=2'b00;
//         end
//         else
//         begin
//             B_sel = 3'b000;
//             B_chooser=2'b00;
//         end
// end  
    

// endmodule

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


module Locker(
    
    //用于监测数据冲突
    input [31:0] if_id_inst,
    input [31:0] id_ex_inst,
    input [31:0] ex_mem_inst,
    input [31:0] mem_wb_inst,
    
    //更新ex段作为写入的B寄存器内容
    output reg [1:0] ex_rbsourse,


    input [31:0] ex_mem_rb,
    input [31:0] mem_wb_rb,

    //用于进行A,B资源选择
    input [2:0] a_sel,
    input [2:0] b_sel,
    output reg [2:0] asourse,
    output reg [2:0] bsourse,
    output reg stop,
    output reg [31:0] id_inst,

    output reg active
    );

    initial begin
        stop = 0;
        active = 0;
        id_inst = if_id_inst;
    end

always @(*) begin
        //产生暂停的条件
        if(
            (
                id_ex_inst[31:26] == `Lw 
                && if_id_inst[31:26] == `Cal 
                && id_ex_inst[20:16] == if_id_inst[25:21]
            )
            ||
            (
                id_ex_inst[31:26] == `Lw 
                && if_id_inst[31:26] == `Cal 
                && id_ex_inst[20:16] == if_id_inst[20:16]
            )
            ||
            (
                id_ex_inst[31:26] == `Lw 
                && if_id_inst[31:26] == `Lw
                && id_ex_inst[20:16] == if_id_inst[25:21]
            )
            ||
            (
                ex_mem_inst[31:26] == `Lw
                && if_id_inst[31:26] == `Lw 
                &&ex_mem_inst[20:16] == if_id_inst[25:21]
            )
        )begin   
            stop = 1;
            id_inst = 32'h00000000;
            active = 1;
        end
        else begin
            stop = 0;
            active = 0;
            id_inst = if_id_inst; 
        end
    end


always @(*) begin
        // 控制A数据定向
        if(
            (
                ex_mem_inst[31:26] == `Cal
                && id_ex_inst[31:26] == `Cal
                && ex_mem_inst[15:11] == id_ex_inst[25:21]
                && (ex_mem_inst[5:0] == `Movz || ex_mem_rb == 32'b0)
                && (ex_mem_inst != 32'b0 || id_ex_inst != 32'b0)
            )
            ||
            (
                ex_mem_inst[31:26] == `Cal
                && id_ex_inst[31:26] == `Lw 
                && ex_mem_inst[15:11] == id_ex_inst[25:21]
                && (ex_mem_inst[5:0] == `Movz || ex_mem_rb == 32'b0)
            )
        )begin
            asourse = 3;
            active = 1;
        end
        else if(
            (
                mem_wb_inst[31:26]== `Cal
                && id_ex_inst[31:26]== `Cal
                && mem_wb_inst[15:11] == id_ex_inst[25:21]
                && (mem_wb_inst[5:0] != `Movz || mem_wb_rb == 32'b0)
                && (mem_wb_inst !=32'b0 || id_ex_inst != 32'b0)
            )
            ||
            (
                mem_wb_inst[31:26]== `Cal
                && id_ex_inst[31:26]== `Lw 
                && mem_wb_inst[15:11] == id_ex_inst[25:21]
                && (mem_wb_inst[5:0] != `Movz || mem_wb_rb == 32'b0)
            )
            ||
            (
                mem_wb_inst[31:26] == `Lw
                && id_ex_inst[31:26] == `Cal 
                && mem_wb_inst[20:16] == id_ex_inst[25:21]
            )
        )begin
            asourse = 4;
            active = 1;
        end
        
        else if(
            (
                id_ex_inst[31:26]==6'b0 && id_ex_inst[5:0]== 6'b0
            )
        )begin
           asourse = 2; 
           active = 1;
        end
        else begin
            asourse = a_sel;
            active = 0;
        end
end


always @(*) begin
        //控制B数据定向
        if(
            (
                ex_mem_inst[31:26] == `Cal
                && id_ex_inst[31:26] == `Cal 
                && ex_mem_inst[15:11] == id_ex_inst[20:16]
                && (ex_mem_inst[5:0] !=  `Movz || ex_mem_rb == 32'b0)
                && (ex_mem_inst != 32'b0 || id_ex_inst[10:0] != 32'b0)
            )
        )begin
            bsourse = 2;
            ex_rbsourse = 1;
            active = 1;
        end
        else if(
            (
                mem_wb_inst[31:26]== `Cal
                && id_ex_inst[31:26]== `Cal 
                && mem_wb_inst[15:11] == id_ex_inst[20:16]
                && (mem_wb_inst[5:0] != `Movz || mem_wb_rb == 32'b0)
                && (mem_wb_inst != 32'b0 && id_ex_inst[10:0] != 32'b0)
            )
            ||
            (
                mem_wb_inst [31:26] ==`Lw
                && id_ex_inst [31:26] == `Cal
                && mem_wb_inst [20:16] == id_ex_inst [20:16]
            )
        )begin
            bsourse = 3;
            ex_rbsourse = 2;
            active = 1;
        end

        else begin
            bsourse = b_sel;
            ex_rbsourse = 0;
            active = 0;
        end
    end

endmodule
