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
output [7:0]ball;//ƹ����
input  wire p1;
input  wire p2;//ѡ�ִ����һ������
input  [7:0]div;//ʱ�ӷ�Ƶ��ѡ�񣬿�������
input  reset;//��λ��ť
output [3:0]b1;
output [3:0]b2;//����Ĵ���
output [3:0]score1;
output [3:0]score2;
output [3:0]s1;
output [3:0]s2;//��λѡ�ֵĴ�ȷ�
output who;
output who1;
input clk;//ʱ��

reg [3:0]score1;
reg [3:0]score2;//��λѡ�ֵ�С�ȷ�
reg [31:0]count;//��Ƶʹ�õļ�����
reg [7:0]ball;//ƹ����
reg reclk;//��Ƶ֮���ʱ��
reg [3:0]s1;
reg [3:0]s2;//����Ĵ���
reg [3:0]b1;
reg [3:0]b2;//��ȷ�
reg [31:0]temp;
reg who;//��־һ�¸�˭������
reg who1;
reg [2:0]state;//����ļ���״̬
reg start;//���ڱ����ı�־

always @(posedge clk or negedge reset)//����һ�������������ڷ�Ƶ
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

always @(posedge clk or negedge reset)//�����µ�ʱ���ź�
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
            if(!reset)//��ʼ��
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
                start<=1;//��Ϸ��ʼ
                    case(state)
                    
                        3'd0:begin//�ȴ�˫�������ж�ʤ��
                            ball <= 8'b00000000;//������ʼ״̬
                            if (score1 == 11 || score2 == 11)
                            begin
                                 start <= 0;
                            end
                        else
                                begin
                                    if(score1 != 0 && score1 % 5 == 0)//ÿ����֣���������Ȩ
                                        begin
                                            who <= 1;
                                        end
                                    if(score2 != 0 && score2 % 5 == 0)
                                        begin
                                            who <= 0;
                                        end
                                    if(who == 0 && p1 == 1)//p1����
                                        begin
                                            state <= 3'd1;//p1����׶�
                                        end
                                    else if(who == 1 && p2 == 1)//p2����
                                        begin
                                            state <= 3'd4;//p2����׶�
                                        end
                                    else
                                        state <= 3'd0;
                                end
                            end
                        3'd1:begin
                            if(ball == 8'b00000000)//p1����
                                begin
                                    ball <= 8'b00000001;
                                    s1 <= s1+1'b1;//ͳ��p1�������
                                    state <= 3'd2;
                                end
                            else//p1����
                                begin
                                    ball <= 8'b00000001;
                                    state <= 3'd2;
                                end
                        end
                        3'd2:begin
                            if(p2)
                                begin
                                    score1 <= score1+1'b1;//p1��һ��                                   
                                    who <= 0;                               
                                    state <= 3'd0;
                                end
                            else
                                begin                               
                                    if(ball == 8'b10000000)//�ж�p1�����״̬
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
                                    state <= 3'd4;//p2����ɹ�
                                end
                            else
                                begin
                                    score1 <= score1+1'b1;//p2���򲻳ɹ�,p1�÷�
                                    who <= 0;//��Ȩ�ƽ���p1
                                    state <= 3'd0;
                                end                               
                        end
                        
                        3'd4:begin//
                            if(ball <= 8'b00000000)//p2����
                                begin
                                    ball <= 8'b10000000;
                                    s2 <= s2 + 1'b1;//��¼p2�������
                                    state <= 3'd5;
                                end
                            else//p2�ӵ�����
                                begin
                                    ball <= 8'b10000000;
                                    state <= 3'd5;
                                end
                        end
                        
                        3'd5:begin//������
                            if(p1)
                                begin
                                    score2 <= score2+1'b1;//p2��һ��                                  
                                    who <= 1;//p2����                                 
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
                        3'd6:begin//p1���Ի���
                            if(p1 == 1)
                                begin
                                    state <= 3'd1;//p1��������
                                end
                            else
                                begin
                                    score2 <= score2+1'b1;//p1û�д�����
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
