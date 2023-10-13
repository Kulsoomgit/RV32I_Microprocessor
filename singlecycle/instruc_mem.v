module instruc_mem (clk,address,en,data_in,data_out);
    input wire clk;
    input wire en;
    input wire [7:0] address;
    input wire [31:0] data_in;
    output reg [31:0] data_out;

    reg [31:0] mem [0:255];

    initial begin 
        $readmemh("instruc.mem",mem);
    end
    always @ (posedge clk)begin 
        if (en)begin 
            mem [address] <= data_in;
        end
    end 
    always @ (*)begin 
        data_out = mem [address] ;
    end
endmodule
    