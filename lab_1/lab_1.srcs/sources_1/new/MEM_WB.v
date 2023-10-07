`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/06 22:59:09
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(
        input clk,

        //CU控制输入
        input wreg,
        input m2reg,
        output reg outwreg,
        output reg outm2reg,

        //ALU结果传递
        input [31:0] aluout,
        output reg [31:0] out_aluout,

        //MEM结果传递
        input [31:0] ldm,
        output reg [31:0] outldm,

        //rn传递
        input [4:0] MEM_rn,
        output reg [4:0] WB_rn
    );

        always @(posedge clk) begin
            outm2reg <= m2reg;
            outwreg <= wreg;
            out_aluout <= aluout;
            outldm <= ldm;
            WB_rn <= MEM_rn;
        end

        

endmodule
