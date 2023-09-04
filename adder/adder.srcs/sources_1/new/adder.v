`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/29 17:54:49
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output reg [31:0] sum,
    output reg cout
    );
    integer i=0;
    always @* begin
        cout=cin;
        repeat(32)begin
            i=i+1;
            sum[i]=a[i]^b[i]^cin;
            cout=a[i]&b[i]|a[i]&cin|b[i]&cin;
        end 
    end
endmodule
