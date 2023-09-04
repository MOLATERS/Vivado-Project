`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/03 11:00:12
// Design Name: 
// Module Name: DEME_tb
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

module DMEM_tb();

  // 时钟信号
  reg clk;

  // 数据存储器信号
  reg [7:0] dmem_addr;
  reg [31:0] dmem_wdata;
  wire [31:0] dmem_rdata;

  // 控制信号
  reg reset;
  reg dmem_wen;

  // Instantiate the DMEM module
  DMEM dut (
    .clk(clk),
    .dmem_addr(dmem_addr),
    .dmem_wdata(dmem_wdata),
    .dmem_wen(dmem_wen),
    .dmem_rdata(dmem_rdata)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin

    clk = 0;
    reset = 1; // Reset the memory
    dmem_wen = 0; // Disable writes initially
    dmem_addr = 8'h00;
    dmem_wdata = 32'h00001234; // Input data for write
    #10; // Wait for a few clock cycles

    // Release reset
    reset = 0;

    // Write data to the memory
    dmem_wen = 1;
    #10;
    dmem_wen = 0;

    // Read data from the memory
    dmem_addr = 8'h00; // Set address for read
    #10;

    // Display the read data
    $display("dmem_rdata = %h", dmem_rdata);

    $finish; // End simulation
  end

endmodule
