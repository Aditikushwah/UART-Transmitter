`timescale 1ns/1ps

 module uart_tb ();	
 parameter  clk_per_ns= 100;
parameter c_CLKS_PER_BIT= 87;
parameter c_BIT_PERIOD = 8600;
   
  reg r_Clock = 0;
  reg r_Tx_DV = 0;
  wire w_Tx_Done;
  reg [7:0] r_Tx_Byte = 0;
  
  uart_tx m1(.i_Clock(r_Clock),
     .i_Tx_DV(r_Tx_DV),
     .i_Tx_Byte(r_Tx_Byte),
     .o_Tx_Active(),
     .o_Tx_Serial(),
     .o_Tx_Done(w_Tx_Done)
     );
 always
    #(clk_per_ns/2) r_Clock <= !r_Clock;
 initial
 begin
 $dumpfile("uart_tb.vcd");
	$dumpvars(0,uart_tb);
       @(posedge r_Clock);
      r_Tx_DV <= 1'b1;
      @(posedge r_Clock);
      r_Tx_Byte <= 8'b1100011;
      @(posedge r_Clock);
      r_Tx_DV <= 1'b0;
      @(posedge w_Tx_Done);#10
      
       @(posedge r_Clock);
      r_Tx_DV <= 1'b1;
      @(posedge r_Clock);
      r_Tx_Byte <= 8'b110001;
      @(posedge r_Clock);
      r_Tx_DV <= 1'b0;
      @(posedge w_Tx_Done);#2
      
      
      
       
      $finish;
      
   end
endmodule
