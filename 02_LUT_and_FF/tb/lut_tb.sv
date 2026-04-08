`timescale 1ns / 1ps

module LUT3 #(
    parameter INIT = 8'h00
) (
    output O,
    input I0,
    input I1,
    input I2
);
    wire [2:0] addr = {I2, I1, I0};
    assign O = INIT[addr];
endmodule

module FDRE (
    output reg Q,
    input C,
    input CE,
    input R,
    input D
);

always @(posedge C) begin
        if (R) Q <= 1'b0;
        else if (CE) Q <= D;
    end
endmodule


module lut_tb;


    logic [3:0] a;
    logic [3:0] b;
    logic [3:0] c;

    logic clk;
    logic reset;
    logic CE;

    logic [3:0] y;

    lut dut (
        .a(a),
        .b(b),
        .c(c),
        .clk(clk),
        .reset(reset),
        .CE(CE),
        .y(y)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin

        a     = 0;
        b     = 0;
        c     = 0;
        CE    = 0;
        reset = 1;


        #12;
        reset = 0;   
        CE    = 1;

        a = 4'b0000;
        b = 4'b0000;
        c = 4'b0000;
        #30;


        a = 4'b1010;
        b = 4'b0101;
        c = 4'b0011;
        #30;


        CE = 0;
        a  = 4'b1111;
        b  = 4'b1111;
        c  = 4'b1111;
        #30;


        CE = 1;
        #10;

        #20;
        $finish;
    end

endmodule
