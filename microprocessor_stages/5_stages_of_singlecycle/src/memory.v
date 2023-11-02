
module memory (
    input wire load,
    input wire store,
    input wire [31:0] op_b,
    input wire [31:0] alu_out_address,
    input wire [31:0] instruction,
    input wire [31:0] wrap_load_in,

    output reg re_we,
    output reg request,
    output wire [3:0]  mask,
    output wire [31:0] store_dataout,
    output wire [31:0] wrap_load_out
);
  wrappermem u_wrappermem0(
        .datain(op_b),
        .byteadd(alu_out_address [1:0]),
        .func3(instruction [14:12]),
        .mem_en(store),
        .load(load),
        .load_in(wrap_load_in),
        .dataout(store_dataout),
        .load_out(wrap_load_out),
        .mask(mask)
    );
    always @ (*) begin
        request = load | store ;
        re_we = store ;
    end
    
endmodule