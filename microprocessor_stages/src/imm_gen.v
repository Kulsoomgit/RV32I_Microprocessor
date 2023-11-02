module imm_gen (inst,i_type,store,branch_imm,jal_imm,u_imm);
    input wire[31:0] inst;
    output reg [31:0] i_type,store,branch_imm,jal_imm,u_imm;
    reg [11:0] i,s;

    always @(*)begin
      //i_type//load//jalr
      i= inst [31:20];
      i_type={{20{i[11]}},i};
      //store
      s [4:0] = inst [11:7];
      s [11:5] = inst  [31:25];
      store={{20{s[11]}},s}; 
      //branch
      branch_imm = {{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
      //jal
      jal_imm = {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
      //auips//lui
      u_imm = {{inst[31:12]},12'b0};
    end
endmodule