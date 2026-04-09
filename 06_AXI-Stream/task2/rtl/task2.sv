module task2
(
  input  logic                    clk_i,
  input  logic                    rstn_i,


  input  logic                    s_valid_i,
  input  logic signed [15:0]      s_data_i,
  output logic                    s_ready_o,


  output logic signed [10:0]       m_data_o,  
  output logic                    m_valid_o,
  input  logic                    m_ready_i
);
// 1 /////////////////////

  logic               stage1_valid;
  logic signed [16:0] stage1_data;


  logic [3:0]  credit;
  logic        credit_return;
  


always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
        credit       <= 4'd8;
        stage1_valid <= 1'b0;
    end else begin
        if (s_valid_i & s_ready_o & !credit_return)
            credit <= credit - 1;
        else if (!(s_valid_i & s_ready_o) & credit_return)
            credit <= credit + 1;

        if (s_valid_i & s_ready_o) begin
            stage1_data  <= $signed(s_data_i) - 2;
            stage1_valid <= 1'b1;
        end else if (stage1_valid & stage2_ready) begin
            stage1_valid <= 1'b0; 
        end
    end
end

  assign s_ready_o = (credit != 0) & (~stage1_valid | stage2_ready);


// 2 ////////////////////////

  logic               stage2_valid;
  logic signed [17:0] stage2_data;
  logic               stage2_ready;

  assign stage2_ready = ~stage2_valid | stage3_ready;
  
  logic signed [16:0] hist_3back;
  logic signed [16:0] hist_2back;
  logic signed [16:0] hist_1back;

  always_ff @( posedge clk_i or negedge rstn_i) begin
    if ( !rstn_i ) begin
      stage2_valid  <=  0;
    end
    else if (stage2_ready)
      stage2_valid  <=  stage1_valid;
  end

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      hist_3back <= 17'b0;
      hist_2back <= 17'b0;
      hist_1back <= 17'b0;
    end else if ( stage1_valid & stage2_ready ) begin
      hist_3back <= hist_2back;
      hist_2back <= hist_1back;
      hist_1back <= stage1_data; 
    end
  end

  always_ff @(posedge clk_i) begin
    if ( stage1_valid & stage2_ready )
      stage2_data <= $signed(stage1_data) + $signed(hist_3back);
  end


// 3 /////////////////////////////

  logic               stage3_valid;
  logic signed [21:0] stage3_data;
  logic               stage3_ready;
  
  assign stage3_ready = ~stage3_valid | stage4_ready;

  always_ff @( posedge clk_i or negedge rstn_i) begin
    if ( !rstn_i ) begin
      stage3_valid  <=  0;
    end
    else if (stage3_ready)
      stage3_valid  <=  stage2_valid;
  end


  always_ff @(posedge clk_i) begin
    if (stage2_valid & stage3_ready)
      stage3_data <= $signed(stage2_data) * 9;
  end

// 4 //////////////////////////////////

  logic               stage4_valid;
  logic signed [22:0] stage4_data;
  logic               stage4_ready;
  
  assign stage4_ready = ~stage4_valid | stage5_ready;

  always_ff @( posedge clk_i or negedge rstn_i) begin
    if ( !rstn_i ) begin
      stage4_valid  <=  0;
    end
    else if (stage4_ready)
      stage4_valid  <=  stage3_valid;
  end


  always_ff @(posedge clk_i) begin
    if (stage3_valid & stage4_ready)
      stage4_data <= $signed(stage3_data) + 76;
  end

// 5 ///////////////////////////////////

  logic                stage5_valid;
  logic signed [10:0]  stage5_data;
  logic                stage5_ready;
  logic                fifo_ready;

  assign stage5_ready = ~stage5_valid | fifo_ready;

  always_ff @( posedge clk_i or negedge rstn_i) begin
    if ( !rstn_i ) begin
      stage5_valid  <=  0;
    end
    else if (stage5_ready)
      stage5_valid  <=  stage4_valid;
  end


  always_ff @(posedge clk_i) begin
    if (stage4_valid & stage5_ready)
      stage5_data <= $signed(stage4_data) % 12'sd1024;
  end

  fifo_wrapper #(.D_WIDTH(11), .PTR_WIDTH(3)) 
    fifo1(
    .clk_i  ( clk_i ),
    .rstn_i ( rstn_i),
    .s_valid_i ( stage5_valid ),
    .s_data_i  ( stage5_data  ),
    .s_ready_o ( fifo_ready ),
    .m_valid_o ( m_valid_o  ),
    .m_data_o  ( m_data_o   ),
    .m_ready_i ( m_ready_i  )
  );

  assign credit_return = m_valid_o && m_ready_i;

endmodule 