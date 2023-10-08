`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:46:36
// Design Name: 
// Module Name: regfiles
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


module regfiles(
    input clk,
    input [4:0] raddr1,
    input [4:0] raddr2,
    output [31:0] rdata1,
    output [31:0] rdata2,
    input we,
    input [4:0]waddr,
    input [31:0]wdata
    );
    reg [31:0] Reg_files [0:31];
    integer i;
   initial begin
    for ( i = 0; i < 32; i = i + 1) begin
        Reg_files[i] <= 32'b0;
    end
end

    always @(negedge clk) begin
        if(we) Reg_files[waddr] <= wdata;
    end

    assign rdata1 = Reg_files[raddr1];
    assign rdata2 = Reg_files[raddr2];
endmodule
