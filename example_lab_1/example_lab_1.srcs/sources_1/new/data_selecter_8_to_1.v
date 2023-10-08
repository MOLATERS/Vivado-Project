`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/03 10:48:34
// Design Name: 
// Module Name: data_selecter_8_to_1
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

module data_selecter_8_to_1(
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [31:0] data4,
    input [31:0] data5,
    input [31:0] data6,
    input [31:0] data7,
    input [31:0] data8,
    input [2:0] select,
    output wire [31:0] data_chosen
);

    assign data_chosen = (select == 3'b000) ? data1 :
                         (select == 3'b001) ? data2 :
                         (select == 3'b010) ? data3 :
                         (select == 3'b011) ? data4 :
                         (select == 3'b100) ? data5 :
                         (select == 3'b101) ? data6 :
                         (select == 3'b110) ? data7 :
                         data8;

endmodule
