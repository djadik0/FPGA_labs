`timescale 1ns / 1ps

module tb_syst_ws();

    logic       clk_i;
    logic       rst_i;
    logic [7:0] x1_i;
    logic [7:0] x2_i;
    logic [7:0] x3_i;
    logic [18:0] y1_o;
    logic [18:0] y2_o;

    syst_ws uut (
        .clk_i  (clk_i),
        .rst_i  (rst_i),
        .x1_i   (x1_i),
        .x2_i   (x2_i),
        .x3_i   (x3_i),
        .y1_o   (y1_o),
        .y2_o   (y2_o)
    );


    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;
    end


    initial begin
        rst_i = 1;
        x1_i = 0;
        x2_i = 0;
        x3_i = 0;
        
        #10;
        rst_i = 0;
        #10;
        

        #10;
        x1_i = 8'd1;  
        x2_i = 8'd2;  
        x3_i = 8'd3;  
       
       
        #10;
        x1_i = 8'd4;  
        x2_i = 8'd5;  
        x3_i = 8'd6;  
       
        
         #10;
        x1_i = 8'd7;  
        x2_i = 8'd8;  
        x3_i = 8'd9;  
        
         #10;
        x1_i = 0;
        x2_i = 0;
        x3_i = 0;
        

        #50;
        

         #10;
        x1_i = 8'd10;
        x2_i = 8'd11;
        x3_i = 8'd12;
        
         #10;
        x1_i = 8'd13;
        x2_i = 8'd14;
        x3_i = 8'd15;
        
         #10;
        x1_i = 0;
        x2_i = 0;
        x3_i = 0;
        
        #50;
        
        $stop;
    end


endmodule