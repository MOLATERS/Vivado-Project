`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/01 15:39:24
// Design Name: 
// Module Name: register_db
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


module register_db( );
    reg clk;
    reg [31:0] NPC;
    wire [31:0] out;
    NPC NPC_test(
        .rst(0),
        .clk(clk),
        .load(1),
        .NPCin(NPC),
        .NPCout(out)
    );

    initial begin
        clk=0;
        #20;
        NPC = 32'h00000000;
        #20;
        NPC = 32'h00000004;
        #20;
        NPC = 32'h00000000;    
    end

    always #5 begin
        clk = ~clk;
    end
endmodule
