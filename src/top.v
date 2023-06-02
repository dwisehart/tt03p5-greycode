`default_nettype none
`timescale 1ns/1ps

module tt_um_greycode_top #( parameter pTEST = 'b0 )
(
 input        ena,     // Can be ignored
 input        clk,
 input        rst_n,

 input [7:0]  ui_in,   // Dedicated inputs
 output [7:0] uo_out,  // Dedicated outputs

 input [7:0]  uio_in,  // Tri-state input path
 output [7:0] uio_out, // Tri-state output path
 output [7:0] uio_oe   // Tri-state output enable
);

////////////////////////////////////////
   wire       w_rst;
   rst m_rst
   (
    .i_clk   ( clk ),
    .i_rst_n ( rst_n ),
    .o_rst   ( w_rst )
   );

////////////////////////////////////////
   wire [5:0] w_sel;
   wire       w_clk_005, w_clk_011, w_clk_023, w_clk_047, w_clk_097, w_clk_197;
   ringd #( .pSTAGES(   5 ) )
     m_ring005d( .i_clk( clk ), .i_sel( w_sel[5] ), .o_clk( w_clk_005 ) );
   ringd #( .pSTAGES(  11 ) )
     m_ring011d( .i_clk( clk ), .i_sel( w_sel[4] ), .o_clk( w_clk_011 ) );
   ringd #( .pSTAGES(  23 ) )
     m_ring023d( .i_clk( clk ), .i_sel( w_sel[3] ), .o_clk( w_clk_023 ) );
   ringd #( .pSTAGES(  47 ) )
     m_ring047d( .i_clk( clk ), .i_sel( w_sel[2] ), .o_clk( w_clk_047 ) );
   ringd #( .pSTAGES(  97 ) )
     m_ring097d( .i_clk( clk ), .i_sel( w_sel[1] ), .o_clk( w_clk_097 ) );
   ringd #( .pSTAGES( 197 ) )
     m_ring197d( .i_clk( clk ), .i_sel( w_sel[0] ), .o_clk( w_clk_197 ) );
   // Next primes in this sequence are 397, 797, 1597

////////////////////////////////////////
   wire       w_ring_clk;
   select #( .pTEST( pTEST ) ) m_select
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_sel   ( uio_in ),

    .o_oe    ( uio_oe ),
    .o_sel   ( w_sel ),

    .i_005   ( w_clk_005 ),
    .i_011   ( w_clk_011 ),
    .i_023   ( w_clk_023 ),
    .i_047   ( w_clk_047 ),
    .i_097   ( w_clk_097 ),
    .i_197   ( w_clk_197 ),
    .o_ring  ( w_ring_clk )
   );

////////////////////////////////////////
   wire       w_roll_a;
   grey m_grey_a
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_ring_clk ),

    .o_roll  ( uo_out[5] ),
    .o_cnt   ( uo_out[4:0] )
   );

   grey m_grey_b
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( uo_out[5] ),

    .o_roll  ( uio_out[3] ),
    .o_cnt   ({ uio_out[2:0], uo_out[7:6] })
   );

////////////////////////////////////////
   compare m_compare
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_out   ( uo_out ),
    .i_ret   ( ui_in ),

    .o_diff  ( uio_out[7:4] )
   );

endmodule
