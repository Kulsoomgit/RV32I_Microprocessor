`timescale 1ns/1ps
module singlecycle_tb();
    reg clk;
    reg [31:0]instruc;
    reg rst;
    wire[31:0] res_o;

    singlecycle u_5_stages_of_singlecycle (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk = 0;
        rst = 1;

        #10;
        rst=0;

        #10;
        rst = 1;

        #140;

       $finish;       
    end
     initial begin
       $dumpfile("temp/microprocessor.vcd");
       $dumpvars(0,singlecycle_tb);
    end

    always begin
        #5 clk= ~clk;
    end
endmodule