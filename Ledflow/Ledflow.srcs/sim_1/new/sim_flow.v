`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/04 23:40:35
// Design Name: 
// Module Name: sim_flow
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
module sim_flow();
    wire [7:0] led;
    reg clk,reset;
    wire clock;
    set_clk u1(clk,clock);
    flow_led i1(clock,reset,led);
 initial
    begin
    #0 reset=0;
    #0 reset=1;
    #0 reset=0;
    #0 clk=0;
    end
    always #10 clk=~clk;
endmodule
