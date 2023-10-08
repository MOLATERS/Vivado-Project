`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/25 21:32:46
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] a, b, // 32位输入
    input cin,    // 进位输入
    input [4:0] card,   //操作码
    output reg [31:0] F, // 32位和
    output reg cout,   // 进位输出
    output reg zero
    );
    reg [35:0] sum_temp;  // 36位临时和
    always @( a,b,cin,card) begin

        case (card) 
        5'b00001 :begin
               {cout, F} = a + b;
               zero = (F == 0);
            end
        5'b00010 :begin
               {cout, F} = a + b + cin;
               zero = (F == 0);
            end
        5'b00011 :begin
              if (a >= b) begin
                 F = a - b;
                 cout = 0;
                end else begin
                 sum_temp =  {4'b0000, a} + 36'h100000000 ;
                 F = sum_temp[32:0] - b;
                 cout = 1;
                 zero = (F == 0);
                end
            end   
        5'b00100 :begin
              if (a >= (b+cin)) begin
                 F = a - b -cin;
                 cout = 0;
                end else begin
                 sum_temp =  {4'b0000, a} + 36'h100000000 ;
                F = sum_temp[32:0] - b - cin;
                 cout = 1;
                 zero = (F == 0);
                end
            end
        5'b00101 :begin
              if (b >= a) begin
                 F = b - a;
                 cout = 0;
                end else begin
                 sum_temp =  {4'b0000, b} + 36'h100000000 ;
                 F = sum_temp[32:0] - a;
                 cout = 1;
                 zero = (F == 0);
                end
            end
        5'b00110 :begin
              if (b >= (a+cin)) begin
                 F = b - a -cin;
                 cout = 0;
                end else begin
                 sum_temp =  {4'b0000, b} + 36'h100000000 ;
                 F = sum_temp[32:0] - a -cin;
                 cout = 1;
                 zero = (F == 0);
                end
            end
        5'b00111 :begin
              F = a;
              cout = 0;
              zero = (F == 0);
            end
        5'b01000 :begin
               F = b;
               cout = 0;
               zero = (F == 0);
            end
        5'b01001 :begin
               F = !a;
               cout = 0;
               zero = (F == 0);
            end     
        5'b01010 :begin
               F = !b;
               cout = 0;
               zero = (F == 0);
            end
        5'b01011 :begin
               F = a|b;
               cout = 0;
               zero = (F == 0);
            end
        5'b01100 :begin
              F = a&b;
               cout = 0;
               zero = (F == 0);
            end
        5'b01101 :begin
               F = (a&&b)||((!a)&&(!b));
               cout = 0;
               zero = (F == 0);
            end
        5'b01110 :begin
               F = (a&(~b))|((~a)&b);  
               cout = 0;
               zero = (F == 0);
            end
        5'b01111 :begin
              F = !(a&&b);
              cout = 0;
              zero = (F == 0);
            end
        5'b10000 :begin
               F = 0;
               cout = 0;
               zero = 1;
            end      
        5'b10001:begin
               F = a<b ? 1:0;
               cout=0;
               zero = (F == 0);
        end
        5'b10010:begin
            {cout,F}=b << a;
            zero = (F == 0);
        end
        5'b10011:begin
            {cout,F} =  a + (b << 2);
            zero = (F == 0);
        end
        5'b10100:begin
            F = {a[31:28],b[25:0],2'b0};
            cout = 0;
            zero = (F == 0);
        end
        5'b10101:begin
            F = (b==0)?({1'b1,a[31:0]}):32'h0;
            cout = 0;
            zero = (F == 0);
        end
            
        endcase
    end

endmodule
