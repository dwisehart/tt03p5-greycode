`default_nettype none
`timescale 1ns/1ps

module rst
(
 input  i_clk,
 input  i_rst_n,

 output o_rst
);

   reg [7:0] r_rst  = 'hFF;
   assign    o_rst  = r_rst[7];

   always @( posedge i_clk )
     if( ~ i_rst_n )
       r_rst       <= 'hFF;
     else
       r_rst       <= { r_rst, 1'b0 };

endmodule
