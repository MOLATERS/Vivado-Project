`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 10:55:17
// Design Name: 
// Module Name: data_container_td
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

module Data_container_td();

  // 时钟和复位信号
  reg clk;
  reg rst;

  // 数据输入和输出信号
  reg [31:0] din;
  wire [31:0] dout;

  // 控制信号
  reg load;

  // Instantiate the Data_container module
  Data_container dut (
    .clk(clk),
    .rst(rst),
    .din(din),
    .load(load),
    .dout(dout)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    rst = 0;
    load = 0;
    din = 32'h00001234; // Input data for write
    #10; // Wait for a few clock cycles

    // Reset test
    rst = 1;
    #10;
    rst = 0;

    // Write data to the module
    load = 1;
    #10;
    load = 0;

    // Read data from the module
    din = 32'h00000000; // Reset input data
    #10;
    
    // Display the read data
    $display("dout = %h", dout);

    $finish; // End simulation
  end

endmodule
