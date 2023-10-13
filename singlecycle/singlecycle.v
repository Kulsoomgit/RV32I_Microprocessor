`include "alu.v"
`include "mux.v"
`include "ctrl_unit.v"
`include "imm_gen.v"
`include "instruc_mem.v"
`include "adder.v"
`include "pc.v"
`include "reg_file.v"
`include "datamem.v"
`include "wrappermem.v"
`include "branch.v"
`include "mux3_8.v"
`include "mux2_4.v"
module singlecycle (clk,rst,en,in);
    input wire clk;
    input wire rst;
    input wire en;
    input wire [31:0]in;

    
    wire [31:0]data_out;
    wire [31:0]i_type;
    wire [31:0]s_type;
    wire [31:0]sb_type;
    wire [31:0]uj_type;
    wire [31:0]u_type;
    wire jal;
    wire jalr;
    wire auipc;
    wire reg_write;
    wire [1:0]mem_reg;
    wire mem_en;
    wire [2:0] imm_sel;
    wire load;
    wire store;
    wire [3:0]mask;
    wire [3:0]wmask;
    wire [31:0]wr_out;
    wire [31:0]wr_in;
    wire [31:0] wlout;
    wire operand_b;
    wire [31:0]address_in;
    wire [31:0]address_out;
    wire [3:0]alu_control;
    wire [31:0] op_a,op_b;
    wire [31:0] res_o;
    wire [31:0] out;
    wire [31:0] m1out;
    wire [31:0] m2out;
    wire branch_en;
    wire branch_res;
    wire [31:0] m3out;
    wire operand_a;
    wire [31:0] res;

    pc u_pc0(
        .clk(clk),
        .rst(rst),
        .branch(branch_en),
        .branch_add(res_o),
        .branch_res(branch_res),
        .address_in(address_in),
        .address_out(address_out),
        .jal(jal),
        .jalr(jalr_i),
        .jal_add(res_o),
        .jalr_add(res_o),
        .auipc(auipc),
        .auipc_add(res_o)
    );
    adder u_adder0(
        .a(address_out),
        .res(res)
    );
    instruc_mem u_instruc_mem0(
        .clk(clk),
        .en(en),
        .address(address_out[9:2]),
        .data_in(in),
        .data_out(data_out)
    );

    imm_gen u_imm_gen0(
        .inst(data_out),
        .i_type(i_type),
        .store(s_type),
        .branch_imm(sb_type),
        .jal_imm(uj_type),
        .u_imm(u_type)
    );

    ctrl_unit u_ctrl_unit0(
        .opcode(data_out[6:0]),
        .func3(data_out[14:12]),
        .func7(data_out[30]),
        .mem_reg(mem_reg),
        .imm_sel(imm_sel),
        .mem_en(mem_en),
        .reg_write(reg_write),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .alu_control(alu_control),
        .l (load),
        .s (store),
        .sb (branch_en),
        .uj (jal),
        .jalr_i(jalr_i),
        .u_aui(),
        .u_lui()
    );
    reg_file u_reg_file0(
        .clk(clk),
        .rst(rst),
        .en(reg_write),
        .write(m2out),
        .rs1(data_out[19:15]),
        .rs2(data_out[24:20]),
        .opa(op_a),
        .operand_b(op_b),
        .rd(data_out[11:7])
    );

    mux u_mux0(
        .a(op_b),
        .b(m1out),
        .sel(operand_b),
        .out(out)
    );
    mux3_8 u_mux1(
        .a(i_type),
        .b(s_type),
        .c(sb_type),
        .d(uj_type),
        .e(u_type),
        .sel(imm_sel),
        .out(m1out)
    );
    mux2_4 u_mux10(
        .a(res_o),
        .b(wlout),
        .c(res),
        .sel(mem_reg),
        .out(m2out)
    );
    mux u_mux3(
        .a(op_a),
        .b(address_out),
        .sel(operand_a),
        .out(m3out)
    );
    
    alu u_alu0(
        .a(m3out),
        .b(out),
        .op(alu_control),
        .res_o(res_o)
    );
    wrappermem u_wrappermem0(
        .datain(op_b),
        .byteadd(res_o[1:0]),
        .func3(data_out[14:12]),
        .mem_en(mem_en),
        .load(load),
        .load_in(wr_in),
        .dataout(wr_out),
        .load_out(wlout),
        .masking(wmask)
    );
    datamem u_datamem0(
        .clk(clk),
        .mem_en(mem_en),
        .address(res_o[9:2]),
        .mask(wmask),
        .datain(wr_out),
        .dataout(wr_in)
    );
    branch u_branch0(
        .op_a(op_a),
        .op_b(op_b),
        .res(branch_res),
        .branch_en(branch_en),
        .func3(data_out[14:12])
    );
endmodule




