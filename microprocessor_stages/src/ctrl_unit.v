
module ctrl_unit (opcode,func3,func7,operand_a,reg_write,mem_reg,imm_sel,uj,jalr_i,u_aui,u_lui,mem_en,s,l,operand_b,alu_control,sb);
input wire [6:0] opcode;
input wire  [2:0]func3;
input wire func7;

output wire reg_write;
output wire operand_b;
output wire [3:0]alu_control;
output wire [1:0]mem_reg;
output wire s;
output wire l;
output wire mem_en;
output wire [2:0] imm_sel;
output wire sb;
output wire operand_a;
output wire uj;
output wire jalr_i;
output wire u_aui;
output wire u_lui;


wire r_type;
wire i_type;
wire store;
wire load;
wire branch;
wire jal;
wire jalr;
wire auipc;
wire lui;

type_decoder u_type_decoder0 (
    .opcode (opcode),
    .r_type (r_type),
    .i_type (i_type),
    .load   (load),
    .store   (store),
    .branch (branch),
    .jal    (jal),
    .jalr    (jalr),
    .auipc   (auipc),
    .lui     (lui)
);

control_decoder u_control_decoder0(
    .r_type (r_type),
    .i_type (i_type),
    .load   (load),
    .store  (store),
    .func3 (func3),
    .func7 (func7),
    .mem_reg (mem_reg),
    .s(s),
    .l(l),
    .operand_a(operand_a),
    .branch(branch),
    .sb(sb),
    .jal(jal),
    .jalr(jalr),
    .uj(uj),
    .jalr_i(jalr_i),
    .auipc(auipc),
    .lui(lui),
    .u_aui(u_aui),
    .u_lui(u_lui),
    .imm_sel (imm_sel),
    .mem_en (mem_en),
    .reg_write(reg_write),
    .operand_b(operand_b),
    .alu_control(alu_control)
);

endmodule