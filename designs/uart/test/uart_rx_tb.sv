`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/02/2021 01:32:37 PM
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb;

	// Local parameters
	// ------------------------------------------------------------------------

	localparam real REFCLK_FREQUENCY      = 33.00e6; 


	// Clock periods
	localparam time REFCLK_PERIOD      = (1.0e9/REFCLK_FREQUENCY)*1ns;
	
	localparam DATABIT     = 8;
	
	localparam TICK_STOPBIT   = 16;
	
	

	// -------------------------------------------------------------------------
	// Internal Signals
	// -------------------------------------------------------------------------
	//
	// Clock and reset
	logic sys_clk, reset;
	
    // Logic
    logic [10:0] dvsr;
    // Output Logic
    logic tick, rx_done_tick, rx;
    
    logic [7:0] dout;
    
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
	// Reset generator and RX data
	// -------------------------------------------------------------------------
	//
	initial begin
		reset = 1'b0;
		
		dvsr = 10'h1;
		
		// rx uart is idle
		rx = 1'b1;
		
		// Synchronous assertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b1;
		
		// Synchronous deassertion of reset
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		reset = 1'b0;
		
		// start bit
		#(REFCLK_PERIOD);
		@(posedge sys_clk);
		rx = 0;
		
		// Data
		#(REFCLK_PERIOD);
		@(posedge sys_clk);
		rx = 1'b1;

        #(10*8*REFCLK_PERIOD);
		@(posedge sys_clk);
		rx = 1;
		
		// stop bit
		#(10*REFCLK_PERIOD);
		@(posedge sys_clk);
		rx = 1;			
		
	end
	
	baud_gen u0
	(
	   .clk    (sys_clk),
	   .reset  (reset),
	   .dvsr   (dvsr),
	   .tick   (tick)
	   );
	   
    uart_rx #(.DBIT(DATABIT), .SB_TICK(TICK_STOPBIT)) u1
    (
        .clk    (sys_clk),
        .reset  (reset),
        .rx     (rx),
        .s_tick (tick),
        .rx_done_tick,
        .dout   (dout)
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
		#(300*REFCLK_PERIOD);
		

		// --------------------------------------------------------------------
		// End simulation
		// --------------------------------------------------------------------
		//
		$display(" ");
		$display("----------------------------------------------------------");
		$display("End simulation");
		$display("----------------------------------------------------------");
		$display(" ");
		$stop(0);
	end
	
endmodule
