module pc (clk,rst,branch,branch_add,branch_res,address_in,jal_add,jal,jalr,jalr_add,auipc_add,auipc,address_out);
    input wire clk,rst,branch,branch_res,jal,jalr,auipc;
    input wire [31:0] address_in;
    input wire [31:0] branch_add,jalr_add,jal_add,auipc_add;

    output reg [31:0] address_out;

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin 
            address_out <= 0;
        end
        else if(branch && branch_res)begin
            address_out <= branch_add;
        end
        else if(jal)begin
            address_out <= jal_add;
        end
        else if (jalr)begin
            address_out <= jalr_add;
        end
        else if (auipc)begin
            address_out <= auipc_add;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
    end
endmodule