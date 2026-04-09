module tb_axis_switch_static_4x6;

  localparam int TDATA_WIDTH = 32;

  logic                   s0_tvalid;
  logic                   s0_tready;
  logic [TDATA_WIDTH-1:0] s0_tdata;
  logic [2:0]             s0_tdest;

  logic                   s1_tvalid;
  logic                   s1_tready;
  logic [TDATA_WIDTH-1:0] s1_tdata;
  logic [2:0]             s1_tdest;

  logic                   s2_tvalid;
  logic                   s2_tready;
  logic [TDATA_WIDTH-1:0] s2_tdata;
  logic [2:0]             s2_tdest;

  logic                   s3_tvalid;
  logic                   s3_tready;
  logic [TDATA_WIDTH-1:0] s3_tdata;
  logic [2:0]             s3_tdest;

  logic                   m0_tvalid;
  logic                   m0_tready;
  logic [TDATA_WIDTH-1:0] m0_tdata;
  logic [2:0]             m0_tdest;
  logic [1:0]             m0_tuser;

  logic                   m1_tvalid;
  logic                   m1_tready;
  logic [TDATA_WIDTH-1:0] m1_tdata;
  logic [2:0]             m1_tdest;
  logic [1:0]             m1_tuser;

  logic                   m2_tvalid;
  logic                   m2_tready;
  logic [TDATA_WIDTH-1:0] m2_tdata;
  logic [2:0]             m2_tdest;
  logic [1:0]             m2_tuser;

  logic                   m3_tvalid;
  logic                   m3_tready;
  logic [TDATA_WIDTH-1:0] m3_tdata;
  logic [2:0]             m3_tdest;
  logic [1:0]             m3_tuser;

  logic                   m4_tvalid;
  logic                   m4_tready;
  logic [TDATA_WIDTH-1:0] m4_tdata;
  logic [2:0]             m4_tdest;
  logic [1:0]             m4_tuser;

  logic                   m5_tvalid;
  logic                   m5_tready;
  logic [TDATA_WIDTH-1:0] m5_tdata;
  logic [2:0]             m5_tdest;
  logic [1:0]             m5_tuser;

  axis_switch_static_4x6 #(
    .TDATA_WIDTH(TDATA_WIDTH)
  ) dut (
    .s0_tvalid(s0_tvalid),
    .s0_tready(s0_tready),
    .s0_tdata (s0_tdata),
    .s0_tdest (s0_tdest),

    .s1_tvalid(s1_tvalid),
    .s1_tready(s1_tready),
    .s1_tdata (s1_tdata),
    .s1_tdest (s1_tdest),

    .s2_tvalid(s2_tvalid),
    .s2_tready(s2_tready),
    .s2_tdata (s2_tdata),
    .s2_tdest (s2_tdest),

    .s3_tvalid(s3_tvalid),
    .s3_tready(s3_tready),
    .s3_tdata (s3_tdata),
    .s3_tdest (s3_tdest),

    .m0_tvalid(m0_tvalid),
    .m0_tready(m0_tready),
    .m0_tdata (m0_tdata),
    .m0_tdest (m0_tdest),
    .m0_tuser (m0_tuser),

    .m1_tvalid(m1_tvalid),
    .m1_tready(m1_tready),
    .m1_tdata (m1_tdata),
    .m1_tdest (m1_tdest),
    .m1_tuser (m1_tuser),

    .m2_tvalid(m2_tvalid),
    .m2_tready(m2_tready),
    .m2_tdata (m2_tdata),
    .m2_tdest (m2_tdest),
    .m2_tuser (m2_tuser),

    .m3_tvalid(m3_tvalid),
    .m3_tready(m3_tready),
    .m3_tdata (m3_tdata),
    .m3_tdest (m3_tdest),
    .m3_tuser (m3_tuser),

    .m4_tvalid(m4_tvalid),
    .m4_tready(m4_tready),
    .m4_tdata (m4_tdata),
    .m4_tdest (m4_tdest),
    .m4_tuser (m4_tuser),

    .m5_tvalid(m5_tvalid),
    .m5_tready(m5_tready),
    .m5_tdata (m5_tdata),
    .m5_tdest (m5_tdest),
    .m5_tuser (m5_tuser)
  );

  initial begin
    s0_tvalid = 0;
    s0_tdata  = 0;
    s0_tdest  = 0;

    s1_tvalid = 0;
    s1_tdata  = 0;
    s1_tdest  = 0;

    s2_tvalid = 0;
    s2_tdata  = 0;
    s2_tdest  = 0;

    s3_tvalid = 0;
    s3_tdata  = 0;
    s3_tdest  = 0;

    m0_tready = 1;
    m1_tready = 1;
    m2_tready = 1;
    m3_tready = 1;
    m4_tready = 1;
    m5_tready = 1;

    #10;

    s0_tvalid = 1;
    s0_tdata  = 32'h0000_00A0;
    s0_tdest  = 3'd2;
    #10;
    s0_tvalid = 0;
    #10;

    s2_tvalid = 1;
    s2_tdata  = 32'h0000_00C2;
    s2_tdest  = 3'd5;
    #10;
    s2_tvalid = 0;
    #10;

    // конфликт
    s0_tvalid = 1;
    s0_tdata  = 32'h1111_0000;
    s0_tdest  = 3'd1;

    s1_tvalid = 1;
    s1_tdata  = 32'h2222_0000;
    s1_tdest  = 3'd1;
    #10;

    s0_tvalid = 0;
    #10;

    s1_tvalid = 0;
    #10;


    $stop;
  end

endmodule