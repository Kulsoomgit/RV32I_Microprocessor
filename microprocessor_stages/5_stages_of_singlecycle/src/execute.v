
module execute (
     input wire [31:0] a,
     input wire [31:0] b,
     input wire  [3:0] alu_control,
     input wire [31:0] pc_address,
     
     output wire [31:0] alu_res_out,
     output wire [31:0] adder_res
     );
     
     alu u_alu0(
        .a(a),
        .b(b),
        .op(alu_control),
        .res_o(alu_res_out)
     );
     adder u_adder0(
        .a(pc_address),
        .res(adder_res)
     );
    
endmodule