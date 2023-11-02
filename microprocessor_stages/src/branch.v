module branch(op_a,op_b,res,branch_en,func3); 
input wire [31:0]op_a;
input wire [31:0]op_b;
input wire branch_en;
input wire [2:0]func3;
output reg res;

always @(*) begin
    if(branch_en)begin
        case (func3)
                    3'b000: res = (op_a == op_b)? 1:0; //beq
                    3'b001: res = (op_a != op_b)? 1:0; //bne
                    3'b100: res = ($signed(op_a) < $signed(op_b))? 1:0; //blt
                    3'b101: res = ($signed(op_a) >= $signed(op_b))? 1:0; //bge
                    3'b110: res = (op_a < op_b)? 1:0; //bltu
                    3'b111: res = (op_a >= op_b)? 1:0; //bgeu 
                    default : begin 
                        res = 0;
                    end
        endcase
    end
end
endmodule