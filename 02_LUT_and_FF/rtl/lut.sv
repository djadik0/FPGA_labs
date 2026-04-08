
module lut(
  input  logic [3:0] a,
  input  logic [3:0] b,
  input  logic [3:0] c,
  
  input  logic       clk,
  input  logic       reset,
  input  logic       CE,

  output logic [3:0] y
    );

  logic [3:0] lut_o;

  genvar i;
    generate
    for (i = 0; i < 4; i = i + 1) begin : GEN_LUT

    LUT3 #(
        .INIT(8'b01101001)
    ) LUT6_inst (
        .O   (lut_o[i]), 
        .I0  (a[i]), 
        .I1  (b[i]), 
        .I2  (c[i]) 
        );

    FDRE fdre_inst (
        .Q  (y[i]),
        .C  (clk),
        .CE (CE),
        .R  (reset), 
        .D  (lut_o[i])
    );

    end
    endgenerate


endmodule
