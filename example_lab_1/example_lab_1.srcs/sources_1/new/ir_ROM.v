`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 10:29:17
// Design Name: 
// Module Name: ir_ROM
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

//`define INS_FILE_PATH "C:\\Users\\water_boy\\lab1_env_new\\lab_1\\lab_1.data\\base_inst_data"
// `define INS_FILE_PATH "C:\\Users\\water_boy\\lab1_env_new\\lab_1\\lab_1.data\\additional_inst_data1"
`define INS_FILE_PATH "E:\\Xlinx_project\\lab_1\\lab_1.data\\base_inst_data"
// `define INS_FILE_PATH "E:\\Xlinx_project\\lab_1\\lab_1.data\\additional_inst_data1"

module ir_ROM(
    input  [7:0]  ir_rom_addr ,
    output [31:0] ir_rom_rdata
);

    wire [7:0] addr;
    assign addr = ir_rom_addr>>2;
    reg [31:0] ir_rom [0:255];
    initial begin
    $readmemh(`INS_FILE_PATH , ir_rom);
    end
    assign ir_rom_rdata = ir_rom[addr];

endmodule
