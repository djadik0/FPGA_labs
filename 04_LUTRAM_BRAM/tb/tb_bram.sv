`timescale 1ns / 1ps

 
module tb_bram();

    parameter RAM_WIDTH = 8;
    parameter RAM_ADDR_BITS = 4;  
    

    logic clk_i;
    logic [RAM_ADDR_BITS-1:0] addr_a_i;
    logic [RAM_ADDR_BITS-1:0] addr_b_i;
    logic [RAM_WIDTH-1:0]     data_a_i;
    logic [RAM_WIDTH-1:0]     data_b_i;
    logic                      we_a_i;
    logic                      we_b_i;
    logic                      en_a_i;
    logic                      en_b_i;
    logic [RAM_WIDTH-1:0]      data_a_o;
    logic [RAM_WIDTH-1:0]      data_b_o;
    
    
         bram_dp_true_1clk #(
        .RAM_WIDTH(8),
        .RAM_ADDR_BITS(4)
    ) uut (
        .*  
    );
    
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end
     
     initial begin
        addr_a_i = 0;
        addr_b_i = 0;
        data_a_i = 0;
        data_b_i = 0;
        we_a_i = 0;
        we_b_i = 0;
        en_a_i = 0;
        en_b_i = 0;
        
        #20;
        
        addr_a_i = 5;
        data_a_i = 8'hAA;
        we_a_i = 1;
        en_a_i = 1;
        
        @(posedge clk_i);
        #10;
        
        
        addr_b_i = 10;
        data_b_i = 8'hBB;
        we_b_i = 1;
        en_b_i = 1;
        en_a_i = 0;
        
        @(posedge clk_i);
        #10;
    
         we_a_i = 0;
        we_b_i = 0;
        en_a_i = 1;
        en_b_i = 1;
        addr_a_i = 5;
        addr_b_i = 10;
        
        @(posedge clk_i);
        #10;
        
        #100;
        $stop;
    
    end 
     
endmodule
