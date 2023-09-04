`timescale 1ns / 1ps

module CU_tb();

  // 时钟信号
  reg clk;

  // 输入信号
  reg [31:0] Instruct;
  reg Zero;

  // 输出信号
  wire ram_w;
  wire reg_w;
  wire [4:0] Card;
  wire [1:0] PC_s;
  wire [1:0] regfile_s;
  wire [1:0] regfile_addr_s;
  wire [1:0] ALU_As;
  wire [1:0] ALU_Bs;

  // Instantiate the CU module
  CU dut (
    .Instruct(Instruct),
    .Zero(Zero),
    .ram_w(ram_w),
    .reg_w(reg_w),
    .Card(Card),
    .PC_s(PC_s),
    .regfile_s(regfile_s),
    .regfile_addr_s(regfile_addr_s),
    .ALU_As(ALU_As),
    .ALU_Bs(ALU_Bs)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    Instruct = 32'h00000020; // Sample instruction (e.g., ADD)
    Zero = 1; // Set Zero flag
    #10; // Wait for a few clock cycles

    // Display the control signals
    $display("ram_w = %b, reg_w = %b, Card = %b, PC_s = %b, regfile_s = %b, regfile_addr_s = %b, ALU_As = %b, ALU_Bs = %b", ram_w, reg_w, Card, PC_s, regfile_s, regfile_addr_s, ALU_As, ALU_Bs);

    $finish; // End simulation
  end

endmodule
