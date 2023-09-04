`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 20:36:33
// Design Name: 
// Module Name: new_show
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







module new_show(
    input clk,
    input [3:0] score,
    input [3:0] b1,
    input [3:0] place1,
    input [3:0] place2,
    input [3:0] place3,
    output reg [7:0] show,
    output reg [3:0] plc,
    input reset
    );
    reg [3:0] state=4'd0;
    reg [23:0] dis=24'b0;
    reg [31:0]count;//分频使用的计数器
    reg reclk;
    reg a;
    reg aa;
    reg b;
    reg bb;
    reg c;
    reg cc;
    reg d;
    reg dd;
    
always @(posedge clk or negedge reset)//设置一个计数器，用于分频
begin
     if (!reset)
     begin
     count = 32'b0;
     end
     else if (count == 32'd900000000)
     begin
     count = 32'b0;
     end
     else
     begin
     count = count + 1;
     end
end

always @(posedge clk or negedge reset)//发送新的时钟信号
begin
     if (!reset)
     begin
     reclk = 1'b0;
     end
     else if ( count % 100000 == 0)
     begin
     reclk = ~reclk;
     end
end
    
    
 always@(posedge reclk or negedge reset)
    begin 
    a <=score[3];
    b <=score[2];
    c <=score[1];
    d <=score[0];
    aa <=b1[3];
    bb <=b1[2];
    cc <=b1[1];
    dd <= b1[0];
    dis[1]<=(a&b)|(a&c);//B1
    dis[2]<=dis[1];//C1
    dis[8]<=(~a&c)|(b&d)|(~c&a)|(~a&~b&~c&~d)|(a&~b&c&~d);//A2
    dis[9]<=(a&~c)|(~c&~d&b)|(c&d&~a)|(~a&~b&c)|(~b&d)|(a&b&~d)|(~a&~b&~c&~d)|(a&~b&c&~d);//B2
    dis[10]<=(~a&b)|(c&b)|(~b&a&~c)|(d)|(~a&~b&~c&~d)|(a&~b&c&~d);//C2
    dis[11]<=(a&~c)|(b&~c&d)|(c&~a&~b)|(~a&c&~d)|(~a&~b&~c&~d)|(a&~b&c&~d);//D2
    dis[12]<=(a&~c&~d)|(~a&c&~d)|(~a&~b&~c&~d)|(a&~b&c&~d);//E2
    dis[13]<=(~a&b&~c)|(a&b&c)|(b&c&~d)|(~c&a&~b)|(~a&~b&~c&~d)|(a&~b&c&~d);//F2
    dis[14]<=(~c&b)|(~a&~b&c)|(~a&c&~d)|(a&b)|(a&~c);//G2
    dis[16]<=(~aa&cc)|(bb&dd)|(~cc&aa)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//A2
    dis[17]<=(aa&~cc)|(~cc&~dd&bb)|(cc&dd&~aa)|(~aa&~bb&cc)|(~bb&dd)|(aa&bb&~dd)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//B2
    dis[18]<=(~aa&bb)|(cc&bb)|(~bb&aa&~cc)|(dd)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//C2
    dis[19]<=(aa&~cc)|(bb&~cc&dd)|(cc&~aa&~bb)|(~aa&cc&~dd)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//D2
    dis[20]<=(aa&~cc&~dd)|(~aa&cc&~dd)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//E2
    dis[21]<=(~aa&bb&~cc)|(aa&bb&cc)|(bb&cc&~dd)|(~cc&aa&~bb)|(~aa&~bb&~cc&~dd)|(aa&~bb&cc&~dd);//F2
    dis[22]<=(~cc&bb)|(~aa&~bb&cc)|(~aa&cc&~dd)|(aa&bb)|(aa&~cc);//G2
        if (!reset)
        begin
        state<=4'd0;
        dis<=24'b0;
        show <= 8'b10111110;
        plc <=4'b1010;
        end
        else
        begin
        case(state)
        
        4'd0:
        begin
            show[0]=dis[0];
            show[1]=dis[1];
            show[2]=dis[2];
            show[3]=dis[3];
            show[4]=dis[4];
            show[5]=dis[5];
            show[6]=dis[6];
            show[7]=dis[7];
            plc=place1;
            state = 4'd1;
        end
        
        4'd1:
        begin
            show[0]=dis[8];
            show[1]=dis[9];
            show[2]=dis[10];
            show[3]=dis[11];
            show[4]=dis[12];
            show[5]=dis[13];
            show[6]=dis[14];
            show[7]=dis[15];
            plc=place2;
            state = 4'd2;
        end
        
        4'd2:
        begin
            show[0]=dis[16];
            show[1]=dis[17];
            show[2]=dis[18];
            show[3]=dis[19];
            show[4]=dis[20];
            show[5]=dis[21];
            show[6]=dis[22];
            show[7]=dis[23];
            plc=place3;
            state = 4'd0;
        end
        
        default:
        begin
        state = 4'd0;
        end
        endcase
        end
    end
    

endmodule


