module axis_join_static_4to1
#(parameter TDATA_WIDTH = 32)
(
  input  logic                   s0_tvalid,
  output logic                   s0_tready,
  input  logic [TDATA_WIDTH-1:0] s0_tdata,

  input  logic                   s1_tvalid,
  output logic                   s1_tready,
  input  logic [TDATA_WIDTH-1:0] s1_tdata,

  input  logic                   s2_tvalid,
  output logic                   s2_tready,
  input  logic [TDATA_WIDTH-1:0] s2_tdata,

  input  logic                   s3_tvalid,
  output logic                   s3_tready,
  input  logic [TDATA_WIDTH-1:0] s3_tdata,

  output logic                   m_tvalid,
  input  logic                   m_tready,
  output logic [TDATA_WIDTH-1:0] m_tdata,
  output logic [1:0]             m_tuser
);

  logic [3:0] req;
  logic [3:0] grant;

  assign req = {s3_tvalid, s2_tvalid, s1_tvalid, s0_tvalid};

  always_comb begin
    casez (req)
      4'b???1 : grant = 4'b0001;
      4'b??10 : grant = 4'b0010;
      4'b?100 : grant = 4'b0100;
      4'b1000 : grant = 4'b1000;
      default : grant = 4'b0000;
    endcase
  end

  assign m_tvalid = |grant;

  always_comb begin
    case (grant)
      4'b0001: m_tdata = s0_tdata;
      4'b0010: m_tdata = s1_tdata;
      4'b0100: m_tdata = s2_tdata;
      4'b1000: m_tdata = s3_tdata;
      default: m_tdata = '0;
    endcase
  end

  always_comb begin
    case (grant)
      4'b0001: m_tuser = 2'd0;
      4'b0010: m_tuser = 2'd1;
      4'b0100: m_tuser = 2'd2;
      4'b1000: m_tuser = 2'd3;
      default: m_tuser = 2'd0;
    endcase
  end

  assign s0_tready = m_tready & grant[0];
  assign s1_tready = m_tready & grant[1];
  assign s2_tready = m_tready & grant[2];
  assign s3_tready = m_tready & grant[3];

endmodule
