`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/28 20:12:10
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

reg [31:0] A;
reg [31:0] B;
reg cin;
reg [4:0] Card;
wire [31:0] out;
wire cout;
wire zero;

alu alu_test(
    .A(A),
    .B(B),
    .Cin(cin),
    .Card(Card),
    .F(out),
    .Cout(cout),
    .Zero(zero)
);

    
initial begin
    A=32'b00000000000000000000000000001011;
    B=32'b00000000000000000000000000000001;
    Card = 5'b00000;
    cin=1;
    repeat (16) begin
        #50;
        Card <=Card + 5'b00001;
    end
end



endmodule
