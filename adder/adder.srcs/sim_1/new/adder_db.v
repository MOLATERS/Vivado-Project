`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/29 18:00:54
// Design Name: 
// Module Name: adder_db
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


module adder_db();
reg [31:0] a,b;
reg cin;
wire cout;
wire [31:0] sum;

adder adder_test(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    a=32'h00000001;
    b=32'h00000007;
    cin = 0;
    #200;
    a=32'h22222222;
    b=32'h99999999;
    cin = 1;
    #200;
end
endmodule
