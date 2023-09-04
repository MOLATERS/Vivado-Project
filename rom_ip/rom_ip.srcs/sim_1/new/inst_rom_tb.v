`timescale 1ns / 1ps


module tb_top();

reg         clk;
reg  [15:0] ram_addr;
wire [31:0] ram_rdata;


ram_top u_ram_top(
    .clk      (clk       ),
    .ram_addr (ram_addr  ),
    .ram_rdata(ram_rdata ) 
);


initial 
begin
    clk = 1'b1;
end
always #5 clk = ~clk;


initial 
begin
	ram_addr   = 16'd0;
	#100;
	
	$display("RAM Test Begin");
	
	#10;
	ram_addr   = 16'h0;

    #10;
	ram_addr   = 16'h1;

    #10;
	ram_addr   = 16'h2;

	#10;
	ram_addr   = 16'h3;
    
    #10;
	ram_addr   = 16'h4;

    #10;
	ram_addr   = 16'h5;

	#10;
	ram_addr   = 16'h6;
    
    #10;
	ram_addr   = 16'h7;

	#100;
	$display("RAM Test Success");
	$finish;
end

endmodule
