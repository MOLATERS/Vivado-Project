`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/27 21:27:50
// Design Name: 
// Module Name: mux_simulation
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


module mux_simulation( );

    reg  [1:0] d0;
    reg  [1:0] d1;
    reg select;
    wire [1:0] out;

    mux mux_test(
        .d0(d0),
        .d1(d1),
        .select(select),
        .out(out)
    );
    initial begin
        d0 = 00; d1 = 01; select = 0;
        #200;
        d0 = 01; d1 = 10; select = 1;
        #200;
        d0 = 00; d1 = 11; select = 0;
        #200;
        d0 = 11; d1 = 00; select = 1;
        #200;
        d0 = 11; d1 = 10; select = 0;
        #200;
        d0 = 10; d1 = 00; select = 1;
        #200;
        $stop;
    end
endmodule
