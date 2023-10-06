`timescale 1ns / 1ps

module mux_221(
    input index, 
    input [31:0] data1,
    input [31:0] data2,
    output [31:0] result
    );
    assign result = (index == 1'b0) ? data1 : data2;
endmodule
