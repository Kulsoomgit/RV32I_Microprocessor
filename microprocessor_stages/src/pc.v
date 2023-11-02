module pc (clk,rst,branch_add,branch_res,address_in,jal_add,jal,jalr,jalr_add,address_out);
    input wire clk,rst,branch_res,jal,jalr;
    input wire [31:0] address_in;
    input wire [31:0] branch_add,jalr_add,jal_add;

    output reg [31:0] address_out;

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin 
            address_out <= 0;
        end
        else if(branch_res)begin
            address_out <= branch_add;
        end
        else if(jal)begin
            address_out <= jal_add;
        end
        else if (jalr)begin
            address_out <= jalr_add;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
    end
endmodule