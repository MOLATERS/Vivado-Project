`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 19:57:37
// Design Name: 
// Module Name: pingpang
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


module pingpang(ball,p1,p2,b1,b2,score1,score2,s1,s2,div,reset,clk,who,who1);
output [7:0]ball;//乒乓球
input  wire p1;
input  wire p2;//选手打球的一个操作
input  [7:0]div;//时钟分频的选择，控制球速
input  reset;//复位按钮
output [3:0]b1;
output [3:0]b2;//发球的次数
output [3:0]score1;
output [3:0]score2;
output [3:0]s1;
output [3:0]s2;//两位选手的大比分
output who;
output who1;
input clk;//时钟

reg [3:0]score1;
reg [3:0]score2;//两位选手的小比分
reg [31:0]count;//分频使用的计数器
reg [7:0]ball;//乒乓球
reg reclk;//分频之后的时钟
reg [3:0]s1;
reg [3:0]s2;//发球的次数
reg [3:0]b1;
reg [3:0]b2;//大比分
reg [31:0]temp;
reg who;//标志一下该谁发球了
reg who1;
reg [2:0]state;//打球的几种状态
reg start;//正在比赛的标志

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
     temp = div * 1000000;
     if (!reset)
     begin
     reclk = 1'b0;
     end
     else if ( count % temp == 0)
     begin
     reclk = ~reclk;
     end
end

always @ (posedge reclk or negedge reset)
        begin
            if(!reset)//初始化
                begin
                    score1<=4'b0;
                    score2<=4'b0;
                    s1<=4'b0;
                    s2 <=4'b0;
                    ball <= 8'b0;
                    state <= 3'd0;
                    who <= 0;
                    start <= 0;
                    b1 <= 0;
                    b2 <= 0;
                end
            else
                begin
                start<=1;//游戏开始
                    case(state)
                    
                        3'd0:begin//等待双方发球，判断胜负
                            ball <= 8'b00000000;//球桌初始状态
                            if (score1 == 11 || score2 == 11)
                            begin
                                 start <= 0;
                            end
                        else
                                begin
                                    if(score1 != 0 && score1 % 5 == 0)//每得五分，交换发球权
                                        begin
                                            who <= 1;
                                        end
                                    if(score2 != 0 && score2 % 5 == 0)
                                        begin
                                            who <= 0;
                                        end
                                    if(who == 0 && p1 == 1)//p1发球
                                        begin
                                            state <= 3'd1;//p1发球阶段
                                        end
                                    else if(who == 1 && p2 == 1)//p2发球
                                        begin
                                            state <= 3'd4;//p2发球阶段
                                        end
                                    else
                                        state <= 3'd0;
                                end
                            end
                        3'd1:begin
                            if(ball == 8'b00000000)//p1发球
                                begin
                                    ball <= 8'b00000001;
                                    s1 <= s1+1'b1;//统计p1发球次数
                                    state <= 3'd2;
                                end
                            else//p1接球
                                begin
                                    ball <= 8'b00000001;
                                    state <= 3'd2;
                                end
                        end
                        3'd2:begin
                            if(p2)
                                begin
                                    score1 <= score1+1'b1;//p1加一分                                   
                                    who <= 0;                               
                                    state <= 3'd0;
                                end
                            else
                                begin                               
                                    if(ball == 8'b10000000)//判断p1接球的状态
                                        begin
                                            state <= 3'd3;
                                        end
                                    else
                                        begin
                                            ball = ball << 1;
                                            state <= 3'd2;
                                        end
                                end
                        end
                        
                        3'd3:begin
                            if(p2 == 1)
                                begin
                                    state <= 3'd4;//p2接球成功
                                end
                            else
                                begin
                                    score1 <= score1+1'b1;//p2接球不成功,p1得分
                                    who <= 0;//球权移交到p1
                                    state <= 3'd0;
                                end                               
                        end
                        
                        3'd4:begin//
                            if(ball <= 8'b00000000)//p2发球
                                begin
                                    ball <= 8'b10000000;
                                    s2 <= s2 + 1'b1;//记录p2发球次数
                                    state <= 3'd5;
                                end
                            else//p2接到了球
                                begin
                                    ball <= 8'b10000000;
                                    state <= 3'd5;
                                end
                        end
                        
                        3'd5:begin//球右移
                            if(p1)
                                begin
                                    score2 <= score2+1'b1;//p2加一分                                  
                                    who <= 1;//p2发球                                 
                                    state <= 3'd0;
                                end
                            else
                                begin
                                    if(ball==8'b00000001)
                                        begin
                                            state <= 3'd6;
                                        end
                                    else
                                        begin
                                            ball=ball >> 1;
                                            state <= 3'd5;
                                        end
                                end
                        end
                        3'd6:begin//p1可以击球
                            if(p1 == 1)
                                begin
                                    state <= 3'd1;//p1打中了球
                                end
                            else
                                begin
                                    score2 <= score2+1'b1;//p1没有打中球
                                    who <= 1;
                                    state <= 3'd0;
                                end                               
                        end
                        default:begin
                            score1 <= 4'b0;
                            score2 <= 4'b0;
                            start <= 0;
                            state <= 3'd0;
                        end
                endcase
            end
        end

always @(who)
begin
     if (who == 1)
     begin
     who1 = 0;
     end
     else if (who == 0)
     begin
     who1 = 1;
     end
end

endmodule
