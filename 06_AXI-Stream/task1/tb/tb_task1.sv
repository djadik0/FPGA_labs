module tb_task1;

  logic        clk_i;
  logic        rstn_i;

  logic signed [15:0] data_a_i;
  logic               valid_a_i;
  logic               ready_a_o;

  logic signed [15:0] data_b_i;
  logic               valid_b_i;
  logic               ready_b_o;

  logic signed [15:0] data_c_i;
  logic               valid_c_i;
  logic               ready_c_o;

  logic signed [33:0] data_y_o;
  logic               valid_y_o;
  logic               ready_y_i;

  task1 dut (
    .*
  );

  always #5 clk_i = ~clk_i;

  initial begin
    clk_i     = 0;
    rstn_i    = 0;

    data_a_i  = '0;
    data_b_i  = '0;
    data_c_i  = '0;

    valid_a_i = 0;
    valid_b_i = 0;
    valid_c_i = 0;

    ready_y_i = 0;

    #20;
    @(posedge clk_i);
    rstn_i = 1;
    @(posedge clk_i);

    // y = 29
    // данные не принимаются до ready_y_i = 1
    data_a_i  = 16'sd2;
    data_b_i  = -16'sd3;
    data_c_i  = 16'sd4;

    valid_a_i = 1;
    valid_b_i = 1;
    valid_c_i = 1;

    ready_y_i = 0;

    #50;
    @(posedge clk_i);
    ready_y_i = 1;

    #10
    @(posedge clk_i);
    valid_a_i = 0;
    valid_b_i = 0;
    valid_c_i = 0;

    #20


    // y = 30
    // проверка, что модуль ждет all_valid
    data_a_i  = -16'sd1;
    data_b_i  =  16'sd5;
    data_c_i  = -16'sd2;

    ready_y_i = 1;

    valid_a_i = 1;
    valid_b_i = 0;
    valid_c_i = 0;

    #10
    @(posedge clk_i);
    valid_b_i = 1;
    #10
    @(posedge clk_i);
    valid_c_i = 1;
    #10
    @(posedge clk_i);
    valid_a_i = 0;
    valid_b_i = 0;
    valid_c_i = 0;


    @(posedge clk_i);


    // y = 1400000000
    data_a_i  = 16'sd30000;
    data_b_i  = 16'sd20000;
    data_c_i  = 16'sd10000;

    valid_a_i = 1;
    valid_b_i = 1;
    valid_c_i = 1;
    ready_y_i = 1;

    @(posedge clk_i);
    valid_a_i = 0;
    valid_b_i = 0;
    valid_c_i = 0;

    @(posedge clk_i);
    #20;
    $stop;
  end

endmodule