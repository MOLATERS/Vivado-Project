`timescale 1ns / 1ps


module tb_top();

reg         clk;
reg         ram_wen;
reg  [15:0] ram_addr;
reg  [31:0] ram_wdata;
wire [31:0] ram_rdata;

reg [4:0] raddr1;//寄存器堆读地址1
wire [31:0] rdata1;//返回数据1
reg [4:0] raddr2;//寄存器堆读地址2
wire [31:0] rdata2;//返回数据2
reg we;//写使能
reg [4:0]waddr;//写地址
reg [31:0]wdata;//写数据

reg Cin;
reg [4:0] Card;
wire [31:0] F;
wire Cout;
wire Zero;

ram_top u_ram_top(
    .clk      (clk       ),
    .ram_wen  (ram_wen   ),
    .ram_addr (ram_addr  ),
    .ram_wdata(ram_wdata ),
    .ram_rdata(ram_rdata ) 
);

regfiles regfile(
	.clk(clk),
	.raddr1(raddr1),
	.rdata1(rdata1),
	.raddr2(raddr2),
	.rdata2(rdata2),
	.we(we),
	.waddr(waddr),
	.wdata(wdata)
);

alu alu_test(
	.A(rdata1),
	.B(rdata2),
	.Cin(Cin),
	.Card(Card),
	.F(F),
	.Cout(Cout),
	.Zero(Zero)
);

initial begin
    clk = 1'b1;
end
always #5 clk = ~clk;


initial 
begin
	we = 1;
	Card = 5'b00011;
	Cin = 0;
	raddr1 = 0;
	raddr2 = 0;
	ram_addr   = 16'd0;
	ram_wdata  = 32'd0;
	ram_wen    =  1'd0;
	
	$display("RAM Test Begin");

	//测试RAM的使能
	ram_wen    = 1'b0;
	ram_addr   = 16'hf0;
	ram_wdata  = 32'hffffffff;
	#20;

	//取出第一个数据并存在5'b00000地址
	ram_wen    = 1'b1;
	ram_addr   = 16'h01;
	ram_wdata  = 32'h11223344;
    #20;
	wdata = ram_rdata;
	waddr = 5'b00000;
	we = 1;
	#20;
	we = 0;

	//取出第二个存储器并存在5'b00001地址
	ram_addr   = 16'hf0;
	ram_wdata  = 32'h00000011;
    #20;
	wdata = ram_rdata;
	waddr = 5'b00001;
	we = 1;
	#20;
	we = 0;

	//读出指令
	raddr1 = 5'b00000;
	raddr2 = 5'b00001;

	//将结果写回内存
	ram_wdata  = F;
	ram_addr   = 16'hf1;
	#50;

	#100;
	$display("RAM Test Success");
	$finish;
end

endmodule

