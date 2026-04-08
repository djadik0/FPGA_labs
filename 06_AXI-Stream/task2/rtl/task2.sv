module task2
(
  input  logic                    clk_i,
  input  logic                    rstn_i,


  input  logic                    s_valid_i,
  input  logic [15:0]             s_data_i,
  output logic                    s_ready_o,


  output logic [9:0]             m_data_o,  
  output logic                    m_valid_o,
  input  logic                    m_ready_i
);
// 1 /////////////////////

  logic        stage1_valid;
  logic [16:0] stage1_data;
  logic        stage1_ready;

  logic [16:0] fifo1_data;
  logic        fifo1_valid;
  logic        fifo1_ready;

  fifo_wrapper #(.D_WIDTH(17), .PTR_WIDTH(3)) 
    fifo1(
    .clk_i  ( clk_i ),
    .rstn_i ( rstn_i),
    .s_valid_i ( stage1_valid ),
    .s_data_i  ( stage1_data  ),
    .s_ready_o ( stage1_ready ),
    .m_valid_o ( fifo1_valid  ),
    .m_data_o  ( fifo1_data   ),
    .m_ready_i ( fifo2_ready  )
  );

  
  assign stage1_valid = s_valid_i;
  assign s_ready_o    = stage1_ready;

  always_ff @(posedge clk_i) begin
    if (stage1_ready)
      stage1_data <= $signed(s_data_i) - 2;
  end

// 2 ////////////////////////

  logic        stage2_valid;
  logic [16:0] stage2_data;
  logic        stage2_ready;
  
  logic [16:0] fifo2_data;
  logic        fifo2_valid;
  logic        fifo2_ready;
  
  logic [16:0] hist_3back;
  logic [16:0] hist_2back;
  logic [16:0] hist_1back;

  fifo_wrapper #(.D_WIDTH(17), .PTR_WIDTH(3))
   fifo2 (
    .clk_i     ( clk_i       ),
    .rstn_i    ( rstn_i      ),
    .s_valid_i ( fifo1_valid & fifo2_ready ), 
    .s_data_i  ( stage2_data  ),
    .s_ready_o ( fifo2_ready  ),
    .m_valid_o ( fifo2_valid  ),
    .m_data_o  ( fifo2_data   ),
    .m_ready_i ( fifo3_ready  )
  );

  assign stage2_valid = fifo1_valid;
  assign fifo1_ready  = fifo2_ready;

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (!rstn_i) begin
      hist_3back <= 17'b0;
      hist_2back <= 17'b0;
      hist_1back <= 17'b0;
    end else if (fifo1_valid & fifo2_ready) begin
      hist_3back <= hist_2back;
      hist_2back <= hist_1back;
      hist_1back <= fifo1_data; 
    end
  end

  always_ff @(posedge clk_i) begin
    if (fifo1_valid & fifo2_ready)
      stage2_data <= $signed(fifo1_data) + $signed(hist_3back);
  end


// 3 /////////////////////////////

  logic        stage3_valid;
  logic [20:0] stage3_data;
  logic        stage3_ready;
  
  logic [20:0] fifo3_data;
  logic        fifo3_valid;
  logic        fifo3_ready;

    fifo_wrapper #(.D_WIDTH(21), .PTR_WIDTH(3)) 
    fifo3 (
    .clk_i     ( clk_i       ),
    .rstn_i    ( rstn_i      ),
    .s_valid_i ( fifo2_valid & fifo3_ready ), 
    .s_data_i  ( stage3_data  ),
    .s_ready_o ( stage3_ready  ),
    .m_valid_o ( fifo3_valid  ),
    .m_data_o  ( fifo3_data   ),
    .m_ready_i ( fifo4_ready  )
  );

  assign stage3_valid = fifo2_valid;
  assign fifo2_ready  = fifo3_ready;

  always_ff @(posedge clk_i) begin
    if (fifo2_valid & fifo3_ready)
      stage3_data <= $signed(fifo2_data) * 9;
  end

// 4 //////////////////////////////////

  logic        stage4_valid;
  logic [21:0] stage4_data;
  logic        stage4_ready;
  
  logic [21:0] fifo4_data;
  logic        fifo4_valid;
  logic        fifo4_ready;

    fifo_wrapper #(.D_WIDTH(22),.PTR_WIDTH(3)) 
    fifo4 (
    .clk_i     ( clk_i       ),
    .rstn_i    ( rstn_i      ),
    .s_valid_i ( fifo3_valid & fifo4_ready ), 
    .s_data_i  ( stage4_data  ),
    .s_ready_o ( stage4_ready  ),
    .m_valid_o ( fifo4_valid  ),
    .m_data_o  ( fifo4_data   ),
    .m_ready_i ( stage5_ready  )
  );

  assign stage4_valid = fifo3_valid;
  assign fifo3_ready  = fifo4_ready;
  
  always_ff @(posedge clk_i) begin
    if (fifo3_valid & fifo4_ready)
      stage4_data <= $signed(fifo3_data) + 76;
  end

// 5 ///////////////////////////////////

  logic        stage5_valid;
  logic [9:0]  stage5_data;
  logic        stage5_ready;

  assign stage5_valid = fifo4_valid;
  assign fifo4_ready  = stage5_ready;
  assign m_valid_o    = stage5_valid;
  assign stage5_ready = m_ready_i;

  always_ff @(posedge clk_i) begin
    if (fifo4_valid & stage5_ready)
      stage5_data <= fifo4_data[9:0];  
  end

  assign m_data_o = stage5_data;

endmodule 