
module synchroniser_flag_busy(
    input  logic clkA_i,
    input  logic reset,
    output logic busyA_o,
    input  logic clkB_i,
    input  logic datA_i,
    output logic datB_o,
    output logic [4:0]  counterA_o
);

    logic       toggleA;
    logic [1:0] syncBusyA;
    logic [2:0] syncB;
    logic [4:0] counterB;
    logic [4:0] grey_o;
    logic [4:0] grey_i;
    logic [4:0] grey_0_ff;

    //Clock domain A

    always_ff @(posedge clkA_i or posedge reset ) begin 
        if  ( reset ) 
            toggleA  <=  '0;  
        else 
            toggleA <= toggleA ^ datA_i;
    end
    
    always_ff @(posedge clkA_i or posedge reset ) begin 
        if  ( reset ) 
            syncBusyA  <=  '0;
        else 
            syncBusyA <= {syncBusyA[0], syncB[2]};
    end

    assign busyA_o = syncBusyA[1] ^ toggleA;
    
    always_ff @( posedge clkA_i or posedge reset ) begin 
        if ( reset ) begin 
              grey_0_ff  <=  '0;
              grey_i     <=  '0;
            end
        else begin
              grey_0_ff  <=  grey_o;
              grey_i     <=  grey_0_ff;
            end
    end
    
    assign counterA_o[4] =  grey_i[4];
    assign counterA_o[3] = ^grey_i[4:3];
    assign counterA_o[2] = ^grey_i[4:2];
    assign counterA_o[1] = ^grey_i[4:1];
    assign counterA_o[0] = ^grey_i[4:0];


    //Clock domain B

    always_ff @(posedge clkB_i or posedge reset ) begin 
        if ( reset ) 
            syncB  <= '0;
        else 
            syncB <= {syncB[1:0], toggleA};
    end

    assign datB_o = ^syncB[2:1];
    
    always_ff @(posedge clkB_i or posedge reset ) begin 
        if ( reset ) 
            counterB  <=  '0;
        else if ( datB_o ) 
            counterB  <=  counterB + 1; 
    end
       

    assign grey_o = (counterB >> 1) ^ counterB;


endmodule
        
        
