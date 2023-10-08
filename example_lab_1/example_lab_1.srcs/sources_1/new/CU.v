`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 12:05:00
// Design Name: 
// Module Name: CU
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
`define ADD     5'b00001
`define ADDI    5'b00010
`define SUB     5'b00011
`define SUBI    5'b00100
`define RSUB    5'b00101
`define RSUBI   5'b00110
`define GA      5'b00111
`define GB      5'b01000
`define NEGA    5'b01001
`define NEGB    5'b01010
`define OR      5'b01011
`define AND     5'b01100
`define XNOR    5'b01101
`define XOR     5'b01110
`define NAND    5'b01111
`define ZERO    5'b10000
`define SLT     5'b10001
`define SLL     5'b10010
`define PC      5'b10011
`define JMP     5'b10100
`define IFMOVE  5'b10101
module CU(
    input clk,
    input [31:0] ir,     
    input cout,      
    output reg ram_w,           
    output reg reg_w,           
    input [31:0]rdata1,
    input [31:0]rdata2,

    output reg [1:0] ALU_A_sel,          
    output reg [1:0] ALU_B_sel,           
    output reg [4:0] card,      
    output reg  PC_sel,           
    output reg  wdata_sel,       
    output reg [31:0] waddr  
             
    );

    reg [5:0] Op;
    reg [5:0] Func;
    
    always @(posedge clk) begin
        Func = ir[31:26];
        Op = ir[5:0];
        if (ir==32'h00000000)
        begin
            ALU_A_sel=0;
            ALU_B_sel=0;
            card=0;
            PC_sel=0;
            wdata_sel=0;
            waddr=0;
            reg_w=0;
            ram_w=0;
        end
        else
        begin
        case (Func)
            6'b000000: begin
                case (Op)
                    6'b100000: begin //add
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100;          
                        card <= `ADD;                   
                        waddr<=ir[15:11]; 
                        ALU_A_sel <= 0;           
                        ALU_B_sel <= 0;    
                            
                    end
                    6'b100010: begin //sub
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `SUB;             
                        wdata_sel <= 0;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end 
                    6'b100100: begin //AND
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `AND;
                        wdata_sel <= 0;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                    6'b100101: begin//OR
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `OR;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                    6'b100110: begin //XOR
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `XOR;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                    6'b101010: begin //SLT
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `SLT;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                    6'b001010: begin // if move
                        ram_w <= 0;
                        if (rdata2==32'h00000000)
                        begin
                        reg_w <= 1;
                        end     
                        else
                        begin
                        reg_w<=0;
                        end  
                        card <= `GA;
                        PC_sel <= 0;
                        wdata_sel <= 0;     
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                    6'b000000: begin 
                        {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0100; 
                        card <= `SLL;
                        waddr<=ir[15:11];
                        ALU_A_sel<= 2;         
                        ALU_B_sel <= 0;          
                    end
                    default: begin
                       {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0000; 
                        card <= 0;
                        waddr<=ir[15:11];
                        ALU_A_sel <= 0;
                        ALU_B_sel <= 0;
                    end
                endcase
            end 
            6'b101011: begin //SW
                {ram_w,reg_w,PC_sel,wdata_sel}<=4'b1000; 
                card <= `ADD;
                waddr<=ir[20:16];     
                ALU_A_sel <= 0;            
                ALU_B_sel <= 1;       
            end
            6'b100011: begin //LW
            {ram_w,reg_w,PC_sel,wdata_sel}=4'b0101; 
                card = `ADD;              
                waddr=ir[20:16];   
                ALU_A_sel = 0;           
                ALU_B_sel = 1;            
            end
            
            6'b000101: begin//条件跳转
                ram_w <= 0;
                reg_w <= 0;
                card <= `PC;       
                if(rdata1===rdata2)
                begin PC_sel = 0;
                end  
                else 
                begin PC_sel = 1;
                end
                wdata_sel <= 0;
                waddr<=ir[15:11];
                ALU_A_sel <= 1;          
                ALU_B_sel <= 1;          
            end
            
            6'b000010: begin //无条件跳转
                {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0010; 
                card <= 5'b10100;
                waddr<=ir[15:11];
                ALU_A_sel <= 1;
                ALU_B_sel <= 2;
            end
            default: begin
                {ram_w,reg_w,PC_sel,wdata_sel}<=4'b0000; 
                card <= 0;
                waddr<=ir[15:11];
                ALU_A_sel <= 0;
                ALU_B_sel <= 0;
            end
        endcase
        end
    end
endmodule

