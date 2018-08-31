`timescale  1ns/1ps

module tb_fft_3();

//------------------------------//
reg     sclk;
reg     [31:0]  s_axis_data_tdata;
reg     [31:0]  data[1023:0];
reg     [31:0]  out_re[1023:0];
reg     [31:0]  out_im[1023:0];

wire    s_axis_config_tready;
wire    s_axis_data_tready;
wire    [31:0]  data_re;
wire    [31:0]  data_im;
wire    m_axis_data_tvalid;


//------------------------------//

initial     sclk = 0;
always      #5     sclk = ~sclk;   //100M
//-------------------------------//

integer i;
integer j;
integer f;

initial begin
 f = $fopen("output.txt","w");
end


initial begin
s_axis_data_tdata = 0;
#100
$readmemb("C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/TestBeach/fft_core.txt",data);
    for (i=0;i<1024;i=i+1 ) begin
        s_axis_data_tdata[15:0] = data[i]; 
        #10;//100M
    end 
end

//-------------------------------//
//if (m_axis_data_tvalid == 1) begin
//    #10 
//        f = $fopen("C:/Users/Administrator/Hoang_Design/Example/2.softcore/FFT_IP_Core-master/FFT_IP_Core-master/TestBeach/output.txt","w");
//end

//-------------------------------//
reg     rx_ready;
reg     rd_clk;

//-------------------------------//
FFT_Control_3               FFT_Control_3_inst0(
    .clk                    (sclk),
    .s_axis_data_tdata      (s_axis_data_tdata),
    .s_axis_config_tready   (s_axis_config_tready),
    .s_axis_data_tready     (s_axis_data_tready),
    .data_out_re            (data_re),
    .data_out_im            (data_im),
    .m_axis_data_tvalid     (m_axis_data_tvalid)
);

initial  begin
    if (m_axis_data_tvalid == 1) begin

        for (j = 0; j<1024; j=j+1)
            @(posedge sclk)
            out_re[j]<= data_re;
    end
end
  

endmodule 


