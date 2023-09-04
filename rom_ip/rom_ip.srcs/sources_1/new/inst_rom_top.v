`timescale 1ns / 1ps


module ram_top(
    input         clk      ,
    input  [15:0] ram_addr ,
    output [31:0] ram_rdata
    );

wire [31:0] ram_wdata;
wire        ram_wen;

// Disabled
assign ram_wdata = 32'hffffffff;
assign ram_wen = 1'b0;

block_ram block_ram (
    .clka (clk       ),
    .wea  (ram_wen   ),
    .addra(ram_addr  ),
    .dina (ram_wdata ),
    .douta(ram_rdata ) 
);

endmodule
