// g(x)=x^16+x^12+x^5+1

module wrapper_crc16#(
  parameter width = 16
)
(
  input  logic        p_clk_i,
  input  logic        p_rstn_i,
  input  logic [31:0] p_dat_i,
  output logic [31:0] p_dat_o,
  input  logic        p_sel_i,
  input  logic        p_enable_i,
  input  logic        p_we_i,
  input  logic [31:0] p_adr_i,
  output logic        p_ready,
  output logic        p_slverr
);

  logic [31:0] control_reg;
  logic [width-1:0] din_i;
  logic [width-1:0] crc_o;
  logic [1:0] state;
  logic       crc_rd;
  logic       data_valid_i;

  assign p_slverr = 1'b0;
  
  logic [width-1:0] crc_o_0;
  logic [7:0] crc_o_1;
  logic [1:0] state_0;
  logic [1:0] state_1;
  
  assign crc_o = control_reg[0] ? {8'd0, crc_o_1} : crc_o_0;
  assign state = control_reg[0] ? state_1 : state_0;

    crc16 i_crc16_0 (
      .clk_i(p_clk_i),
      .rstn_i(p_rstn_i),
      .din_i(din_i),
      .data_valid_i(data_valid_i & ~control_reg[0]),
      .crc_rd(crc_rd & ~control_reg[0]),
      .crc_o(crc_o_0),
      .state_o(state_0)
    );
    
    crc8 i_crc8 (
      .clk_i(p_clk_i),
      .rstn_i(p_rstn_i),
      .din_i(din_i[7:0]),
      .data_valid_i(data_valid_i & control_reg[0]),
      .crc_rd(crc_rd & control_reg[0]),
      .crc_o(crc_o_1),
      .state_o(state_1)
    );
    
  logic cs_1_ff;
  logic cs_2_ff;

  logic cs_ack1_ff;
  logic cs_ack2_ff;

  always_ff @ (posedge p_clk_i)
  begin
      cs_1_ff <= p_enable_i & p_sel_i;
      cs_2_ff <= cs_1_ff;
  end

  logic cs;
  assign cs = cs_1_ff & (~cs_2_ff);

  always_ff @ (posedge p_clk_i)
  begin
    cs_ack1_ff <= cs_2_ff;
    cs_ack2_ff <= cs_ack1_ff;
  end

  // Generating acknowledge signal
  logic p_ready_ff;

  always_ff @ (posedge p_clk_i)
  begin
    p_ready_ff <= (cs_ack1_ff & (~cs_ack2_ff));
  end

    always_ff @(posedge p_clk_i) begin
      if (!p_rstn_i)
        control_reg <= 32'd0;
      else if (cs & p_we_i & (p_adr_i[3:0] == 4'd12))
        control_reg <= p_dat_i;
    end
    

  assign p_ready = p_ready_ff;

    always_ff @(posedge p_clk_i) begin
      if (!p_rstn_i) begin
        p_dat_o <= 32'd0;
      end
      else if (cs & (~p_we_i)) begin
        case (p_adr_i[3:0])
          4'd4:  p_dat_o <= {16'd0, crc_o};
          4'd8:  p_dat_o <= {30'd0, state};
          4'd12: p_dat_o <= control_reg;
          4'd0:  p_dat_o <= 32'hffff;
          default: p_dat_o <= 32'd0;
        endcase
      end
    end

  assign data_valid_i = (cs & p_we_i & p_adr_i[3:0]  == 4'd0);
  assign din_i        = (cs & p_we_i & p_adr_i[3:0]  == 4'd0) ? p_dat_i[width-1:0]: '0;
  assign crc_rd       = (cs & ~p_we_i & p_adr_i[3:0] == 4'd4);

endmodule