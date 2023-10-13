`timescale 1ns/1ps
module singlecycle_tb();
    reg clk;
    reg [31:0]instruc;
    reg rst;
    reg en;
    wire[31:0] res_o;

    singlecycle u_singlecycle(
        .clk(clk),
        .rst(rst),
        .en(en)
    );

    initial begin
        clk = 0;
        rst = 1;
           en = 0;
        #5;
        rst=0;
        en = 0;
        #10;

        rst = 1;
        en = 0;
        #100;
        #40;

        $finish;       
    end
     initial begin
       $dumpfile("singlecycle.vcd");
       $dumpvars(0,singlecycle_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule