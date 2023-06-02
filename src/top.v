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
   select #( .pTEST( pTEST ) ) m_select
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_sel   ( uio_in ),

    .o_oe    ( uio_oe ),
    .o_sel   ( w_sel )
   );

////////////////////////////////////////
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
   wire       w_roll_a_005, w_roll_b_005;
   wire [4:0] w_cnt_a_005, w_cnt_b_005;

   grey m_grey_a_005
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_005 ),

    .o_roll  ( w_roll_a_005 ),
    .o_cnt   ( w_cnt_a_005 )
   );

   grey m_grey_b_005
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_005 ),

    .o_roll  ( w_roll_b_005 ),
    .o_cnt   ( w_cnt_b_005 )
   );

////////////////////////////////////////
   wire       w_roll_a_011, w_roll_b_011;
   wire [4:0] w_cnt_a_011, w_cnt_b_011;

   grey m_grey_a_011
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_011 ),

    .o_roll  ( w_roll_a_011 ),
    .o_cnt   ( w_cnt_a_011 )
   );

   grey m_grey_b_011
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_011 ),

    .o_roll  ( w_roll_b_011 ),
    .o_cnt   ( w_cnt_b_011 )
   );

////////////////////////////////////////
   wire       w_roll_a_023, w_roll_b_023;
   wire [4:0] w_cnt_a_023, w_cnt_b_023;

   grey m_grey_a_023
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_023 ),

    .o_roll  ( w_roll_a_023 ),
    .o_cnt   ( w_cnt_a_023 )
   );

   grey m_grey_b_023
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_023 ),

    .o_roll  ( w_roll_b_023 ),
    .o_cnt   ( w_cnt_b_023 )
   );

////////////////////////////////////////
   wire       w_roll_a_047, w_roll_b_047;
   wire [4:0] w_cnt_a_047, w_cnt_b_047;

   grey m_grey_a_047
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_047 ),

    .o_roll  ( w_roll_a_047 ),
    .o_cnt   ( w_cnt_a_047 )
   );

   grey m_grey_b_047
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_047 ),

    .o_roll  ( w_roll_b_047 ),
    .o_cnt   ( w_cnt_b_047 )
   );

////////////////////////////////////////
   wire       w_roll_a_097, w_roll_b_097;
   wire [4:0] w_cnt_a_097, w_cnt_b_097;

   grey m_grey_a_097
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_097 ),

    .o_roll  ( w_roll_a_097 ),
    .o_cnt   ( w_cnt_a_097 )
   );

   grey m_grey_b_097
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_097 ),

    .o_roll  ( w_roll_b_097 ),
    .o_cnt   ( w_cnt_b_097 )
   );

////////////////////////////////////////
   wire       w_roll_a_197, w_roll_b_197;
   wire [4:0] w_cnt_a_197, w_cnt_b_197;

   grey m_grey_a_197
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_clk_197 ),

    .o_roll  ( w_roll_a_197 ),
    .o_cnt   ( w_cnt_a_197 )
   );

   grey m_grey_b_197
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_197 ),

    .o_roll  ( w_roll_b_197 ),
    .o_cnt   ( w_cnt_b_197 )
   );

////////////////////////////////////////
   wire       w_roll_a_clk, w_roll_b_clk;
   wire [4:0] w_cnt_a_clk, w_cnt_b_clk;

   grey m_grey_a_clk
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( clk ),

    .o_roll  ( w_roll_a_clk ),
    .o_cnt   ( w_cnt_a_clk )
   );

   grey m_grey_b_clk
   (
    .i_clk   ( clk ),
    .i_rst   ( w_rst ),
    .i_cnt   ( w_roll_a_clk ),

    .o_roll  ( w_roll_b_clk ),
    .o_cnt   ( w_cnt_b_clk )
   );

////////////////////////////////////////
   mux m_mux
   (
    .i_clk        ( clk ),
    .i_rst        ( w_rst ),
    .i_sel        ( w_sel ),

    .i_cnt_a_005  ( w_cnt_a_005 ),
    .i_roll_a_005 ( w_roll_a_005 ),
    .i_cnt_b_005  ( w_cnt_b_005 ),
    .i_roll_b_005 ( w_roll_b_005 ),

    .i_cnt_a_011  ( w_cnt_a_011 ),
    .i_roll_a_011 ( w_roll_a_011 ),
    .i_cnt_b_011  ( w_cnt_b_011 ),
    .i_roll_b_011 ( w_roll_b_011 ),

    .i_cnt_a_023  ( w_cnt_a_023 ),
    .i_roll_a_023 ( w_roll_a_023 ),
    .i_cnt_b_023  ( w_cnt_b_023 ),
    .i_roll_b_023 ( w_roll_b_023 ),

    .i_cnt_a_047  ( w_cnt_a_047 ),
    .i_roll_a_047 ( w_roll_a_047 ),
    .i_cnt_b_047  ( w_cnt_b_047 ),
    .i_roll_b_047 ( w_roll_b_047 ),

    .i_cnt_a_097  ( w_cnt_a_097 ),
    .i_roll_a_097 ( w_roll_a_097 ),
    .i_cnt_b_097  ( w_cnt_b_097 ),
    .i_roll_b_097 ( w_roll_b_097 ),

    .i_cnt_a_197  ( w_cnt_a_197 ),
    .i_roll_a_197 ( w_roll_a_197 ),
    .i_cnt_b_197  ( w_cnt_b_197 ),
    .i_roll_b_197 ( w_roll_b_197 ),

    .i_cnt_a_clk  ( w_cnt_a_clk ),
    .i_roll_a_clk ( w_roll_a_clk ),
    .i_cnt_b_clk  ( w_cnt_b_clk ),
    .i_roll_b_clk ( w_roll_b_clk ),

    .o_out        ( uo_out ),
    .o_out2       ( uio_out[3:0] )
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
