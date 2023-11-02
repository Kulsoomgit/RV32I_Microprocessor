
module fetch (
    input wire clk,rst,branch_res,jal,jalr,
    input wire [31:0] address_in,
    input wire [31:0] branch_add,jalr_add,jal_add,
    input wire [31:0] instruction_fetch,
    
    output wire [3:0] mask,
    output wire request,
    output wire re_we,
    output reg [31:0]instruction,
    output wire [31:0] address_out
    );

     pc u_pc0(
        .clk(clk),
        .rst(rst),
        .branch_add(branch_add),
        .branch_res(branch_res),
        .address_in(address_in),
        .address_out(address_out),
        .jal(jal),
        .jalr(jalr),
        .jal_add(jal_add),
        .jalr_add(jalr_add)
        );

        assign mask =4'b1111;
        assign request = 1'b1;
        assign re_we = 0;
        
        always @ (*) begin 
        instruction = instruction_fetch ;
       end
endmodule