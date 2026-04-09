module task2_tb;

  logic clk_i;
  logic rstn_i;

  logic               s_valid_i;
  logic signed [15:0] s_data_i;
  logic               s_ready_o;

  logic signed [10:0] m_data_o;
  logic               m_valid_o;
  logic               m_ready_i;

  task2 dut (
    .*
  );

  initial begin
    clk_i = 0;
    forever #5 clk_i = ~clk_i;
  end

  initial begin
    rstn_i    = 0;
    s_valid_i = 0;
    s_data_i  = 0;
    m_ready_i = 0;

    #20;
    rstn_i = 1;

    #10;
    m_ready_i = 0;

    s_valid_i = 1;
    s_data_i  = 16'sd10;
    #10;

    s_data_i = 16'sd20;
    #10;

    s_data_i = 16'sd30;
    #10;

    s_data_i = 16'sd40;
    #10;

    s_data_i = 16'sd50;
    #10;

    s_data_i = -16'sd5;
    #10;
    
    s_data_i = -16'sd10;
    #10;

    s_data_i = -16'sd15; 
    #10;
    
    s_data_i = -16'sd20;
    #10;
    
    s_data_i = -16'sd25;
    #10;
    
    s_valid_i = 0;
    s_data_i  = 0;

    #30;
    m_ready_i = 1;

    #100;

    m_ready_i = 0;
    
    #80;

    s_valid_i = 1;
    s_data_i  = 16'sd7;
    #10;

    s_data_i = 16'sd8;
    #10;

    s_data_i = 16'sd9;
    #10;

    s_valid_i = 0;
    s_data_i  = 0;

    #150;
    $stop;
  end

endmodule