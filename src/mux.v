`default_nettype none
`timescale 1ns/1ps

  module mux
  (
   input        i_clk,
   input        i_rst,
   input [5:0]  i_sel,

   input        i_roll_a_005, i_roll_b_005,
   input [4:0]  i_cnt_a_005, i_cnt_b_005,

   input        i_roll_a_011, i_roll_b_011,
   input [4:0]  i_cnt_a_011, i_cnt_b_011,

   input        i_roll_a_023, i_roll_b_023,
   input [4:0]  i_cnt_a_023, i_cnt_b_023,

   input        i_roll_a_047, i_roll_b_047,
   input [4:0]  i_cnt_a_047, i_cnt_b_047,

   input        i_roll_a_097, i_roll_b_097,
   input [4:0]  i_cnt_a_097, i_cnt_b_097,

   input        i_roll_a_197, i_roll_b_197,
   input [4:0]  i_cnt_a_197, i_cnt_b_197,

   input        i_roll_a_clk, i_roll_b_clk,
   input [4:0]  i_cnt_a_clk, i_cnt_b_clk,

   output [7:0] o_out,
   output [3:0] o_out2
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
   reg [7:0]  r_out;
   assign     o_out         = r_out;
   reg [3:0]  r_out2;
   assign     o_out2        = r_out2;

   always @( posedge i_clk )
     if( w_rst ) begin
        r_out              <= 'd0;
        r_out2             <= 'd0;
     end
     else
       casex( i_sel )
         'b1xxxxx: begin
            r_out          <= { i_cnt_b_005[1:0], i_roll_a_005, i_cnt_a_005 };
            r_out2         <= { i_roll_b_005, i_cnt_b_005[4:2] };
         end
         'b01xxxx: begin
            r_out          <= { i_cnt_b_011[1:0], i_roll_a_011, i_cnt_a_011 };
            r_out2         <= { i_roll_b_011, i_cnt_b_011[4:2] };
         end
         'b001xxx: begin
            r_out          <= { i_cnt_b_023[1:0], i_roll_a_023, i_cnt_a_023 };
            r_out2         <= { i_roll_b_023, i_cnt_b_023[4:2] };
         end
         'b0001xx: begin
            r_out          <= { i_cnt_b_047[1:0], i_roll_a_047, i_cnt_a_047 };
            r_out2         <= { i_roll_b_047, i_cnt_b_047[4:2] };
         end
         'b00001x: begin
            r_out          <= { i_cnt_b_097[1:0], i_roll_a_097, i_cnt_a_097 };
            r_out2         <= { i_roll_b_097, i_cnt_b_097[4:2] };
         end
         'b000001: begin
            r_out          <= { i_cnt_b_197[1:0], i_roll_a_197, i_cnt_a_197 };
            r_out2         <= { i_roll_b_197, i_cnt_b_197[4:2] };
         end
         default: begin
            r_out          <= { i_cnt_b_clk[1:0], i_roll_a_clk, i_cnt_a_clk };
            r_out2         <= { i_roll_b_clk, i_cnt_b_clk[4:2] };
         end
       endcase

endmodule
