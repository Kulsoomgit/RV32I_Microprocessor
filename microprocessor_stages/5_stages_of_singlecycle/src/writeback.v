
module writeback (
    input wire [31:0] alu_out,adder_res,data_mem_out,
    input wire [1:0] mem_reg,

    output wire [31:0] rd_mux_out);

    mux2_4 u_mux10(
        .a(alu_out),
        .b(data_mem_out),
        .c(adder_res),
        .sel(mem_reg),
        .out(rd_mux_out)
    );
endmodule