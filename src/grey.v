`default_nettype none
`timescale 1ns/1ps

  module grey #( parameter pINIT = 'd0 )
  (
   input        i_clk,
   input        i_rst,
   input        i_cnt,

   output       o_roll,
   output [4:0] o_cnt
  );

   localparam pZERO        = 'b11000;
   localparam pONE         = 'b11001;
   localparam pTWO         = 'b10001;
   localparam pTHREE       = 'b10011;
   localparam pFOUR        = 'b00011;
   localparam pFIVE        = 'b00111;
   localparam pSIX         = 'b00110;
   localparam pSEVEN       = 'b01110;
   localparam pEIGHT       = 'b01100;
   localparam pNINE        = 'b11100;

////////////////////////////////////////
   wire       w_rst;
   rst m_rst
   (
    .i_clk   ( i_clk ),
    .i_rst_n ( ~ i_rst ),
    .o_rst   ( w_rst )
   );

////////////////////////////////////////
   reg        r_rst        = 'b1;
   reg        r_rst_done   = 'b0;

   always @( posedge i_clk )
     if( w_rst )
       r_rst              <= 'b1;
     else if( r_rst_done )
       r_rst              <= 'b0;


////////////////////////////////////////
   reg [4:0]  r_grey       = f_init_grey( pINIT );
   assign     o_cnt        = r_grey;

   always @( posedge i_cnt )
     if( r_rst ) begin
        r_grey            <= f_init_grey( pINIT );
        r_rst_done        <= 'b1;
     end
     else if( i_cnt ) begin
        r_grey            <= f_grey( r_grey );
        r_rst_done        <= 'b0;
     end

////////////////////////////////////////
   reg        r_roll       = 'b0;
   assign     o_roll       = r_roll;

   always @( posedge i_cnt )
     if( r_rst )
       r_roll             <= 'b0;
     else if( i_cnt )
       r_roll             <= r_grey == pNINE;

////////////////////////////////////////
   function [4:0] f_init_grey( input [4:0] i_val );
      case( i_val )
        'd1:     f_init_grey  = pONE;
        'd2:     f_init_grey  = pTWO;
        'd3:     f_init_grey  = pTHREE;
        'd4:     f_init_grey  = pFOUR;
        'd5:     f_init_grey  = pFIVE;
        'd6:     f_init_grey  = pSIX;
        'd7:     f_init_grey  = pSEVEN;
        'd8:     f_init_grey  = pEIGHT;
        'd9:     f_init_grey  = pNINE;
        default: f_init_grey  = pZERO;
      endcase
   endfunction

////////////////////////////////////////
   function [4:0] f_grey( input [4:0] i_val );
      case( i_val )
        pZERO:   f_grey  = pONE;
        pONE:    f_grey  = pTWO;
        pTWO:    f_grey  = pTHREE;
        pTHREE:  f_grey  = pFOUR;
        pFOUR:   f_grey  = pFIVE;
        pFIVE:   f_grey  = pSIX;
        pSIX:    f_grey  = pSEVEN;
        pSEVEN:  f_grey  = pEIGHT;
        pEIGHT:  f_grey  = pNINE;
        default: f_grey  = pZERO;
      endcase
   endfunction

endmodule
