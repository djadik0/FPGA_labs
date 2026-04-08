module axis_join_static
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

  logic [3:0]                req;
  logic [3:0]                grant;
  logic [2:0]                adres;
  logic [TDATA_WIDTH-1:0]  m_tdata_ff;
  logic [1:0] tuser_int;

logic m_tready_selected;

always_comb begin
  case (adres)
    3'd0: m_tready_selected = m0_tready;
    3'd1: m_tready_selected = m1_tready;
    3'd2: m_tready_selected = m2_tready;
    3'd3: m_tready_selected = m3_tready;
    3'd4: m_tready_selected = m4_tready;
    3'd5: m_tready_selected = m5_tready;
    default: m_tready_selected = 1'b0;
  endcase
end

  assign req = {s3_tvalid,
                s2_tvalid,
                s1_tvalid,
                s0_tvalid};

  always_comb begin
    casez (req[3:0])
      4'b???1 : grant = 4'b0001;
      4'b??10 : grant = 4'b0010;
      4'b?100 : grant = 4'b0100;
      4'b1000 : grant = 4'b1000;
      4'b0000 : grant = 4'b0000;
    endcase
  end


always_comb begin
  m0_tvalid = 1'b0;
  m1_tvalid = 1'b0;
  m2_tvalid = 1'b0;
  m3_tvalid = 1'b0;
  m4_tvalid = 1'b0;
  m5_tvalid = 1'b0;
    if (|grant) begin
      case (adres)
        3'd0: m0_tvalid = 1'b1;
        3'd1: m1_tvalid = 1'b1;
        3'd2: m2_tvalid = 1'b1;
        3'd3: m3_tvalid = 1'b1;
        3'd4: m4_tvalid = 1'b1;
        3'd5: m5_tvalid = 1'b1;
        default: ;
      endcase
    end
end



  always_comb begin
    case (grant)
    4'b0001: m_tdata_ff = s0_tdata;
    4'b0010: m_tdata_ff = s1_tdata;
    4'b0100: m_tdata_ff = s2_tdata;
    4'b1000: m_tdata_ff = s3_tdata;
    default: m_tdata_ff = s0_tdata;
    endcase
  end


    assign m0_tdata = m_tdata_ff;
    assign m1_tdata = m_tdata_ff;
    assign m2_tdata = m_tdata_ff;
    assign m3_tdata = m_tdata_ff;
    assign m4_tdata = m_tdata_ff;
    assign m5_tdata = m_tdata_ff;

 always_comb begin
    case (grant)
    4'b0001: tuser_int = 2'd0;
    4'b0010: tuser_int = 2'd1;
    4'b0100: tuser_int = 2'd2;
    4'b1000: tuser_int = 2'd3;
    default: tuser_int = 2'd0;
    endcase
  end


  always_comb begin
    case (grant)
    4'b0001: adres = s0_tdest;
    4'b0010: adres = s1_tdest;
    4'b0100: adres = s2_tdest;
    4'b1000: adres = s3_tdest;
    default: adres = s0_tdest;
    endcase
  end

    assign m0_tuser = tuser_int;
    assign m1_tuser = tuser_int;
    assign m2_tuser = tuser_int;
    assign m3_tuser = tuser_int;
    assign m4_tuser = tuser_int;
    assign m5_tuser = tuser_int;

    assign m0_tdest = adres;
    assign m1_tdest = adres;
    assign m2_tdest = adres;
    assign m3_tdest = adres;
    assign m4_tdest = adres;
    assign m5_tdest = adres;


assign s0_tready = m_tready_selected & grant[0];
assign s1_tready = m_tready_selected & grant[1];
assign s2_tready = m_tready_selected & grant[2];
assign s3_tready = m_tready_selected & grant[3];

endmodule