`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/02 12:31:54
// Design Name: 
// Module Name: data_ram
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


//`define DATA_FILE_PATH "C:\\Users\\water_boy\\lab1_env_new\\lab_1\\lab_1.data\\base_data_data"
//`define DATA_FILE_PATH "C:\\Users\\water_boy\\lab1_env_new\\lab_1\\lab_1.data\\additional_data_data1"
// `define DATA_FILE_PATH "E:\\Xlinx_project\\lab_1\\lab_1.data\\base_data_data"
`define DATA_FILE_PATH "E:\\Xlinx_project\\lab_1\\lab_1.data\\additional_data_data1"

module data_ram(
    input         clk      ,
    input  [7:0]  data_ram_addr ,
    input  [31:0] data_ram_wdata,
    input         data_ram_wen  ,
    output [31:0] data_ram_rdata
);
    wire [7:0] addr;

    assign addr = data_ram_addr >> 2 ;
    reg [31:0] data_ram [0:255];
    initial begin
    $readmemh(`DATA_FILE_PATH , data_ram);
    end
    always @(posedge clk) begin
        if(data_ram_wen) data_ram[addr] <= data_ram_wdata;
    end
    assign data_ram_rdata = data_ram[addr];

endmodule
