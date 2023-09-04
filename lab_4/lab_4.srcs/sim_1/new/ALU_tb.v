`timescale 1ns / 1ps
`define ADD     5'b00001
// 加
`define ADDI    5'b00010
// 加进位
`define SUB     5'b00011
// 减
`define SUBI    5'b00100
//减进位
`define RSUB    5'b00101
//反减
`define RSUBI   5'b00110
//反减再减进位
`define GA      5'b00111
//赋值为A
`define GB      5'b01000
//赋值为B
`define NEGA    5'b01001
//A取反
`define NEGB    5'b01010
//B取反
`define OR      5'b01011
//或
`define AND     5'b01100
//与
`define XNOR    5'b01101
//同或
`define XOR     5'b01110
//异或
`define NAND    5'b01111
//与取反
`define ZERO    5'b10000
//置零
`define SLT     5'b10001
//小于
`define SLL     5'b10010
//左移
`define PC      5'b10011
//更新PC

module ALU_tb();

  // 时钟信号
  reg clk;

  // 输入信号
  reg [31:0] A;
  reg [31:0] B;
  reg Cin;
  reg [4:0] Card;

  // 输出信号
  wire [31:0] F;
  wire Cout;
  wire Zero;

  // Instantiate the ALU module
  ALU dut (
    .A(A),
    .B(B),
    .Cin(Cin),
    .Card(Card),
    .F(F),
    .Cout(Cout),
    .Zero(Zero)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    
    // Test ADD operation
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 0;
    Card = `ADD;
    #10;
    $display("ADD: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test SUB operation
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 0;
    Card = `SUB;
    #10;
    $display("SUB: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test OR operation
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 0;
    Card = `OR;
    #10;
    $display("OR: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test AND operation
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 0;
    Card = `AND;
    #10;
    $display("AND: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Test XOR operation
    A = 32'h0000000A;
    B = 32'h00000005;
    Cin = 0;
    Card = `XOR;
    #10;
    $display("XOR: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);

    // Add more test cases for other operations here
    A = 32'h00000030;
    B = 32'h00000002;
    Cin = 0;
    Card = `PC;
    #10;
    $display("XOR: F = %h, Cout = %b, Zero = %b", F, Cout, Zero);
    $finish; // End simulation
  end

endmodule
