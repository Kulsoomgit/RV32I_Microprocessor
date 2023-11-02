
module decode (
    input wire clk,
    input wire rst,
    //en
    input wire [31:0] instruction,
    input wire [31:0] pc_address,
    input wire [31:0] rd_wb_data,

    output wire load,
    output wire store,
    output wire branch,
    output wire jal,
    output wire jalr,
    output wire branch_result,
    output wire [3:0] alu_control,
    output wire [1:0]  mem_reg,
    output wire [31:0] opa_mux_out,
    output wire [31:0] opb_mux_out,
    output wire [31:0] opb_data
 );
   wire [31:0] op_a;
   wire [31:0] op_b;
   wire branch_en;
   wire [31:0]i_type;
   wire [31:0]branch_imm;
   wire [31:0]jal_imm;
   wire [31:0] store_imm;
   wire [31:0]u_imm;
   wire [2:0]imm_sel;
   wire mem_en;
   wire reg_write;
   wire operand_a;
   wire operand_b;
   wire en;
   wire write;
   wire rs1;
   wire rs2;
   wire out;
   wire [31:0]m1out;




    branch u_branch0(
        .op_a(op_a),
        .op_b(op_b),
        .res(branch_result),
        .branch_en(branch),
        .func3(instruction[14:12])
    );
    imm_gen u_imm_gen0(
        .inst(instruction),
        .i_type(i_type),
        .store(store_imm),
        .branch_imm(branch_imm),
        .jal_imm(jal_imm),
        .u_imm(u_imm)
    );
    ctrl_unit u_ctrl_unit0(
        .opcode(instruction[6:0]),
        .func3(instruction[14:12]),
        .func7(instruction[30]),
        .mem_reg(mem_reg),
        .imm_sel(imm_sel),
        .mem_en(mem_en),
        .reg_write(reg_write),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .l (load),
        .s (store),
        .sb (branch),
        .uj (jal),
        .jalr_i(jalr)
    );
    assign opb_data = op_b ;
    reg_file u_reg_file0(
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .write(rd_wb_data),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .opa(op_a),
        .operand_b(op_b),
        .rd(instruction[11:7])
    );
    mux u_mux1(
        .a(op_b),
        .b(m1out),
        .sel(operand_b),
        .out(opb_mux_out)
    );
    mux u_mux2(
        .a(op_a),
        .b(pc_address),
        .sel(operand_a),
        .out(opa_mux_out)
    );
    mux3_8 u_mux(
        .a(i_type),
        .b(store_imm),
        .c(branch_imm),
        .d(jal_imm),
        .e(u_imm),
        .sel(imm_sel),
        .out(m1out)
    );

endmodule
