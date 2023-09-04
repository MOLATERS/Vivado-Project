//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 10:52:30
// Design Name: 
// Module Name: Regfile_tb
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


`timescale 1ns / 1ps

module Regfile_tb();
    reg clk;
    reg [4:0] raddr1;
    wire [31:0] rdata1;
    reg [4:0] raddr2;
    wire [31:0] rdata2;
    reg we;
    reg [4:0] waddr;
    reg [31:0] wdata;

    // Instantiate the Regfile module
    Regfile regfile (
        .clk(clk),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .raddr2(raddr2),
        .rdata2(rdata2),
        .we(we),
        .waddr(waddr),
        .wdata(wdata)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        clk = 0;
        we = 1; // Enable writes

        // Write some data to the registers
        waddr = 0; // Write to register 0
        wdata = 32'h0000_1234;
        #10; // Wait for a few clock cycles
        waddr = 1; // Write to register 1
        wdata = 32'haaaaaaaa;
        #10; // Wait for a few clock cycles

        // Read data from the registers
        raddr1 = 0; // Read from register 0
        raddr2 = 1; // Read from register 1
        #10; // Wait for a few clock cycles

        // Display the read data
        $display("rdata1 = %h, rdata2 = %h", rdata1, rdata2);

        $finish; // End simulation
    end
endmodule

