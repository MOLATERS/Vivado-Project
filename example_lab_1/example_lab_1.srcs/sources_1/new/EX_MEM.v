`timescale 1ns / 1ps

module EX_MEM(
    input wire clk,
    input wire [31:0]ALU_out,
    input wire reset,   
    input wire [31:0]ir_in,
    input wire [31:0]B,
    input wire [31:0] PC,
    output reg [31:0] CPC,
    output wire ram_w,
    output reg [31:0]ALU_res,
    output reg [31:0]store_num,
    output reg [31:0]IR 
    );
    always @(posedge clk or negedge reset) begin
    if(!reset) 
        begin
            ALU_res=0;
            store_num=0;
            CPC=0;
            IR=0;   
        end
    else if(ir_in==8'h00000000)
    begin
            ALU_res=0;
            store_num=0;
            CPC=PC;
            IR=0; 
    end
    else
        begin
            store_num=B;
            ALU_res=ALU_out;
            IR=ir_in; 
            CPC=PC;
        end

end
CU cu(
    .clk(clk),
   .ir(ir_in),
   .ram_w(ram_w)
   );
endmodule
