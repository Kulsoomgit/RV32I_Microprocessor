module mux2_4 (a,b,c,d,sel,out);
    input wire [31:0] a,b,c,d;
    input wire [1:0] sel;

    output reg [31:0] out;

    always @ (*) begin
        
        case (sel)
            3'b00 : out = a;
            3'b01 : out = b;
            3'b10 : out = c;
            3'b11 : out = d;
            endcase
    end
endmodule