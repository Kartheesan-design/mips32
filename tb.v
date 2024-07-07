`timescale 1ns / 1ps

module tb();

    reg clk1,clk2;
    wire [31:0] PC,IF_ID_IR,IF_ID_NPC;
    wire [31:0] ID_EX_IR,ID_EX_NPC,ID_EX_A,ID_EX_B,ID_EX_Imm;
    wire [2:0] ID_EX_type,EX_MEM_type,MEM_WB_type;
    wire [31:0] EX_MEM_IR,EX_MEM_ALUOut,EX_MEM_B;
    wire EX_MEM_cond;
    wire [31:0] MEM_WB_IR,MEM_WB_ALUOut,MEM_WB_LMD;
    integer k;
    
    mips32 mips(clk1,clk2);
    
    initial
        begin
        clk1 = 0;clk2 = 0;
            repeat(20)
                begin
                    #5 clk1 = 1;#5 clk1 = 0;
                    #5 clk2 = 1;#5 clk2 = 0;
                 end 
        end
                   
    initial 
        begin
            for(k=0;k<31;k=k+1)
                mips.Reg[k] = k;
                
            mips.Mem[0] = 32'h2801000a;
            mips.Mem[1] = 32'h28020014;
            mips.Mem[2] = 32'h28030019;
            mips.Mem[3] = 32'h0ce77800;
            mips.Mem[4] = 32'h0ce77800;
            mips.Mem[5] = 32'h00222000;
            mips.Mem[6] = 32'h0ce77800;
            mips.Mem[7] = 32'h00832800;
            mips.Mem[8] = 32'hfc000000;
            
            mips.HALTED = 0;
            mips.PC =  0;
            mips.TAKEN_BRANCH = 0;
            
            #280
            for(k=0;k<6;k=k+1)
                $display("R%1d -  %2d",k,mips.Reg[k]);
            
        end
        
        
    initial 
        begin
            #300 $finish;
        end     
            
endmodule
