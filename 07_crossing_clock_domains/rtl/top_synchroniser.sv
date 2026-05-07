
module top_synchroniser(
    input  logic clk,
    input  logic reset,
    output logic busyA_o,
    input  logic datA_i,
    output logic datB_o,
    output logic locked,
    output logic [4:0]  counterA_o
    );
    
    logic rst;
    assign rst = reset | ~locked; 
    logic clkA_i;
    logic clkB_i;
    
    clk_wiz_0  clk_wiz(
        .clk_outA(clkA_i),
        .clk_outB(clkB_i),
        .reset(reset),
        .locked(locked),
        .clk_in1(clk)
    );
    
    synchroniser_flag_busy synchroniser(
        .clkA_i(clkA_i),
        .reset(rst),
        .busyA_o(busyA_o),
        .clkB_i(clkB_i),
        .datA_i(datA_i),
        .datB_o(datB_o),
        .counterA_o(counterA_o)
        );


endmodule
