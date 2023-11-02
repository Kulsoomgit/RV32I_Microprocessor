module adder (a,res);
    input wire [31:0] a;
    output reg [31:0] res;
    always @(*) begin
     res = a+4;   
    end
endmodule