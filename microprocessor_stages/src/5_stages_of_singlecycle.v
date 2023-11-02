
module singlecycle (
    input wire clk,
    input wire enable,
    input wire rst,
    input wire [31:0]instruction
    );

    wire [31:0] instruction_out;
    wire [31:0] pc_address;
    wire [31:0] load_data_out;
    wire [31:0] alu_out_address;
    wire [31:0] store_dataout;
    wire [3:0]  mask;
    wire [3:0]  masking;
    wire re_we;
    wire request;
   // wire instruc_mem_valid;
   // wire data_mem_valid;
    wire datamem_re_we;
    wire data_mem_request;
    //wire store;


    main_mem u_instruc_mem(
        .clk(clk),
        .re_we(re_we),
        .request(request),
        .mask(masking),
        .address(pc_address[9:2]),
        .data_in(instruction),
        //.valid(instruc_mem_valid),
        .data_out(instruction_out)
    );


    core u_core(
        .clk(clk),
        .rst(rst),
        .instruction(instruction_out),
        .load_data_in(load_data_out),
        .mask_singal(mask),
        .masking(mask),
        .re_we(re_we),
        .request(request),
        .datamem_re_we(datamem_re_we),
        .data_mem_request(data_mem_request),
        //.instruc_mem_valid(instruc_mem_valid),
        //.data_mem_valid(data_mem_valid),
        .store_dataout(store_dataout),
        .pc_address(pc_address),
        .alu_out_address(alu_out_address)
    );



    main_mem u_datamem(
        .clk(clk),
        .re_we(datamem_re_we),
        .request(data_mem_request),
        .address(alu_out_address[9:2]),
        .data_in(store_dataout),
        .mask(mask),
        //.valid(data_mem_valid),
        .data_out(load_data_out)
    );
endmodule