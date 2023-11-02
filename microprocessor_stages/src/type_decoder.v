module type_decoder (opcode,r_type,i_type,store,load,branch,jal,jalr,auipc,lui);
    input wire [6:0] opcode;

    output reg r_type;
    output reg i_type;
    output reg store;
    output reg load;
    output reg branch;
    output reg jal;
    output reg jalr;
    output reg auipc;
    output reg lui;

    always @ (*) begin
        case(opcode)
            7'b0110011:begin //r_type
                r_type = 1;
                i_type = 0;
                store = 0;
                load = 0;
                branch = 0; 
                jal = 0;
                jalr = 0;
                auipc = 0;
                lui = 0;
                
            end
            7'b0010011:begin //i_type
                r_type = 0;
                i_type = 1;
                store = 0;
                load = 0;
                branch = 0; 
                jal = 0;
                jalr = 0;
                auipc = 0;
                lui = 0;
            
            end
            7'b0100011:begin //store
                r_type = 0;
                i_type = 0;
                store = 1;
                load = 0;
                branch = 0; 
                jal = 0;
                jalr = 0;
                auipc = 0;
                lui = 0;
                
            end   
            7'b0000011:begin //load
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 1; 
                branch = 0;
                jal = 0;
                jalr = 0; 
                auipc = 0;
                lui = 0;
            end 
            7'b1100011:begin //branch
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 1;
                jal = 0;
                jalr = 0;
                auipc = 0;
                lui = 0;
            end
            7'b1100111:begin //jalr
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 0;
                jal = 0;
                jalr = 1;
                auipc = 0;
                lui = 0;
            end
            7'b1101111:begin //jal
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 0;
                jal = 1;
                jalr = 0;
                auipc = 0;
                lui = 0;
            end
            7'b0010111:begin //auipc
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 0;
                jal = 0;
                jalr = 0;
                auipc = 1;
                lui = 0;
            end
            7'b0110111:begin //lui
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 0;
                jal = 0;
                jalr = 0;
                auipc = 0;
                lui = 1;
            end
           default: begin
                r_type = 0;
                i_type = 0;
                store = 0;
                load = 0; 
                branch = 0;  
                jal = 0;
                jalr = 0; 
                auipc = 0;
                lui = 0;             
            end
        endcase
    end
endmodule