`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 09:25:52 PM
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tb;



	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 100.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam DATABIT         = 8;
	localparam TICK_STOPBIT    = 16;
	localparam FIFO_WIDTH      = 2;

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clock and reset
	logic sys_clk, reset;
	
    // Logic
    logic rd_uart, wr_uart;
	logic loopback_wire;
	logic [7:0] w_data, r_data;
	logic [10:0] dvsr;
	logic tx_full;
	logic rx_empty;
	
    // -------------------------------------------------------------------------
	// Clk generator
	// -------------------------------------------------------------------------
	//
	initial begin
		sys_clk = 1'b0;
		forever begin
			#(REFCLK_PERIOD/2) sys_clk = ~sys_clk;
		end
	end
	
	
	// -------------------------------------------------------------------------
	// Reads from the rxfifo if its not empty
	// -------------------------------------------------------------------------
	//
	initial begin

       rd_uart = 1'b0;
       
	   forever begin
	   @(sys_clk)
	       if(~rx_empty) begin
	       
	           // start transmit 
		      #(1*REFCLK_PERIOD);
		      @(posedge sys_clk);
		      rd_uart = 1'b1;
		      
		      #(1*REFCLK_PERIOD);
		      @(posedge sys_clk);
		      rd_uart = 1'b0;
		      end
        end
    end
	       
	
    // -------------------------------------------------------------------------
	// Reset generator and RX data
	// -------------------------------------------------------------------------
	//
	initial begin
		reset = 1'b0;
		dvsr = 10'h2;
		
		// Synchronous assertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b1;
		
		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b0;
		w_data = 8'hAA;
		
		// start transmit 
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b1;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b0;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		w_data = 8'hAB;
		
		// start transmit 
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b1;

		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b0;
		
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		w_data = 8'hAC;
		
		// start transmit 
		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b1;

		#(1*REFCLK_PERIOD);
		@(posedge sys_clk);
		wr_uart = 1'b0;
	
	end

	uart #(.DBIT(DATABIT), .SB_TICK(TICK_STOPBIT), .FIFO_W(FIFO_WIDTH)) u0
	      (
	       .clk        (sys_clk),
	       .reset      (reset),
	       .rd_uart    (rd_uart),
	       .wr_uart    (wr_uart),
	       .rx         (loopback_wire),
	       .w_data     (w_data),
	       .dvsr       (dvsr),
	       .tx_full    (tx_full),
	       .rx_empty   (rx_empty),
	       .tx         (loopback_wire),
	       .r_data     (r_data)
	       );
   


	// -------------------------------------------------------------------------
	// RX In Generator
	// -------------------------------------------------------------------------
	//

	initial begin
		$display(" ");
		$display("==========================================================");
		$display("RX Generator simulation");
		$display("==========================================================");
		$display(" ");
		
		
		
		// Wait
		#(500*REFCLK_PERIOD);
		
		
		

		// --------------------------------------------------------------------
		// End simulation
		// --------------------------------------------------------------------
		//
		$display(" ");
		$display("----------------------------------------------------------");
		$display("End simulation");
		$display("----------------------------------------------------------");
		$display(" ");
		
		end
		
endmodule
