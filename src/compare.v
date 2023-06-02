`default_nettype none
`timescale 1ns/1ps

  module compare
  (
   input        i_clk,
   input        i_rst,
   input [7:0]  i_out,
   input [7:0]  i_ret,

   output [3:0] o_diff
  );

////////////////////////////////////////
   wire       w_rst;
   rst m_rst
   (
    .i_clk   ( i_clk ),
    .i_rst_n ( ~ i_rst ),
    .o_rst   ( w_rst )
   );

////////////////////////////////////////
   reg [7:0]    r_out_1, r_out_2, r_out_3, r_out_4, r_ret;

   always @( posedge i_clk ) begin
      r_ret               <= i_ret;
      r_out_4             <= r_out_3;
      r_out_3             <= r_out_2;
      r_out_2             <= r_out_1;
      r_out_1             <= i_out;
   end

////////////////////////////////////////
   reg [3:0]    r_diff;
   assign       o_diff     = r_diff;

   always @( posedge i_clk )
     if( w_rst )
       r_diff             <= 'd0;
     else
       casex({ r_ret == r_out_1, r_ret == r_out_2, r_ret == r_out_3, r_ret == r_out_4 })
         'b1xxx:  r_diff  <= 'b0001;
         'b01xx:  r_diff  <= 'b0010;
         'b001x:  r_diff  <= 'b0100;
         'b0001:  r_diff  <= 'b1000;
         default: r_diff  <= 'b0000;
       endcase

endmodule
