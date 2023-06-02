`default_nettype none
`timescale 1ns/1ps

  module select #( parameter pTEST = 'b0 )
  (
   input        i_clk,
   input        i_rst,
   input [7:0]  i_sel,
   output [7:0] o_oe,

   output [5:0] o_sel,
   input        i_005,
   input        i_011,
   input        i_023,
   input        i_047,
   input        i_097,
   input        i_197,
   output       o_ring
  );

////////////////////////////////////////
   reg [15:0]   r_cnt;

   always @( posedge i_clk )
     if( i_rst )
       r_cnt              <= 'd0;
     else
       r_cnt              <= r_cnt + 'd1;

////////////////////////////////////////
   reg [7:0]    r_oe;
   assign       o_oe       = r_oe;

   always @( posedge i_clk )
     if( i_rst )
       r_oe               <= 'h00;
     else if( ( r_cnt >= 'd0 && r_cnt <= 'd5 ) )
       r_oe               <= 'h00;
     else
       r_oe               <= 'hFF;

////////////////////////////////////////
   reg [5:0]    r_sel;
   assign       o_sel      = r_sel;

   always @( posedge i_clk )
     if( i_rst )
       r_sel              <= 'b000000;
     else if( pTEST || ~| r_oe )
       casex( i_sel )
         'b1xxxxx: r_sel  <= 'b100000;
         'b01xxxx: r_sel  <= 'b010000;
         'b001xxx: r_sel  <= 'b001000;
         'b0001xx: r_sel  <= 'b000100;
         'b00001x: r_sel  <= 'b000010;
         'b000001: r_sel  <= 'b000001;
         default:  r_sel  <= 'b000000;
       endcase

////////////////////////////////////////
   reg [5:0]    r_sel_2, r_last;
   reg [2:0]    r_delay;

   always @( posedge i_clk )
     if( i_rst ) begin
        r_last            <= 'd0;
        r_sel_2           <= 'd0;
        r_delay           <= 'b000;
     end
     else
       casex({ r_last != r_sel, r_delay != 'b111 })
         'b1x: begin
            r_last        <= r_sel;
            r_delay       <= 'b000;
         end
         'b01: begin
            r_delay       <= { r_delay, 1'b1 };
         end
         default: begin
            r_sel_2       <= r_sel;
         end
       endcase

////////////////////////////////////////
   reg          r_ring;
   assign       o_ring     = r_ring;

   always @( * )
     casex( r_sel_2 )
       'b1xxxxx: r_ring   <= i_005;
       'b01xxxx: r_ring   <= i_011;
       'b001xxx: r_ring   <= i_023;
       'b0001xx: r_ring   <= i_047;
       'b00001x: r_ring   <= i_097;
       'b000001: r_ring   <= i_197;
       default:  r_ring   <= i_clk;
     endcase

endmodule
