`timescale 1ns / 1ps

// module ram_design_db();

// reg clk;
// wire [4:0] datar1;
// reg [31:0] read_data1;
// wire [4:0] datar2;
// reg [31:0] read_data2;
// reg we;
// reg [31:0] addrw;
// reg [4:0] dataw;

// ram_design ram_test(
//   .clk(clk),
//   .raddr1(read_data1),
//   .rdata1(datar1),
//   .raddr2(read_data2),
//   .rdata2(datar2),
//   .we(we),
//   .waddr(addrw),
//   .wdata(dataw)
// );


// initial begin
//     we = 1;
//     clk = 0;
//     read_data1 = 32'h0000001;
//     read_data2 = 32'h0000023;
    
//     addrw = 32'h00000001;
//     dataw = 5'b00001;
//     #200;
//     addrw = 32'h00000023;
//     dataw = 5'b11111;
//     #200;
// end
// always #30  clk = ~clk;

// endmodule

module regfile_tb;

reg clk;
reg [4:0] raddr1, raddr2;
reg we;
reg [4:0] waddr;
reg [31:0] wdata;
reg cin;
reg [5:0] card;
wire [31:0] rdata1, rdata2,F;

ram_design regfile_inst (
    .clk(clk),
    .raddr1(raddr1),
    .rdata1(rdata1),
    .raddr2(raddr2),
    .rdata2(rdata2),
    .we(we),
    .waddr(waddr),
    .wdata(wdata)
);
alu uut (
        .A(rdata1),
        .B(rdata2),
        .Cin(cin),
        .Card(card),
        .F(F),
        .Cout(cout),
        .Zero(zero)
    );

// Clock generation
always #5 clk = ~clk;
initial begin
    cin=0;
    card = 2;
    clk = 0;
    raddr1 = 0;
    raddr2 = 0;
    we = 0;
    waddr = 0;
    wdata = 0;
    
    // Write operation
    we = 1;
    waddr = 2;
    wdata = 32'hAABBCCDD;
    #10
    we = 0;
    
    // Read operation
    raddr1 = 2;
    raddr2 = 4;
    #10
    
    // Write operation
    we = 1;
    waddr = 4;
    wdata = 32'h11223344;
    #10
    we = 0;
    
    #10
    // Read operation
    card = 2;
    raddr1 = 4;
    raddr2 = 2;
    #10

    #10
    we = 1;
    waddr = 5;
    wdata = F;
    #10
    raddr1=5;
    #10
    // Add more test cases if needed
    
    $finish; // End simulation
end

endmodule