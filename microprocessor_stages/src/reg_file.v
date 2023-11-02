module reg_file (clk,en,rst,opa,operand_b,rs1,rs2,rd,write);
 
 input wire clk;
 input wire rst;
 input wire en;
 input wire [4:0] rs1;
 input wire [4:0] rs2;
 input wire [4:0] rd;
 input wire [31:0] write;
 output wire [31:0] opa;
 output wire [31:0] operand_b;
 integer i;
 reg [31:0] register [31:0];
 always @(posedge clk or negedge rst ) begin
      register[0]<=32'b00000000000000000000000000000000;
        if(!rst)begin
            for(i=1;i<=31;i++)begin
                register[i]<=32'b00000000000000000000000000000000;
            end
        end
        else if(en) begin
              register[rd]<=write;  
            end
        end
    assign opa= (rs1) ? register[rs1] : 0;
    assign operand_b= (rs2) ? register[rs2] : 0; 
endmodule