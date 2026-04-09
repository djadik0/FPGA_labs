module axis_switch_static_4x6
#(parameter TDATA_WIDTH = 32)
(
  input  logic                   s0_tvalid,
  output logic                   s0_tready,
  input  logic [TDATA_WIDTH-1:0] s0_tdata,
  input  logic [2:0]             s0_tdest,

  input  logic                   s1_tvalid,
  output logic                   s1_tready,
  input  logic [TDATA_WIDTH-1:0] s1_tdata,
  input  logic [2:0]             s1_tdest,

  input  logic                   s2_tvalid,
  output logic                   s2_tready,
  input  logic [TDATA_WIDTH-1:0] s2_tdata,
  input  logic [2:0]             s2_tdest,

  input  logic                   s3_tvalid,
  output logic                   s3_tready,
  input  logic [TDATA_WIDTH-1:0] s3_tdata,
  input  logic [2:0]             s3_tdest,

  output logic                   m0_tvalid,
  input  logic                   m0_tready,
  output logic [TDATA_WIDTH-1:0] m0_tdata,
  output logic [2:0]             m0_tdest,
  output logic [1:0]             m0_tuser,

  output logic                   m1_tvalid,
  input  logic                   m1_tready,
  output logic [TDATA_WIDTH-1:0] m1_tdata,
  output logic [2:0]             m1_tdest,
  output logic [1:0]             m1_tuser,

  output logic                   m2_tvalid,
  input  logic                   m2_tready,
  output logic [TDATA_WIDTH-1:0] m2_tdata,
  output logic [2:0]             m2_tdest,
  output logic [1:0]             m2_tuser,

  output logic                   m3_tvalid,
  input  logic                   m3_tready,
  output logic [TDATA_WIDTH-1:0] m3_tdata,
  output logic [2:0]             m3_tdest,
  output logic [1:0]             m3_tuser,

  output logic                   m4_tvalid,
  input  logic                   m4_tready,
  output logic [TDATA_WIDTH-1:0] m4_tdata,
  output logic [2:0]             m4_tdest,
  output logic [1:0]             m4_tuser,

  output logic                   m5_tvalid,
  input  logic                   m5_tready,
  output logic [TDATA_WIDTH-1:0] m5_tdata,
  output logic [2:0]             m5_tdest,
  output logic [1:0]             m5_tuser
);

  logic f0_m0_tvalid, f0_m0_tready;
  logic f0_m1_tvalid, f0_m1_tready;
  logic f0_m2_tvalid, f0_m2_tready;
  logic f0_m3_tvalid, f0_m3_tready;
  logic f0_m4_tvalid, f0_m4_tready;
  logic f0_m5_tvalid, f0_m5_tready;
  logic [TDATA_WIDTH-1:0] f0_m0_tdata, f0_m1_tdata, f0_m2_tdata, f0_m3_tdata, f0_m4_tdata, f0_m5_tdata;

  logic f1_m0_tvalid, f1_m0_tready;
  logic f1_m1_tvalid, f1_m1_tready;
  logic f1_m2_tvalid, f1_m2_tready;
  logic f1_m3_tvalid, f1_m3_tready;
  logic f1_m4_tvalid, f1_m4_tready;
  logic f1_m5_tvalid, f1_m5_tready;
  logic [TDATA_WIDTH-1:0] f1_m0_tdata, f1_m1_tdata, f1_m2_tdata, f1_m3_tdata, f1_m4_tdata, f1_m5_tdata;

  logic f2_m0_tvalid, f2_m0_tready;
  logic f2_m1_tvalid, f2_m1_tready;
  logic f2_m2_tvalid, f2_m2_tready;
  logic f2_m3_tvalid, f2_m3_tready;
  logic f2_m4_tvalid, f2_m4_tready;
  logic f2_m5_tvalid, f2_m5_tready;
  logic [TDATA_WIDTH-1:0] f2_m0_tdata, f2_m1_tdata, f2_m2_tdata, f2_m3_tdata, f2_m4_tdata, f2_m5_tdata;

  logic f3_m0_tvalid, f3_m0_tready;
  logic f3_m1_tvalid, f3_m1_tready;
  logic f3_m2_tvalid, f3_m2_tready;
  logic f3_m3_tvalid, f3_m3_tready;
  logic f3_m4_tvalid, f3_m4_tready;
  logic f3_m5_tvalid, f3_m5_tready;
  logic [TDATA_WIDTH-1:0] f3_m0_tdata, f3_m1_tdata, f3_m2_tdata, f3_m3_tdata, f3_m4_tdata, f3_m5_tdata;

  axis_fork_1to6 #(.TDATA_WIDTH(TDATA_WIDTH)) fork0 (
    .s_tvalid (s0_tvalid),
    .s_tready (s0_tready),
    .s_tdata  (s0_tdata),
    .s_tdest  (s0_tdest),

    .m0_tvalid(f0_m0_tvalid), .m0_tready(f0_m0_tready), .m0_tdata(f0_m0_tdata),
    .m1_tvalid(f0_m1_tvalid), .m1_tready(f0_m1_tready), .m1_tdata(f0_m1_tdata),
    .m2_tvalid(f0_m2_tvalid), .m2_tready(f0_m2_tready), .m2_tdata(f0_m2_tdata),
    .m3_tvalid(f0_m3_tvalid), .m3_tready(f0_m3_tready), .m3_tdata(f0_m3_tdata),
    .m4_tvalid(f0_m4_tvalid), .m4_tready(f0_m4_tready), .m4_tdata(f0_m4_tdata),
    .m5_tvalid(f0_m5_tvalid), .m5_tready(f0_m5_tready), .m5_tdata(f0_m5_tdata)
  );

  axis_fork_1to6 #(.TDATA_WIDTH(TDATA_WIDTH)) fork1 (
    .s_tvalid (s1_tvalid),
    .s_tready (s1_tready),
    .s_tdata  (s1_tdata),
    .s_tdest  (s1_tdest),

    .m0_tvalid(f1_m0_tvalid), .m0_tready(f1_m0_tready), .m0_tdata(f1_m0_tdata),
    .m1_tvalid(f1_m1_tvalid), .m1_tready(f1_m1_tready), .m1_tdata(f1_m1_tdata),
    .m2_tvalid(f1_m2_tvalid), .m2_tready(f1_m2_tready), .m2_tdata(f1_m2_tdata),
    .m3_tvalid(f1_m3_tvalid), .m3_tready(f1_m3_tready), .m3_tdata(f1_m3_tdata),
    .m4_tvalid(f1_m4_tvalid), .m4_tready(f1_m4_tready), .m4_tdata(f1_m4_tdata),
    .m5_tvalid(f1_m5_tvalid), .m5_tready(f1_m5_tready), .m5_tdata(f1_m5_tdata)
  );

  axis_fork_1to6 #(.TDATA_WIDTH(TDATA_WIDTH)) fork2 (
    .s_tvalid (s2_tvalid),
    .s_tready (s2_tready),
    .s_tdata  (s2_tdata),
    .s_tdest  (s2_tdest),

    .m0_tvalid(f2_m0_tvalid), .m0_tready(f2_m0_tready), .m0_tdata(f2_m0_tdata),
    .m1_tvalid(f2_m1_tvalid), .m1_tready(f2_m1_tready), .m1_tdata(f2_m1_tdata),
    .m2_tvalid(f2_m2_tvalid), .m2_tready(f2_m2_tready), .m2_tdata(f2_m2_tdata),
    .m3_tvalid(f2_m3_tvalid), .m3_tready(f2_m3_tready), .m3_tdata(f2_m3_tdata),
    .m4_tvalid(f2_m4_tvalid), .m4_tready(f2_m4_tready), .m4_tdata(f2_m4_tdata),
    .m5_tvalid(f2_m5_tvalid), .m5_tready(f2_m5_tready), .m5_tdata(f2_m5_tdata)
  );

  axis_fork_1to6 #(.TDATA_WIDTH(TDATA_WIDTH)) fork3 (
    .s_tvalid (s3_tvalid),
    .s_tready (s3_tready),
    .s_tdata  (s3_tdata),
    .s_tdest  (s3_tdest),

    .m0_tvalid(f3_m0_tvalid), .m0_tready(f3_m0_tready), .m0_tdata(f3_m0_tdata),
    .m1_tvalid(f3_m1_tvalid), .m1_tready(f3_m1_tready), .m1_tdata(f3_m1_tdata),
    .m2_tvalid(f3_m2_tvalid), .m2_tready(f3_m2_tready), .m2_tdata(f3_m2_tdata),
    .m3_tvalid(f3_m3_tvalid), .m3_tready(f3_m3_tready), .m3_tdata(f3_m3_tdata),
    .m4_tvalid(f3_m4_tvalid), .m4_tready(f3_m4_tready), .m4_tdata(f3_m4_tdata),
    .m5_tvalid(f3_m5_tvalid), .m5_tready(f3_m5_tready), .m5_tdata(f3_m5_tdata)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join0 (
    .s0_tvalid(f0_m0_tvalid), .s0_tready(f0_m0_tready), .s0_tdata(f0_m0_tdata),
    .s1_tvalid(f1_m0_tvalid), .s1_tready(f1_m0_tready), .s1_tdata(f1_m0_tdata),
    .s2_tvalid(f2_m0_tvalid), .s2_tready(f2_m0_tready), .s2_tdata(f2_m0_tdata),
    .s3_tvalid(f3_m0_tvalid), .s3_tready(f3_m0_tready), .s3_tdata(f3_m0_tdata),
    .m_tvalid (m0_tvalid), .m_tready(m0_tready), .m_tdata(m0_tdata), .m_tuser(m0_tuser)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join1 (
    .s0_tvalid(f0_m1_tvalid), .s0_tready(f0_m1_tready), .s0_tdata(f0_m1_tdata),
    .s1_tvalid(f1_m1_tvalid), .s1_tready(f1_m1_tready), .s1_tdata(f1_m1_tdata),
    .s2_tvalid(f2_m1_tvalid), .s2_tready(f2_m1_tready), .s2_tdata(f2_m1_tdata),
    .s3_tvalid(f3_m1_tvalid), .s3_tready(f3_m1_tready), .s3_tdata(f3_m1_tdata),
    .m_tvalid (m1_tvalid), .m_tready(m1_tready), .m_tdata(m1_tdata), .m_tuser(m1_tuser)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join2 (
    .s0_tvalid(f0_m2_tvalid), .s0_tready(f0_m2_tready), .s0_tdata(f0_m2_tdata),
    .s1_tvalid(f1_m2_tvalid), .s1_tready(f1_m2_tready), .s1_tdata(f1_m2_tdata),
    .s2_tvalid(f2_m2_tvalid), .s2_tready(f2_m2_tready), .s2_tdata(f2_m2_tdata),
    .s3_tvalid(f3_m2_tvalid), .s3_tready(f3_m2_tready), .s3_tdata(f3_m2_tdata),
    .m_tvalid (m2_tvalid), .m_tready(m2_tready), .m_tdata(m2_tdata), .m_tuser(m2_tuser)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join3 (
    .s0_tvalid(f0_m3_tvalid), .s0_tready(f0_m3_tready), .s0_tdata(f0_m3_tdata),
    .s1_tvalid(f1_m3_tvalid), .s1_tready(f1_m3_tready), .s1_tdata(f1_m3_tdata),
    .s2_tvalid(f2_m3_tvalid), .s2_tready(f2_m3_tready), .s2_tdata(f2_m3_tdata),
    .s3_tvalid(f3_m3_tvalid), .s3_tready(f3_m3_tready), .s3_tdata(f3_m3_tdata),
    .m_tvalid (m3_tvalid), .m_tready(m3_tready), .m_tdata(m3_tdata), .m_tuser(m3_tuser)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join4 (
    .s0_tvalid(f0_m4_tvalid), .s0_tready(f0_m4_tready), .s0_tdata(f0_m4_tdata),
    .s1_tvalid(f1_m4_tvalid), .s1_tready(f1_m4_tready), .s1_tdata(f1_m4_tdata),
    .s2_tvalid(f2_m4_tvalid), .s2_tready(f2_m4_tready), .s2_tdata(f2_m4_tdata),
    .s3_tvalid(f3_m4_tvalid), .s3_tready(f3_m4_tready), .s3_tdata(f3_m4_tdata),
    .m_tvalid (m4_tvalid), .m_tready(m4_tready), .m_tdata(m4_tdata), .m_tuser(m4_tuser)
  );

  axis_join_static_4to1 #(.TDATA_WIDTH(TDATA_WIDTH)) join5 (
    .s0_tvalid(f0_m5_tvalid), .s0_tready(f0_m5_tready), .s0_tdata(f0_m5_tdata),
    .s1_tvalid(f1_m5_tvalid), .s1_tready(f1_m5_tready), .s1_tdata(f1_m5_tdata),
    .s2_tvalid(f2_m5_tvalid), .s2_tready(f2_m5_tready), .s2_tdata(f2_m5_tdata),
    .s3_tvalid(f3_m5_tvalid), .s3_tready(f3_m5_tready), .s3_tdata(f3_m5_tdata),
    .m_tvalid (m5_tvalid), .m_tready(m5_tready), .m_tdata(m5_tdata), .m_tuser(m5_tuser)
  );

  assign m0_tdest = 3'd0;
  assign m1_tdest = 3'd1;
  assign m2_tdest = 3'd2;
  assign m3_tdest = 3'd3;
  assign m4_tdest = 3'd4;
  assign m5_tdest = 3'd5;

endmodule