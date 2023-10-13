module wrappermem (datain,byteadd,func3,mem_en,dataout,masking,load,load_in,load_out);
input wire [31:0] datain;//rs2 value
input wire [1:0] byteadd;
input wire [2:0] func3;
input wire mem_en;
input wire load;
input wire [31:0] load_in;
output reg [31:0] dataout;
output reg [31:0] load_out;
output reg [3:0] masking;

always @(*) begin
    if (mem_en)begin  
        if (func3==3'b010) begin //sw
            masking=4'b1111;
            dataout=datain;
        end
        if (func3==3'b001)begin //sh
            case(byteadd)
            00:begin
                masking=4'b0011;
                dataout=datain;
            end
            10:begin
                masking=4'b0110;
                dataout={datain[31:24],datain[15:0],datain[7:0]};
            end
            01:begin
                masking=4'b1100;
                dataout={datain[15:0],datain[15:0]};
            end
            endcase
        end
        if (func3==3'b000)begin //sb
        case(byteadd)
            00:begin
            masking=4'b0001;
            dataout=datain;
        end
            10:begin
            masking=4'b0010;
            dataout={datain[31:16],datain[7:0],datain[7:0]};
        end
        01:begin
            masking=4'b0100;
            dataout={datain[31:24],datain[7:0],datain[15:0]};
        end
        11:begin
            masking=4'b1000;
            dataout={datain[7:0],datain[23:0]};
        end
        endcase 
        end
    end

    if(load)begin
            if (func3==3'b010)begin //lw
            load_out=load_in;
        end 
        if (func3==3'b001)begin //lh
            case(byteadd)
            00:begin
            load_out={{16{load_in[15]}},load_in[15:0]};
            end
            10:begin
                load_out={{16{load_in[23]}},load_in[23:8]};
            end
            01:begin
                load_out={{16{load_in[31]}},load_in[31:16]};
            end
            endcase
        end
        if (func3==3'b000)begin //lb
            case(byteadd)
            00:begin
                load_out={{24{load_in[7]}},load_in[7:0]};
            end
            10:begin
                load_out={{24{load_in[15]}},load_in[15:8]};
            end
            01:begin
                load_out={{24{load_in[23]}},load_in[23:16]};
            end
            11:begin
                load_out={{24{load_in[31]}},load_in[31:24]};
            end
            endcase
        
        if(func3==3'b101)begin //lhu
        case(byteadd)
            00:begin
            load_out={16'b0,load_in[15:0]};
            end
            10:begin
                load_out={16'b0,load_in[23:8]};
            end
            01:begin
                load_out={16'b0,load_in[31:16]};
            end
            endcase 
        end
        if(func3==3'b100)begin //lbu
            case(byteadd)
            00:begin
                load_out={24'b0,load_in[7:0]};
            end
            10:begin
                load_out={24'b0,load_in[15:8]};
            end
            01:begin
                load_out={24'b0,load_in[23:16]};
            end
            11:begin
                load_out={24'b0,load_in[31:24]};
            end
            endcase 
            end
            end
    end
        
    end
 endmodule