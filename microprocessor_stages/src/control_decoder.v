module control_decoder (func3,func7,r_type,i_type,store,branch,load,jal,uj,auipc,lui,u_aui,u_lui,jalr,jalr_i,mem_reg,reg_write,s,l,mem_en,operand_b,imm_sel,alu_control,sb,operand_a);
    input wire r_type;
    input wire i_type;
    input wire store;
    input wire load;
    input wire [2:0] func3;
    input wire func7;
    input wire branch;
    input wire jal;
    input wire jalr;
    input wire auipc;
    input wire lui;


    output reg [1:0]mem_reg;
    output reg reg_write;
    output reg s;
    output reg l;
    output reg sb;
    output reg uj;
    output reg jalr_i;
    output reg u_aui;
    output reg u_lui;
    output reg mem_en;
    output reg operand_b;
    output reg operand_a;
    output reg [2:0] imm_sel;
    output reg [3:0] alu_control;

    always @ (*) begin 
        //register write
        reg_write = r_type | i_type | load | jal | jalr | auipc | lui;
        //store signal
        s = store;
        // load signal
        l=load;
        //branch signal
        sb=branch;
        //jal signal
        uj=jal;
        //jalr signal
        jalr_i=jalr;
        //auipc signal
        u_aui=auipc;
        //lui signal
        u_lui=lui;
        //operand b
        operand_b = i_type | store | load | branch | jal | jalr | auipc | lui;
        //operand a
        operand_a = branch | jal | auipc;
        //alu controller
        if (r_type) begin 
            operand_b = 0;
            //mem_reg loading
            mem_reg = 2'b00;
            if (func7) begin 
                case (func3)
                    3'b000: alu_control = 4'b0001;
                    3'b101: alu_control = 4'b0111;
                endcase
            end
            else begin
                case (func3)
                    3'b000: alu_control = 4'b0000;
                    3'b001: alu_control = 4'b0010;
                    3'b010: alu_control = 4'b0011;
                    3'b011: alu_control = 4'b0100;
                    3'b100: alu_control = 4'b0101;
                    3'b101: alu_control = 4'b0110;
                    3'b110: alu_control = 4'b1000;
                    3'b111: alu_control = 4'b1001;
                endcase
            end
        end
        if (i_type) begin 
            imm_sel = 3'b000; // immediate selection
            //mem_reg loading
            mem_reg = 2'b00;
            if (func7) begin 
                case (func3)
                    3'b101: alu_control = 4'b0111;
                endcase
            end
            else begin
                case (func3)
                    3'b000: alu_control = 4'b0000;
                    3'b001: alu_control = 4'b0010;
                    3'b010: alu_control = 4'b0011;
                    3'b011: alu_control = 4'b0100;
                    3'b100: alu_control = 4'b0101;
                    3'b101: alu_control = 4'b0110;
                    3'b110: alu_control = 4'b1000;
                    3'b111: alu_control = 4'b1001;
                endcase
            end
        end
         mem_en=store;
        if (store) begin
            imm_sel= 3'b001;
            //mem_reg loading
            mem_reg = 2'b00;
            case (func3) 
                3'b000: alu_control = 4'b0000;
                3'b001: alu_control = 4'b0000;
                3'b010: alu_control = 4'b0000;
                3'b011: alu_control = 4'b0000;
            endcase
        end
        if (load) begin
            imm_sel=3'b000;
            //mem_reg loading
            mem_reg = 2'b01;
            case (func3)
            3'b000: alu_control = 4'b0000;
            3'b001: alu_control = 4'b0000; 
            3'b010: alu_control = 4'b0000;
            3'b100: alu_control = 4'b0000;
            3'b101: alu_control = 4'b0000; 
            endcase
        end
        if (branch) begin
            imm_sel = 3'b010;
            //mem_reg loading
            mem_reg = 2'b00;
            alu_control = 4'b0000;
        end
        if (jal) begin
            imm_sel = 3'b011;
            //mem_reg loading
            mem_reg = 2'b10;
            alu_control = 4'b0000;
        end
        if (jalr) begin
            imm_sel = 3'b000;
            //mem_reg loading
            mem_reg = 2'b00;
            alu_control = 4'b0000;
        end
        if (auipc) begin
            imm_sel = 3'b100;
            //mem_reg loading
            mem_reg = 2'b00;
            alu_control = 4'b0000;
        end
        if (lui) begin
            imm_sel = 3'b100;
            //mem_reg loading
            mem_reg = 2'b00;
            
        end
    end

endmodule