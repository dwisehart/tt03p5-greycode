`default_nettype none
`timescale 1ns/1ps

`ifdef GL_TEST

////////////////////////////////////////
  module tb
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

   tt_um_greycode_top m_top
   (
    .vccd1   ( 1'b1 ),
    .vssd1   ( 1'b0 ),

    .ena     ( ena ),
    .clk     ( clk ),
    .rst_n   ( rst_n ),

    .ui_in   ( ui_in ),
    .uo_out  ( uo_out ),

    .uio_in  ( uio_in ),
    .uio_out ( uio_out ),
    .uio_oe  ( uio_oe )
   );

`else

////////////////////////////////////////
  module tb
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

   initial begin
      $dumpfile ("tb.vcd");
      $dumpvars (0, tb);
      #1;
   end

   assign ui_in  = uo_out;  // For compare and latency check.

   tt_um_greycode_top #( .pTEST( 'b1 ) ) m_top
   (
    .ena     ( ena ),
    .clk     ( clk ),
    .rst_n   ( rst_n ),

    .ui_in   ( ui_in ),
    .uo_out  ( uo_out ),

    .uio_in  ( uio_in ),
    .uio_out ( uio_out ),
    .uio_oe  ( uio_oe )
   );

`endif

endmodule
