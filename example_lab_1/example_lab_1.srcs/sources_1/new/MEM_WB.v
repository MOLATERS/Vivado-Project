`timescale 1ns / 1ps

module MEM_WB(
    input wire clk,
    input wire [31:0]LDM_IN,
    input wire reset,   
    input wire [31:0]ir_in,
    input wire [31:0]ALU_out,
    input wire [31:0] B,
    input wire [31:0] PC,
    output reg [31:0] CPC,
    output reg [31:0]LDM_OUT,
    output reg [31:0]ALU_res,     
    output reg [31:0]IR ,
    output wire wdata_sel,
    output wire reg_w,
    output wire [31:0]waddr,
    output reg [31:0]wb_B
    );
    always @(posedge clk or negedge reset) begin
    if(!reset) 
        begin
            LDM_OUT=0;
            ALU_res=0;
            IR=0;   
            wb_B=0;
            CPC=0;
        end
    else if (ir_in==8'h00000000)
    begin
            LDM_OUT=0;
            ALU_res=0;
            IR=0; 
            wb_B=0;
            CPC=PC;
    end
    else
        begin
            LDM_OUT=LDM_IN;
            ALU_res=ALU_out;       
            IR=ir_in;  
            CPC=PC;
            wb_B=B;
        end

end
CU cu(
    .clk(clk),
   .ir(ir_in),
   .wdata_sel(wdata_sel),
   .reg_w(reg_w),
   .waddr(waddr),
   .rdata2(B)
   );
endmodule
