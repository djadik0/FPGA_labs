`timescale 1ns / 1ps

module synchroniser_tb(

    );
    
    logic clk;
    logic reset;
    logic busyA_o;
    logic datA_i;
    logic datB_o;
    logic locked;
    logic [4:0]  counterA_o;
    
    top_synchroniser dut(
        .clk(clk),
        .reset(reset),
        .busyA_o(busyA_o),
        .datA_i(datA_i),
        .datB_o(datB_o),
        .locked(locked),
        .counterA_o(counterA_o)
    );
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;     
    end
    
    initial begin 
    
        datA_i = 0;
        reset = 1;
        #100;
        reset = 0;

        
        @(posedge locked)

        repeat (30) begin
            @(posedge dut.clkA_i);
            datA_i = 1'b1;
            @(posedge dut.clkA_i);
            datA_i = 1'b0;
            while (busyA_o == 1'b1) @(posedge dut.clkA_i);
        end
            
        #10;
        
        
        #300;
        
        $stop;
    end
    
endmodule
