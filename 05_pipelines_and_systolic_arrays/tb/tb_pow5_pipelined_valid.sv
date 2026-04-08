`timescale 1ns / 1ps

module tb_pow5_pipelined_valid();

    parameter DATA_WIDTH = 8;

    logic                      clk_i;
    logic                      rst_i;
    logic [DATA_WIDTH-1:0]     pow_data_i;
    logic                      data_valid_i;
    logic [(5*DATA_WIDTH)-1:0] pow_data_o;
    logic                      data_valid_o;


    pow5_pipelined_valid #(
        .DATA_WIDTH(DATA_WIDTH)
    ) uut (
        .*
    );


    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end
     

    initial begin
        rst_i = 1;
        pow_data_i = 0;
        data_valid_i = 0;
        
        #10;
        rst_i = 0;
        #10;
        
        
        #10;
        data_valid_i = 1;
        pow_data_i   = 8'd0; 
        #10;
        data_valid_i = 0;
#50;
        
        data_valid_i = 1;
        
        #10;

        @(posedge clk_i);
        pow_data_i = 8'd2; 

 
        @(posedge clk_i);
        pow_data_i = 8'd3; 
       
        @(posedge clk_i);
        pow_data_i = 8'd4;  
   
 
        @(posedge clk_i);
        data_valid_i = 0;
        
        #20;
        

        @(posedge clk_i);
        pow_data_i = 8'd5;
        data_valid_i = 0;

        @(posedge clk_i);
        pow_data_i = 8'd6;

        @(posedge clk_i);
        pow_data_i = 8'd7;

        #20;
        
        data_valid_i = 1;
        
        #10;
        
        @(posedge clk_i);
        pow_data_i = 8'd5;  


        @(posedge clk_i);
        pow_data_i = 8'd6;  

        @(posedge clk_i);
        pow_data_i = 8'd7;  

        @(posedge clk_i);
        data_valid_i = 0;
        
        #20;

        $stop;
    end


endmodule