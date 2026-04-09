module task1
(
  input  logic        clk_i,
  input  logic        rstn_i,

  input  logic signed [15:0] data_a_i,
  input  logic        valid_a_i,
  output logic        ready_a_o,

  input  logic signed [15:0] data_b_i,
  input  logic        valid_b_i,
  output logic        ready_b_o,

  input  logic signed [15:0] data_c_i,
  input  logic        valid_c_i,
  output logic        ready_c_o,

  output logic signed [33:0] data_y_o,
  output logic        valid_y_o,
  input  logic        ready_y_i
);

  logic signed [33:0] y_data_ff;
  logic        valid_y_ff;
  logic        all_valid;

  assign ready_a_o = ready_y_i & all_valid; // | ~valid_y_ff;
  assign ready_b_o = ready_y_i & all_valid; // | ~valid_y_ff;
  assign ready_c_o = ready_y_i & all_valid; // | ~valid_y_ff;
  assign all_valid = valid_a_i & valid_b_i & valid_c_i;

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i)
      valid_y_ff <= '0;
    else if (ready_y_i )
      valid_y_ff <= all_valid;
  end

  always_ff @(posedge clk_i) begin
    if (ready_a_o & all_valid)
      y_data_ff <= (data_a_i * data_a_i) + (data_b_i * data_b_i) + (data_c_i * data_c_i);
  end

  assign valid_y_o = valid_y_ff;
  assign data_y_o  = y_data_ff;



endmodule