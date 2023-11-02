
module core (
    input wire clk,
    input wire rst,
    //input wire data_mem_valid,
    //input wire instruc_mem_valid,
    input wire [31:0] instruction,
    input wire [31:0] load_data_in,

    output wire re_we,
    output wire request,
    output wire datamem_re_we,
    output wire data_mem_request,
    output wire [3:0]  mask_singal,
    output wire [3:0]  masking,
    output wire [31:0] store_dataout,
    output wire [31:0] alu_out_address,
    output wire [31:0] pc_address
    );

    wire [31:0] instruction_out;
    wire [31:0] pc_address_out;
    wire load;
    wire store;
    //wire next_sel;
    wire jal;
    wire jalr;
    wire branch_res;
    
    wire [3:0] mask;
    wire [3:0] alu_control;
    wire [1:0] mem_reg;
    wire [31:0] op_b;
    wire [31:0] opa_mux_out;
    wire [31:0] opb_mux_out;
    wire [31:0] alu_res_out;
    wire [31:0] adder_res;
    wire [31:0] wrap_load_out;
    wire [31:0] rd_wb_data;

 fetch u_fetch0(
        .clk(clk),//pc
        .rst(rst),
        .branch_add(alu_res_out),
        .branch_res(branch_res),
        .address_in(0),
        .address_out(pc_address_out),
        .jal(jal),
        .jalr(jalr),
        .jal_add(alu_res_out),
        .jalr_add(alu_res_out),
        .instruction(instruction_out),
        .instruction_fetch(instruction),
        .re_we(re_we),
        .mask(masking),
        .request(request)
 );
        assign pc_address = pc_address_out ;

 decode u_decode0(
        .clk(clk),
        .rst(rst),
        .instruction(instruction_out),
        .pc_address(pc_address_out),
        .rd_wb_data(rd_wb_data),
        .load(load),
        .store(store),
        //.next_sel(next_sel),
        .jal(jal),
        .jalr(jalr),
        .mem_reg(mem_reg),
        .branch_result(branch_res),
        .opb_data(op_b),
        .alu_control(alu_control),
        .opa_mux_out(opa_mux_out),
        .opb_mux_out(opb_mux_out)
 );
 execute u_execute0(
        .a(opa_mux_out),//alu
        .b(opb_mux_out),
        .pc_address(pc_address_out),
        .alu_control(alu_control),
        .alu_res_out(alu_res_out),
        .adder_res(adder_res)
 );
 memory u_memory0(
        .load(load),
        .store(store),
        .op_b(op_b),
        .instruction(instruction_out),
        .alu_out_address(alu_res_out),
        .wrap_load_in(load_data_in),
        .mask(mask),
        .re_we(datamem_re_we),
        .request(data_mem_request),
        .store_dataout(store_dataout),
        .wrap_load_out(wrap_load_out)
 );
     assign alu_out_address = alu_res_out ;
     assign mask_singal = mask ;

 writeback u_writeback0(
        .mem_reg(mem_reg),
        .alu_out(alu_res_out),
        .data_mem_out(wrap_load_out),
        .adder_res(adder_res),
        .rd_mux_out(rd_wb_data)
 );   
endmodule